%% numerics.conRandMatrix.private.hgaussian
% Scaled edge length function h(x,y)
%
% Creates a gaussian distributed edge length
%
function h= hgaussian(p, varargin)
%% Release: 1.5

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

checkArgument(p, 'p', 'double', '1st');

%%

N= size(p,1);

x= (1:1:N)';

mu= mean(x);
% 99.7 % aller Werte > 0 liegen im Intervall [mu - 3*sigma, mu +
% 3*sigma] 
sigma= mu/3;

% range from 0.5 ... 2
h= 2 - 1.75* exp( - ( x - mu ).^2 ./ ( 2 * sigma^2 ) );

%%


