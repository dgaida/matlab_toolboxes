%% Syntax
%       rms= numerics.math.calcRMSE(x)
%       rmse= numerics.math.calcRMSE(x, y)
%
%% Description
%
% |rms= numerics.math.calcRMSE(x)| calculates the root mean square of the
% signal |x|. 
%
%%
% |rmse= calcRMSE(x, y)| calculates the RMSE between the double vectors |x|
% and |y|. The RMSE is defined as:
%
% $$rmse := \sqrt{ \frac{ \left( \vec{x} - \vec{y} \right)^T \left( \vec{x}
% - \vec{y} \right) }{ N } } = \sqrt{ \frac{ \sum_{i=1}^N{ \left( x_i - y_i
% \right)^2 } }{ N } }$$  
%
%%
% @param |x| : double vector or scalar
%
%%
% @param |y| : double vector or scalar, dimension must be equal to |x|. If
% |y| is the zero vector, then the root mean square (quadratic mean) is
% calculated. 
%
%%
% @return |rmse| : root mean squared error (deviation) between the double
% vectors |x| and |y|.
%
%% Examples
% 
% 

numerics.math.calcRMSE([1,1], [2,2])

%%
% 
%

numerics.math.calcRMSE([1,1], [0,0])

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="calcnormalizedrmse.html">
% numerics.math.calcNormalizedRMSE</a>
% </html>
%
%% See Also
%
% <html>
% <a href="edist.html">
% numerics.math.edist</a>
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


