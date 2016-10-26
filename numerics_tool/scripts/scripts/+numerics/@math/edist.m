%% edist
% Calculate euclidian distance between two vectors or matrix of row vectors
%
function d= edist(x, y)
%% Release: 1.2

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check params

checkArgument(x, 'x', 'double', '1st');
checkArgument(y, 'y', 'double', '2nd');


%%
%

if isvector(x)
  x= x(:)';   % row vector
  y= y(:)';
end

%%

N= size(x, 2);

if (N ~= size(y, 2))
  error('size(x, 2) ~= size(y, 2) : %i ~= %i', N, size(y, 2));
end

if (N <= 0)
  error('x is neither a scalar nor a vector, its dimension is %i!', N);
end


%%
% sum over rows (2)

d= sqrt( sum( (x - y).^2, 2 ) );

%%


