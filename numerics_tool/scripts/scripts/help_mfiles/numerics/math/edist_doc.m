%% Syntax
%       d= numerics.math.edist(x, y)
%
%% Description
%
% |d= edist(x, y)| calculates the euclidian distance between the two
% vectors |x| and |y|. The euclidian distance is defined as:
%
% $$d := \sqrt{ \sum_{i=1}^{N} \left( x_i - y_i \right)^2 }$$
%
%%
% @param |x| : double vector or matrix of row vectors. Euclidian distance
% over row vectors is calculated. 
%
%%
% @param |y| : double vector or matrix of row vectors. Euclidian distance
% over row vectors is calculated. 
%
%%
% @return |d| : euclidian distance between the two vectors |x| and |y|.
% doube scalar. If |x| and |y| are matrices, then it is a column vector
% containing the euclidian distances of each row in the matrix. 
%
%% Example
% 
%

numerics.math.edist([1,2,3], [3,4,5])

%%

numerics.math.edist([1,2,3;3,4,5], [3,4,5;1,2,3])

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
% <a href="matlab:doc('ml_tool/discretizestate')">
% ml_tool/optimization.RL.RLearner.discretizeState</a>
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


