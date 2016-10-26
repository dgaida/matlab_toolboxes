%% get_optimal_row_of_matrix
% Get row which has minimal mean ranking over all columns of matrix
%
function [row_index, matrix, varargout]= get_optimal_row_of_matrix(matrix, varargin)
%% Release: 1.4

%%

error( nargchk(1, 3, nargin, 'struct') );
error( nargoutchk(2, 4, nargout, 'struct') );

%%

if nargin >= 2 && ~isempty(varargin{1})
  matrix2nd= varargin{1};
  
  checkArgument(matrix2nd, 'matrix2nd', 'double', '2nd');
else
  matrix2nd= [];
end

if nargin >= 3 && ~isempty(varargin{2})
  weights= varargin{2};
  
  isRn(weights, 'weights', 3);
  weights= weights(:);
else
  weights= ones(size(matrix, 2), 1);
end

%% 
% check matrix

checkArgument(matrix, 'matrix', 'double', '1st');

if ~isempty(matrix2nd)
  if any(size(matrix) ~= size(matrix2nd))
    error('size(matrix) ~= size(matrix2nd): [%i, %i] ~= [%i, %i]', ...
      size(matrix, 1), size(matrix, 2), size(matrix2nd, 1), size(matrix2nd, 2));
  end
end

%%
% es soll die zeile aus der paretofront genommen werden, deren summe v.
% indizes je spalte minimal ist, geg. eine sortierte paretofront je
% spalte. d.h. eine lösung die in allen spalten den ersten rang belegt
% wird immer bevorzugt. 

matrix_indx= matrix;

for icol= 1:size(matrix, 2)

  %%

  [matrix, indizes]= sortrows(matrix, icol);

  matrix_indx= matrix_indx(indizes, :);      
  
  %%
  % das ist eigentlich überflüssig, eigentlich müsste matrix2nd nur bei der
  % letzten spalte sortiert werden, da die sortierung keine vergangenheit
  % kennt
  if ~isempty(matrix2nd)
    matrix2nd= matrix2nd(indizes, :);
  end
  
  %%
  
  matrix_indx(:, icol)= 1:1:size(matrix, 1);

end

%% 
% mache das Ranking der ersten Spalte doppel so wichtig wie das ranking
% der anderen spalten
% könnte man so machen, momentan aber unwesentlich
%matrix_indx(:, 1)= 2 .* matrix_indx(:, 1);

weighted_sum= matrix_indx * weights;

%%
% zeile mit minimaler index summe
% val is the minimal sum of the indices, not used
[val, row_index]= min(weighted_sum);

%%

if nargout >= 3
  varargout{1}= matrix2nd;
end

if nargout >= 4
  varargout{2}= weighted_sum;
end

%%


