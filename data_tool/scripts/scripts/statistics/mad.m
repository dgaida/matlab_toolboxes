%% mad
% Computing the Median Absolute Deviation of X
%
function m= mad(X)
%% Release: 1.5

% MAD computes the median absolute deviation of X. If X is
%  a matrix, MAD is a row vector containing the MAD's of the
%  columns of X.
%
% ! Includes correction for consistency !
%
% Written by S. Serneels, 17.12.2003

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

checkArgument(X, 'X', 'double', '1st');

%%

[n, p]= size(X);

% nanmedian returns for matrix input a row vector containing the
% median value of non-NaN elements in each column.
Xmc= X - repmat(nanmedian(X), n, 1);

% returns 1.4826 * median( | median(X) | )

m= 1.4826 * nanmedian(abs(Xmc));

%%


