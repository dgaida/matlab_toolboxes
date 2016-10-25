%% ekf_cont_simon
% Continuous Extended Kalman Filter implementation out of Dan Simon's book: Optimal
% State Estimation
%
function [x_Pdot]= ekf_cont_simon(t, xP, f, h, fA, fB, fC, u, y, varargin)
%% Release: 0.9

%%

error( nargchk(9, 11, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

warning('version:invalid', 'DO NOT USE THIS IMPLEMENTATION!');

%%

checkArgument(f, 'f', 'function_handle', '3rd');
checkArgument(h, 'h', 'function_handle', 4);

checkArgument(fA, 'fA', 'function_handle', 5);
checkArgument(fB, 'fB', 'function_handle', 6);
checkArgument(fC, 'fC', 'function_handle', 7);

checkArgument(u, 'u', 'double', 8);
checkArgument(y, 'y', 'double', 9);

if isvector(u)
  u= u(:);
end

if isvector(y)
  y= y(:);
end

if nargin >= 10 && ~isempty(varargin{1})
  Q= varargin{1};
  checkArgument(Q, 'Q', 'double', 10);
  
  if isvector(Q) || size(Q, 1) ~= size(Q, 2)  % then the noise is given as a vector
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

if nargin >= 11 && ~isempty(varargin{2})
  R= varargin{2};
  checkArgument(R, 'R', 'double', 11);
else
  % assuming y is given as y= [measurement 1, measurement 2, ...]
  % each measurement i is a column vector
  std_dev= std(y);
  
  R= diag(std_dev.^2);
end


%%

c_time= round(t + 1);

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

A= feval(fA, x);
B= feval(fB, x);
C= feval(fC, x);

%%

% Kalman Gain K
K= P * C' / R;

% state x update 
xdot= feval(f, x, u(c_time,:)) + K * ( y(c_time,:)' - feval(h, x') );

% covariance matrix P 
Pdot= A * P + P * A' + B * Q * B' - K * C * P;

%% constraint
%
% wenn P <= 0, dann setze Pdot auf null, allerdings nur für die betreffende
% Zustandsvektorkomponente.
%
%Pdot= Pdot(:) - ( ( P(:) <= 0 ) & ( Pdot(:) < 0 ) ) .* Pdot(:); 

%%

x_Pdot= [xdot; Pdot(:)];

%%


