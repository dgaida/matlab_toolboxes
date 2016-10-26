%% numerics.conRandMatrix.private.hlhsamp
% Scaled edge length function h(x,y)
%
% Creates a latin hypercube distributed edge length
%
function h= hlhsamp(p, varargin)
%% Release: 1.0

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

checkArgument(p, 'p', 'double', '1st');

%%

N= size(p,1);

% range from 0.5 ... 2
h= 2 - 1.75* lhsamp(N, 1);

%%


