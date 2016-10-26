%% Syntax
%       equal= numerics.math.approxEq(a)
%       equal= numerics.math.approxEq(a, b)
%       equal= numerics.math.approxEq(a, b, accuracy)
%
%% Description
% |equal= approxEq(a)| compares |a| with 0. If the absolute difference is 
% smaller or equal then 0.01 (+/- 0.005), then |equal|= 1, else 0
%
%%
% @param |a| : double matrix, vector or scalar
% 
%%
% @return |equal| : scalar
%
% * 1 : if a - 0.005 <= 0 && a + 0.005 >= 0
% * 0 : else
%
%%
% |equal= approxEq(a, b)| compares |a| with |b| on 0.01 accuracy.
%
%%
% @param |b| : double matrix, vector or scalar with the same size as |a|.
% 
%%
% |equal= approxEq(a, b, accuracy)| compares |a| with |b| on the given
% |accuracy|. 
%
%%
% @param |accuracy| : double matrix, vector or scalar. |accuracy| must
% either be a scalar or a matrix with the same size as |a|.
% 
%% Examples
%
% # Example: Example shown, when no arguments are passed to the method. As
% this is not allowed, after shown the example an error is thrown. 
%
% $$\left| { 
% \left[ 
% { \matrix{ 1 & 2 & 3 \cr 
%            4 & 5 & 6 \cr } } 
% \right] - \left[ 
% { \matrix{ 1.1 & 2.01 & 3 \cr 
%            4.1 & 5 & 6 \cr } } 
% \right] 
% } \right| 
% \leq \left[ 
% { \matrix{ 0.1 & 0.1 & 0.1 \cr 
%            0.1 & 0.1 & 0.1 \cr } } 
% \right]$$

try
  numerics.math.approxEq()
catch ME
  disp(ME.message)
end

%%
% # Example
%
% $$\left| { 
% \left[ 
% { \matrix{ 1 & 2 & 3 \cr 
%            4 & 5 & 6 \cr } } 
% \right] - \left[ 
% { \matrix{ 1.1 & 2.01 & 3 \cr 
%            4.1 & 5 & 6 \cr } } 
% \right] 
% } \right| 
% \leq \left[ 
% { \matrix{ 0.1 & 0.1 & 0.1 \cr 
%            0.1 & 0.1 & 0.1 \cr } } 
% \right]$$

numerics.math.approxEq([1,2,3;4,5,6], [1.1,2.01,3;4.1,5,6], 0.2)

%%
% 
% # Example
%
% $$\left| { 
% \left[ 
% { \matrix{ 0.1 & -0.04 \cr 
%            0.04 & 0.05 \cr } } 
% \right] - \left[ 
% { \matrix{ 0 & 0 \cr 
%            0 & 0 \cr } } 
% \right] 
% } \right| 
% \leq \left[ 
% { \matrix{ 0.1 & 0.1 \cr 
%            0.1 & 0.1 \cr } } 
% \right]$$

numerics.math.approxEq([0.1,-0.04;0.04,0.05], [], 0.2)

%%
%
% # Example: this one does not hold!
%
% $$\left| { 
% \left[ 
% { \matrix{ 0.1  & 0.2 \cr 
%            0.04 & 0.05 \cr } } 
% \right] - \left[ 
% { \matrix{ 0 & 0 \cr 
%            0 & 0 \cr } } 
% \right] 
% } \right| 
% \leq \left[ 
% { \matrix{ 0.195 & 0.195 \cr 
%            0.195 & 0.195 \cr } } 
% \right]$$

numerics.math.approxEq([0.1,0.2;0.04,0.05], [], 0.39)

%%
%
% # Example
%
% $$\left| { 
% \left[ 
% { \matrix{ 1  & 2 \cr 
%            4 & 5 \cr } } 
% \right] - \left[ 
% { \matrix{ 1.1 & 2.01 \cr 
%            4.2 & 5 \cr } } 
% \right] 
% } \right| 
% \leq \left[ 
% { \matrix{ 0.1 & 0.04 \cr 
%            0.3 & 0.0 \cr } } 
% \right]$$

numerics.math.approxEq([1,2;4,5], [1.1,2.01;4.2,5], 2.*[0.1,0.04;0.3,0.0])

%%
% # Example: This example throws an error:
%
% $$\left| { 
% \left[ 
% { \matrix{ 1  & 2 \cr 
%            4 & 5 \cr } } 
% \right] - \left[ 
% { \matrix{ 1.1 & 2.01 \cr 
%            4.2 & 5 \cr } } 
% \right] 
% } \right| 
% \leq \left[ 
% { \matrix{ 0.1 & 0.04 & 1 \cr 
%            0.3 & 0.0 & 1 \cr } } 
% \right]$$

try
  numerics.math.approxEq([1,2;4,5], [1.1,2.01;4.2,5], ...
                         2.*[0.1,0.04,1;0.3,0.0,1])
catch ME
  disp(ME.message);
end

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc all">
% matlab/all</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="..\consetofpoints\plotconstraints.html">
% numerics.conSetOfPoints.plotConstraints</a>
% </html>
%
%% See Also
%
% <html>
% <a href="round_float.html">
% numerics.math.round_float</a>
% </html>
% ,
% <html>
% <a href="matlab:doc numerics_tool/math">
% numerics_tool/numerics.math</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


