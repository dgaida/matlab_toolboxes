%% median_index
% Get median of a double matrix or vector and the index of the median
% inside A
%
function [median_value, index]= median_index(A, varargin)
%% Release: 1.4

% http://stackoverflow.com/questions/6981431/getting-index-of-median-value-in-matlab
% 

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

if nargin >= 2 && ~isempty(varargin{1})
  dim= varargin{1};
  isN(dim, 'dim', 2);
else
  dim= 1;
end

%%
% check argument

checkArgument(A, 'A', 'double', '1st');

%%

if dim == 2
  A= A';
end

%%

median_value= zeros(1, size(A, 2));
index= zeros(1, size(A, 2));

for icol= 1:size(A, 2)

  A_col= A(:, icol);
  
  %%
  % sort A

  [Asorted, indsort]= sortrows(A_col);

  %%
  
  ind= ( find(Asorted > median(Asorted), 1) + ...
         find(Asorted < median(Asorted), 1, 'last') ) / 2;

  index(1, icol)= indsort(fix(ind));

  median_value(1, icol)= A_col( index(1, icol) );
  
end

%%

if dim == 2
  
  median_value= median_value(:);
  index= index(:);
  
end

%%


