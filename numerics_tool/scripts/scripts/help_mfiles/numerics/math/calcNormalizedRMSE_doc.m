%% Syntax
%       n_rmse= numerics.math.calcNormalizedRMSE(x, y)
%
%% Description
%
% |n_rmse= calcNormalizedRMSE(x, y)| calculates the normalized RMSE between
% the double vectors |x| and |y|. The normalized RMSE is defined as the
% RMSE over the mean squared error of |y|:
%
% $$n\_rmse := \frac{ \sqrt{ \frac{ \left( \vec{x} - \vec{y} \right)^T
% \left( \vec{x} - \vec{y} \right) }{ N } } }{ \sqrt{ \frac{ \vec{y}^T
% \vec{y} }{N} } } = 
% \frac{ \sqrt{ \frac{ \sum_{i=1}^N{ \left( x_i - y_i 
% \right)^2 } }{ N } } }{ \sqrt{ \frac{ \sum_{i=1}^N{ y_i^2 } }{N} } } = 
% \frac{ \sqrt{ \sum_{i=1}^N{ \left( x_i - y_i 
% \right)^2 } } }{ \sqrt{ \sum_{i=1}^N{ y_i^2 } } }$$  
%
%%
% @param |x| : double vector or scalar
%
%%
% @param |y| : double vector or scalar, dimension must be equal to |x|.
%
%%
% @return |n_rmse| : normalized root mean squared error (deviation) between
% the double vectors |x| and |y|.
%
%% Examples
% 
% 

numerics.math.calcNormalizedRMSE([1,1], [2,2])


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="calcrmse.html">
% numerics.math.calcRMSE</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('fitness_calibration')">
% fitness_calibration</a>
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


