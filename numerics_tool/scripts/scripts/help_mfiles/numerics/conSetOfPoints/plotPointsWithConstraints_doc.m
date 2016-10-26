%% Syntax
%       x= numerics.conSetOfPoints.plotPointsWithConstraints(obj, p, dim,
%       A, b, Aeq, beq, LB, UB, nonlcon, Aval, bval) 
%       x= numerics.conSetOfPoints.plotPointsWithConstraints(obj, p, dim,
%       A, b, Aeq, beq, LB, UB, nonlcon, Aval, bval, plotnonlcon) 
%       
%% Description
% |x= numerics.conSetOfPoints.plotPointsWithConstraints(obj, p, dim, A, b,
% Aeq, beq, LB, UB, nonlcon, Aval, bval)| plots constraints together with
% valid points. The parameter |dim| defines the dimension of the space in
% which is plotted. As constraints linear inequality (|A, b|), equality
% (|Aeq, beq|), lower and upper boundaries (|LB, UB|) as well as nonlinear
% (in-)equality constraints (|nonlcon|) are plotted calling
% <plotconstraints.html numerics.conSetOfPoints.private.plotConstraints>.
% Furthermore points satisfying the linear inequality constraints |Aval,
% bval| (should include linear inequality constraints and lower and upper
% boundaries) are plotted calling <plotvalidpoints.html
% numerics.conSetOfPoints.private.plotValidPoints>. 
%
%%
% @param |obj| : object of the class <consetofpoints.html
% |numerics.conSetOfPoints|>.
%
%%
% @param |p| : array of points that has to be plotted. The number of rows
% define the number of points, the number of columns the dimension of the
% space in which the points are. These points must always lie in the
% constrained space. 
%
%%
% @param |dim| : dimension of the space in which shall be plotted. Either
% the dimension of the full space or the dimension of the reduced space.
% Thus |dim| must either be the full or the reduced dimension. scalar
% integer. 
%
%%
% @param |A| : double matrix of linear inequality constraints: $A \cdot
% \vec{x} \leq \vec{b}$. The number of columns must be |dim|. Thus |A| is
% either defined in the full or constrained space. 
%
%%
% @param |b| : double column vector containing the right side of the
% inequality constraints: $A \cdot \vec{x} \leq \vec{b}$. 
%
%%
% @param |Aeq| : double matrix of linear equality constraints: $A_{eq}
% \cdot \vec{x} \leq \vec{b}_{eq}$. The number of columns must be |dim|.
% Thus |Aeq| is either defined in the full or constrained space. 
%
%%
% @param |beq| : double column vector containing the right side of the
% linear equality constraints 
%
%%
% @param |LB| : Lower Bounds. Row vector, the number of columns must be |dim|.
%
%%
% @param |UB| : Upper Bounds. Row vector, the number of columns must be |dim|.
%
%%
% @param |nonlcon| : <matlab:doc('function_handle') function_handle> with
% nonlinear (in-)equality constraints. 
%
%%
% @param |Aval| : linear inequality constraints used for the validation of
% the data points. The number of columns must be the dimension of the full
% space.
%
%%
% @param |bval| : double vector with the right side of the linear
% inequality constraints used for the validation of 
% the data points. The number of columns must be the dimension of the full
% space.
%
%%
% @return |x| : double array with the data points of the full space. The
% dataset contains out of rowvectors. 
%
%%
% |x= numerics.conSetOfPoints.plotPointsWithConstraints(obj, p, dim, A, b,
% Aeq, beq, LB, UB, nonlcon, Aval, bval, plotnonlcon)| 
%
%%
% @param |plotnonlcon| : if 1, then nonlinear constraints are plotted, else
% 0. Since plotting the nonlinear constraints is very ressources consuming,
% this parameter should be set to 0 to spare time and memory.
%
%% Example
%
%
%% Dependencies
%
% This method calls:
%
% <html>
% <a href="getpointsinfulldimension.html">
% numerics.conSetOfPoints.private.getPointsInFullDimension</a>
% </html>
% ,
% <html>
% <a href="plotconstraints.html">
% numerics.conSetOfPoints.private.plotConstraints</a>
% </html>
% ,
% <html>
% <a href="plotvalidpoints.html">
% numerics.conSetOfPoints.private.plotValidPoints</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/setaxislimits')">
% data_tool/setAxisLimits</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="validatesetforconstraints.html">
% numerics.conSetOfPoints.private.validateSetForConstraints</a>
% </html>
%
%% See Also
%
% <html>
% <a href="consetofpoints.html">
% numerics.conSetOfPoints</a>
% </html>
%
%% TODOs
% # points that do not satisfy nonlinear constraint are plotted anyway, is
% this true?
%
%% <<AuthorTag_DG/>>


