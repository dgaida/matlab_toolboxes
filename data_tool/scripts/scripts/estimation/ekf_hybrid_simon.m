%% ekf_hybrid_simon
% Hybrid Extended Kalman Filter implementation out of Dan Simon's book: Optimal
% State Estimation
%
function [xp, varargout]= ekf_hybrid_simon(f, h, fA, fB, fC, u, y, varargin)
%% Release: 1.0

%%

error( nargchk(7, 14, nargin, 'struct') );
error( nargoutchk(0, 5, nargout, 'struct') );

%%

% continuous system function
checkArgument(f, 'f', 'function_handle', '1st');
% continuous measurement function
checkArgument(h, 'h', 'function_handle', '2nd');

% cont. linearized system function: A
checkArgument(fA, 'fA', 'function_handle', '3rd');
% cont. linearized system function: B
checkArgument(fB, 'fB', 'function_handle', 4);
% cont. or discrete linearized measurement function: C
% discrete and continuous are the same
checkArgument(fC, 'fC', 'function_handle', 5);

checkArgument(u, 'u', 'double', 6);   % input
checkArgument(y, 'y', 'double', 7);   % output/measurement

if isvector(u)
  u= u(:);
end

if isvector(y)
  y= y(:);
end

if nargin >= 8 && ~isempty(varargin{1})
  Q= varargin{1};
  checkArgument(Q, 'Q', 'double', 8);
  
  if isvector(Q) || size(Q, 1) ~= size(Q, 2)  % then the noise is given as a vector
    %% TODO
    % müsste hier nicht noch B rein multipliziert werden?
    % wegen interpretation unten
    % nein muss nicht, da in implementierung unten die ableitungsmatrix
    % df/domega noch genutzt wird, das ist laut Interpretation dann B.
    
    std_dev= std(Q)';  % returns a row vector, transposed gives a column vector
    
    Q= diag(std_dev.^2);
  end
  
else
  % Q wird folgendermaßen interpretiert:
  % x(k+1) = A * x(k) + B * ( u(k) + w(k) )
  % x(k+1) = A * x(k) + B * u(k) + B * w(k)
  % q(k) := B * w(k)
  % q(k) ist ein Zufallsprozess mit Mittelwert 0 und
  % Kovarianzmatrix Q
  
  % assuming u is given as u= [input 1, input 2, ...]
  % each input i is a column vector
  %std_dev= std(u)';  % returns a row vector, transposed gives a column vector
  
  std_dev= 0.01 .* ones(size(u, 2), 1);
  
  %% TODO
  % u darf nicht die verrauschte Größe sein, sondern eine deterministische
  % damit kann Q nicht über u geschätzt werden, sondern nur über w. D.h.
  % entweder auch w übergeben oder direkt Q.
  
  % each column of B corresponds to one input. 
  % for a system with 3 states and 2 inputs we have
  %
  %           (std_dev1)
  %           (std_dev2)
  % (b11 b12)
  % (b21 b22)
  % (b31 b32)
  %
  % returns a column vector, which contains the diagonal elements of Q
  %
  Q= diag(std_dev.^2);
end

if nargin >= 9 && ~isempty(varargin{2})
  R= varargin{2};
  checkArgument(R, 'R', 'double', 9);
else
  % assuming y is given as y= [measurement 1, measurement 2, ...]
  % each measurement i is a column vector
  std_dev= std(y);
  
  R= diag(std_dev.^2);
end

if nargin >= 10 && ~isempty(varargin{3})
  x0= varargin{3};
  isRn(x0, 'x0', 10);
  x0= x0(:);
else
  error('You must provide the initial state x0!');
end

if nargin >= 11 && ~isempty(varargin{4})
  P0= varargin{4};
  checkArgument(P0, 'P0', 'double', 11);
else
  %% TODO - should be dependent on x0, not each component should have std.
  % dev 0.001
%   std_dev_x= 0.001;
%   P0= std_dev_x^2 .* eye(size(x0, 1));
  
  std_dev_x= 0.001 * x0;
  P0= diag(std_dev_x.^2);
end

if nargin >= 12 && ~isempty(varargin{5})
  toiteration= varargin{5};
  isN(toiteration, 'toiteration', 12);
else
  toiteration= 10000;
end

if nargin >= 13 && ~isempty(varargin{6})
  sampletime= varargin{6};
  isR(sampletime, 'sampletime', 13);
else
  sampletime= 1/24;   % 1/24 der zeitkonstante des Modells, falls Modell
  % in Tagen gemessen wird, dann Interpretation: sampletime= 1 h
end

if nargin >= 14 && ~isempty(varargin{7})
  u_sample= varargin{7};
  isR(u_sample, 'u_sample', 14);
else
  u_sample= 1;    % that means same sample time as |sampletime|
end

%%

%c_time= round(t + 1);

%%
% covariance matrix of the estimation error (posteriori "+")

Pp(:,:,1)= P0;

% state x (posteriori "+")
xp(:,1)= x0(:);

% init variables

Pm(:,:,1)= zeros(size(P0));
Pm(:,:,2)= zeros(size(P0));
K(:,:,1)= zeros( size(x0,1), size(y, 2) );
K(:,:,2)= zeros( size(x0,1), size(y, 2) );
xm(:,1)= zeros(numel(x0), 1);
xm(:,2)= zeros(numel(x0), 1);

%%

opt= odeset('RelTol',1e-4,'AbsTol',1e-6);%,'OutputFcn',@debugode);

%%
% Kalman Filter 
for iter=2:toiteration
  
  %%
  % integrate the system into one vector xP
  
  Pk_1p= Pp(:, :, iter - 1);
  xP= [xp(:, iter - 1); Pk_1p(:)];
  
  %% 
  % nicht einfach von 0 bis 1 integrieren, sondern von 0 bis sampletime
  % u muss auch noch überdacht werden, welche zeitabstände hat u, am besten
  % sampletime
  
  if u_sample < 1
    [tsim, xsim]= ode15s( @ekf_hybrid_inner, ...
                          0:u_sample*sampletime:sampletime*(1 - u_sample), xP, opt, ...
                          f, fA, fB, ...
                          u((iter - 2)*1/u_sample + 1:(iter - 1)*1/u_sample, :), ...
                          Q);
  else % für u_sample= 1, läuft der obere ausdruck asl grenzwert zu
  %diesem hier, stimmt nicht, da für u_sample= 1: oben: 0:sampletime:0, was
  %0 ist
  % - eps wird nur gemacht, damit c_time, welche in dem Modell berechnet
  % wird nich auf 2 springt, da ja nur 1 u übergeben wird, s.
  % round(t/deltatk + 0.5)
    [tsim, xsim]= ode15s( @ekf_hybrid_inner, [0 sampletime - eps], xP, opt, ...
                          f, fA, fB, u(iter - 1, :), Q);
  end
  
  %%
  
  xP= xsim(end,:);
  
  %% 
  % split xP into x and P

  %% TODO
  % weiß nicht ob das immer gilt, doch müsste schon, ansonsten ist n=
  % numel(x0), x0 ist eh immer gegeben
  % numel(xP)= n^2 + n
  % sqrt(n^2 + n) = sqrt(n^2 * (1 + 1/n)) = n * sqrt( 1 + 1/n )
  % sqrt( 1 + 1/n ) < 1.5 ? stimmt, da max. = sqrt(2) für n = 1, = 1.414
  % nur n > 1 ist 1/n monoton fallend, deshalb wird der ausdruck nie größer
  % als sqrt 2
  %n= fix(sqrt( numel(xP) ));
  n= numel(x0);

  xm(:,iter)= xP(1:n);
  P= xP(n + 1:end);

  Pm(:,:,iter)= reshape(P, n, n);

  %%
  % current time (das wäre die absolute Zeit), man kann aber auch mit
  % relativer arbeiten, wenn man u immer richtig indiziert
  %cur_t= (iter - 1)*sampletime; % after 1st simulation it is sampletime
  
  %%
  % make A, B, C time dependent

  if nargin(fC) == 1
    C= feval(fC, xm(:,iter));
  else
    %% 
    % eval fC am Ende der sampletime, oder am anfang? s. Dan Simon?
    % am ende der sampletime, da xm dazu gehört, aus dem übergebenen u wird
    % nur das letzte element raus genommen. ok so.
    %% TODO
    % C darf eigentlich nicht von u abhängen, das wäre dann D
    % in ADode6_ABC gibt es eine sehr indirekte Abhängigkeit von C hängt ab
    % von Bic über H^+ Konz., siehe Kommentare dort bei C Berechnung.
    if u_sample < 1
      C= feval(fC, sampletime*(1 - u_sample), xm(:,iter), ...
               u((iter - 2)*1/u_sample + 1:(iter - 1)*1/u_sample, :));
    else
      C= feval(fC, sampletime, xm(:,iter), u(iter - 1, :));
    end
  end

  %%

  % Kalman Gain K
  % K(k)= P(k)^- * C^T * ( C * P(k)^- * C + R(k) )^(-1)
  % K(:,:,iter)= Pm(:,:,iter) * C' * inv( C * Pm(:,:,iter) * C' + R );
  K(:,:,iter)= Pm(:,:,iter) * C' / ( C * Pm(:,:,iter) * C' + R );

  if nargin(h) == 1
    myh= feval(h, xm(:,iter)');
  else
    myh= feval(h, xm(:,iter)', u((iter - 1)*1/u_sample, :));
  end
  
  % state x update (posteriori "+")
  % x(k)^+ = x(k)^- + K(k) * ( y(k) - C(k) * x(k)^- )
  xp(:,iter)= xm(:,iter) + K(:,:,iter) * ( y(iter,:)' - myh' );

  % covariance matrix P (posteriori "+")
  % P(k)^+ = ( I - K(k) * C ) * P(k)^- * ( I - K(k) * C )^T + K(k) * R(k) *
  % K(k)^T
  Pp(:,:,iter)= ( eye(size(K(:,:,iter), 1), size(C, 2)) - K(:,:,iter) * C ) * ...
                Pm(:,:,iter) * ...
                ( eye(size(K(:,:,iter), 1), size(C, 2)) - K(:,:,iter) * C )' + ...
                K(:,:,iter) * R * K(:,:,iter)';

  %%
  
end

%%

if nargout >= 2
  varargout{1}= xm;
end

if nargout >= 3
  varargout{2}= Pp;
end

if nargout >= 4
  varargout{3}= Pm;
end

if nargout >= 5
  varargout{4}= K;
end

%%



%%
%
function [x_Pdot]= ekf_hybrid_inner(t, xP, f, fA, fB, u, Q)

%%



%%

%c_time= round(t + 1);

%%
% Kalman Filter 
  
%% 
% split xP into x and P

n= fix(sqrt( numel(xP) ));

x= xP(1:n);
P= xP(n + 1:end);

P= reshape(P, n, n);

%%
% make A, B, C time dependent

if nargin(fA) == 1
  A= feval(fA, x);
  B= feval(fB, x);
else
  A= feval(fA, t, x, u);
  B= feval(fB, t, x, u);
end

%%

% state x update 
xdot= feval(f, t, x, u);%(c_time,:));

% covariance matrix P 
Pdot= A * P + P * A' + B * Q * B';

%%

x_Pdot= [xdot; Pdot(:)];

%%


