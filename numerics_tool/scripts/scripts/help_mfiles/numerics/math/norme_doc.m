%% Syntax
%       n= numerics.math.norme(X)
%
%% Description
%
% |n= numerics.math.norme(X)| calculates the euclidean norm of matrix X
% the output is a columnvector containing the norm of each row. 
%
%%
% @param |X| : double matrix
%
%%
% @return |n| : euclidean norm of matrix X
%
%% Example
% 
%

numerics.math.norme([1,2,3; 3,4,5])

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('sqrt')">
% matlab/sqrt</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('data_tool/l1median')">
% data_tool/L1median</a>
% </html>
%
%% See Also
%
% <html>
% <a href="calcrmse.html">
% numerics.math.calcRMSE</a>
% </html>
% ,
% <html>
% <a href="calcnormalizedrmse.html">
% numerics.math.calcNormalizedRMSE</a>
% </html>
% ,
% <html>
% <a href="matlab:doc math">
% numerics.math</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


