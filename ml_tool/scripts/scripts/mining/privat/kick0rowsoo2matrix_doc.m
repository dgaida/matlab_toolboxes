%% Syntax
%       matrix= kick0rowsoo2matrix(matrix)
%       
%% Description
% |matrix= kick0rowsoo2matrix(matrix)| kicks zero rows (row containing only
% 0s) out of square matrix. If ith row is deleted then is also ith column,
% always returning a square matrix. If, after kicking the first zero row
% and column out, a further zero row appears this is deleted as well, and
% so on. 
%
%%
% @param |matrix| : square double matrix possibly containing 0 rows
%
%%
% @return |matrix| : square double matrix, values ar the same as in given matrix, but
% without 0 rows. Rows which contained only 0s are deleted. If a row is deleted,
% then the corresponding column is also deleted, such that the matrix keeps
% quadratic. 
% 
%% Example
% 
% # In the given data |theta| class 2 is missing

theta= fix(4*rand(100,1));
theta_hat= max(min(theta + round(1.8*rand(100,1) - 0.9), 3), 0);

theta_hat(theta == 2)= [];
theta(theta == 2)= [];

confMatrix= calcConfusionMatrix(theta, theta_hat);

disp(confMatrix);

confMatrix_red= kick0rowsoo2matrix(confMatrix);

disp(confMatrix_red);

%%
%

kick0rowsoo2matrix([0 0 0; 1 0 0; 1 2 3])

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
% <a href="matlab:doc('ml_tool/calcconfusionmatrix')">
% ml_tool/calcConfusionMatrix</a>
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
% <a href="matlab:doc('ml_tool/kicknansoo2matrix')">
% ml_tool/kickNaNsoo2matrix</a>
% </html>
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


