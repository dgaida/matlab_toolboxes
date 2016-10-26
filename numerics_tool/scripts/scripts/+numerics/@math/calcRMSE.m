%% calcRMSE
% Calculates the root mean squared error (deviation) between the double
% vectors |x| and |y|.
%
function rmse= calcRMSE(x, y)
%% Release: 1.9

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin < 2
  y= zeros(numel(x),1);
end

%%
% check params

isRn(x, 'x', 1);
isRn(y, 'y', 2);


%%
%

x= x(:);
y= y(:);

%%

N= numel(x);

if (N ~= numel(y))
  error('numel(x) ~= numel(y) : %i ~= %i', N, numel(y));
end

if (N <= 0)
  error('x is neither a scalar nor a vector, its dimension is %i!', N);
end

%%

rmse= sqrt( ( x - y )' * ( x - y ) / N );

%%


