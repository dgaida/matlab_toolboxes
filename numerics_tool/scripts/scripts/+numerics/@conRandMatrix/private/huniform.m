%% numerics.conRandMatrix.private.huniform
% Scaled edge length function h(x,y)
%
% Creates a uniformly distributed edge length
%
function h= huniform(p, varargin)
%% Release: 1.9

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

checkArgument(p, 'p', 'double', '1st');

%%

h= ones(size(p,1), 1);

%%


