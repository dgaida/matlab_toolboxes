%% kalman_discrete_simon
% Discrete Kalman Filter implementation out of Dan Simon's book: Optimal
% State Estimation
%
function [xp, varargout]= kalman_discrete_simon(A, B, C, D, u, y, varargin)
%% Release: 1.2

%%

error( nargchk(6, 11, nargin, 'struct') );
error( nargoutchk(0, 5, nargout, 'struct') );

%%

checkArgument(A, 'A', 'double || function_handle', '1st');
checkArgument(B, 'B', 'double || function_handle', '2nd');
checkArgument(C, 'C', 'double || function_handle', '3rd');
%checkArgument(D, 'D', 'double', 4);

checkArgument(u, 'u', 'double', 5);
checkArgument(y, 'y', 'double', 6);

if isvector(u)
  u= u(:);
end

if isvector(y)
  y= y(:);
end

%%
% x0 is needed for the next param

if nargin >= 9 && ~isempty(varargin{3})
  x0= varargin{3};
  isRn(x0, 'x0', 9);
else
  if isa(A, 'function_handle')
    error('If A is a function_handle, you must provide the initial state x0!');
  else
    x0= zeros(size(A, 1), 1);
  end
end

if isa(A, 'function_handle')
  A0= feval(A, x0);
else
  A0= A;
end

if isa(B, 'function_handle')
  B0= feval(B, x0);
else
  B0= B;
end

if isa(C, 'function_handle')
  C0= feval(C, x0);
else
  C0= C;
end

if nargin >= 7 && ~isempty(varargin{1})
  Q= varargin{1};
  checkArgument(Q, 'Q', 'double', 7);
  
  if isvector(Q) || size(Q, 1) ~= size(Q, 2)  % then the noise is given as a vector
    std_dev= std(Q)';  % returns a row vector, transposed gives a column vector
    
    Q= diag(B0 * std_dev.^2);
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
  Q= diag(B0 * std_dev.^2);
end

if nargin >= 8 && ~isempty(varargin{2})
  R= varargin{2};
  checkArgument(R, 'R', 'double', 8);
else
  % assuming y is given as y= [measurement 1, measurement 2, ...]
  % each measurement i is a column vector
  std_dev= std(y);
  
  R= diag(std_dev.^2);
end

if nargin >= 10 && ~isempty(varargin{4})
  P0= varargin{4};
  checkArgument(P0, 'P0', 'double', 10);
else
  P0= 0.000001 .* eye(size(A0, 1));
end

if nargin >= 11 && ~isempty(varargin{5})
  toiteration= varargin{5};
  isN(toiteration, 'toiteration', 11);
else
  toiteration= 10000;
end

%%
% covariance matrix of the estimation error (posteriori "+")

Pp(:,:,1)= P0;

% state x (posteriori "+")
xp(:,1)= x0(:);

% init variables

Pm(:,:,1)= zeros(size(P0));
Pm(:,:,2)= zeros(size(P0));
K(:,:,1)= zeros( size(A0,1), size(C0, 1) );
K(:,:,2)= zeros( size(A0,1), size(C0, 1) );
xm(:,1)= zeros(numel(x0), 1);
xm(:,2)= zeros(numel(x0), 1);

%%

if isa(A, 'function_handle')
  fA= A;
end

if isa(B, 'function_handle')
  fB= B;
end

if isa(C, 'function_handle')
  fC= C;
end


%%
% test if system is observable

if ~exist('fA', 'var') && ~exist('fC', 'var')
  r= rank ( obsv( A, C ) );

  if r < size(A, 1)
    warning('system:notobservable', ...
            'the system is not observable: rank (%i) < %i', r, size(A, 1));
  end
end


%%
% Kalman Filter 
for iter=2:toiteration
  
  %%
  % make A, B, C time dependent
  
  if exist('fA', 'var')
    A= feval(fA, xp(:,iter - 1));
  end
  
  if exist('fB', 'var')
    B= feval(fB, xp(:,iter - 1));
  end
  
  if exist('fC', 'var')
    C= feval(fC, xp(:,iter - 1));
  end
  
  
  %%
  % test if system is observable

  if exist('fA', 'var') || exist('fC', 'var')
    r= rank ( obsv( A, C ) );

    if r < size(A, 1)
      warning('system:notobservable', ...
              'the system is not observable: rank (%i) < %i', r, size(A, 1));
    end
  end
  
  %%
  
  % covariance matrix P (priori "-")
  % P(k)^- = A * P(k-1)^+ * A^T + Q
  Pm(:,:,iter)= A * Pp(:,:,iter - 1) * A' + Q;

  % state x update (priori "-")
  % x(k)^- = A * x(k-1)^+ + B * u(k-1)
  xm(:,iter)= A * xp(:,iter - 1) + B * u(iter - 1,:)';

  % Kalman Gain K
  % K(k)= P(k)^- * C^T * ( C * P(k)^- * C + R(k) )^(-1)
  % K(:,:,iter)= Pm(:,:,iter) * C' * inv( C * Pm(:,:,iter) * C' + R );
  K(:,:,iter)= Pm(:,:,iter) * C' / ( C * Pm(:,:,iter) * C' + R );

  % state x update (posteriori "+")
  % x(k)^+ = x(k)^- + K(k) * ( y(k) - C(k) * x(k)^- )
  xp(:,iter)= xm(:,iter) + K(:,:,iter) * ( y(iter,:)' - C * xm(:,iter) );

  % covariance matrix P (posteriori "+")
  % P(k)^+ = ( I - K(k) * C ) * P(k)^- * ( I - K(k) * C )^T + K(k) * R(k) *
  % K(k)^T
  Pp(:,:,iter)= ( eye(size(K(:,:,iter), 1), size(C, 2)) - K(:,:,iter) * C ) * ...
                Pm(:,:,iter) * ...
                ( eye(size(K(:,:,iter), 1), size(C, 2)) - K(:,:,iter) * C )' + ...
                K(:,:,iter) * R * K(:,:,iter)';

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


