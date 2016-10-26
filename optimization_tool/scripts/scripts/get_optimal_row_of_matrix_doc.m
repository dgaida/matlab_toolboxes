%% Syntax
%       [row_index, matrix]= get_optimal_row_of_matrix(matrix)
%       [row_index, matrix, matrix2nd]= get_optimal_row_of_matrix(matrix,
%       matrix2nd) 
%       [...]= get_optimal_row_of_matrix(matrix, matrix2nd, weights) 
%       [row_index, matrix, matrix2nd, matrix_indx]=
%       get_optimal_row_of_matrix(...)  
%       
%% Description
% |[row_index, matrix]= get_optimal_row_of_matrix(matrix)| gets row which
% has minimal mean ranking over all columns of given |matrix|. Each column
% of |matrix| is ranked, where as the minimal value of each column gets
% first rank. The row whose ranks are in sum minimal is returned as optimal
% row in |row_index|. |row_index| specifies the optimal row in the returned
% matrix |matrix| and not in the given |matrix|. 
%
%%
% @param |matrix| : a 2dim double matrix. Each row of the matrix is seen as
% one element. 
%
%%
% @return |row_index| : integer with index of optimal row of returned
% matrix |matrix|. 
%
%%
% @return |matrix| : same as given matrix |matrix|, sorted by last column. 
%
%%
% @param |matrix2nd| : a further matrix which must have same dimension as
% has |matrix|. It is sorted exactly as is returned |matrix|. Actually it
% is not difficult to sort a matrix as is done with |matrix|, because it is
% just sorted with respect to the last column. 
%
%%
% @return |matrix2nd| : the returned sorted matrix |matrix2nd|. 
%
%%
% @param |weights| : double row or column vector with as many elements as
% |matrix| has columns. Gives weighting factors to each column of |matrix|.
% As default each column has the same importance, thus as default all
% elements of |weights| are 1. 
%
%%
% @return |matrix_indx| : sum of ranks, this is a row vector with as many
% rows as has |matrix|. The |row_index| element should be minimal. 
%
%% Example
%
%

matrix= rand(6, 2);

disp(matrix)

[row_index, matrix]= get_optimal_row_of_matrix(matrix);

disp(row_index)

disp(matrix);

%%

[row_index, matrix, ~, matrix_indx]= get_optimal_row_of_matrix(matrix);

disp(matrix_indx)

%%

[row_index, matrix, ~, matrix_indx]= get_optimal_row_of_matrix(matrix, [], [10 1]);

disp(matrix_indx)

disp(row_index)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isrn">
% script_collection/isRn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/sortrows">
% matlab/sortrows</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% -
%
%% TODOs
% # improve code documentation
%
%% <<AuthorTag_DG/>>


