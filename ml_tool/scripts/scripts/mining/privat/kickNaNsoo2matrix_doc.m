%% Syntax
%       matrix= kickNaNsoo2matrix(matrix)
%       
%% Description
% |matrix= kickNaNsoo2matrix(matrix)| kicks NaNs out of square matrix. If
% ith row is deleted then is also ith col, always returning a square
% matrix. The NaNs are deleted row-size. 
%
%%
% @param |matrix| : square double matrix possibly containing NaNs
%
%%
% @return |matrix| : square double matrix, values are the same as in given matrix, but
% without NaNs. Rows which contained NaNs are deleted. If a row is deleted,
% then also the corresponding column is deleted, such that the matrix keeps
% quadratic. 
% 
%% Example
% 
% first delete 1st row and 1st col
% results in
%
% [3 4 0]
% [2 3 4]
% [6 NaN NaN]
%
% then delete 3rd row and column
%
% [3 4]
% [2 3]
% 

mymat= [0 1 NaN 1; 1 3 4 0; 1 2 3 4; 5 6 NaN NaN];

disp(mymat)

kickNaNsoo2matrix(mymat)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('ml_tool/classifierperformance')">
% ml_tool/classifierPerformance</a>
% </html>
% 
%% See Also
% 
% <html>
% <a href="startlda.html">
% startLDA</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/kick0rowsoo2matrix')">
% ml_tool/kick0rowsoo2matrix</a>
% </html>
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


