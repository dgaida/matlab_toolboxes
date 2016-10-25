%% deleteDuplicates
% Delete duplicates in dataset
%
function [X, y]= deleteDuplicates(X, y)
%% Release: 1.9

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

if ~isa(X, 'double') || numel(size(X)) ~= 2
  error(['The 1st parameter X must be a 2-dimensional ', ...
         '<a href="matlab:doc(''double'')">double</a> matrix, ', ...
         'but is a %i-dimensional <a href="matlab:doc(''%s'')">%s</a>!'], ...
         numel(size(X)), class(X), class(X));
end

if ~isa(y, 'double') || size(y, 1) ~= size(X, 1)
  error(['The 2nd parameter y must be a %i-dimensional ', ...
         '<a href="matlab:doc(''double'')">double</a> column vector or a ', ...
         'matrix with %i rows, ', ...
         'but is a %i-dimensional <a href="matlab:doc(''%s'')">%s</a>!'], ...
         size(X, 1), size(X, 1), size(y, 1), class(y), class(y));
end

%%
% sort rows and use diff to find identical rows in X

[Xsorted, indsort]= sortrows(X);

ind= all(diff(Xsorted)' == 0, 1);
ind= [0 ind];

%%
% sort ind such as the original data is sorted

ind= sortrows([indsort, ind']);
ind= ind(:, 2:end);

%%
% get not identical data

X= X(ind == 0, :);
y= y(ind == 0, :);

%%


