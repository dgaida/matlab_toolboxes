%% norme
% Calculate euclidean norm of matrix X
%
function n= norme(X)
%% Release: 1.5

%%

% NORME calculates the euclidean norm of matrix X
% the output is a columnvector containing the norm of each row
% I/O: n=norme(X);

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

checkArgument(X, 'X', 'double', '1st');

%%

n= sqrt( sum(X.^2, 2) );

%%


