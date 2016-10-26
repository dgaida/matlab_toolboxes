%% Syntax
%       numerics.conSetOfPoints.plotConstraints(obj, dim, A, b, Aeq, beq,
%       LB, UB) 
%       numerics.conSetOfPoints.plotConstraints(obj, dim, A, b, Aeq, beq,
%       LB, UB, nonlcon) 
%       numerics.conSetOfPoints.plotConstraints(obj, dim, A, b, Aeq, beq,
%       LB, UB, nonlcon, iframe) 
%       numerics.conSetOfPoints.plotConstraints(obj, dim, A, b, Aeq, beq,
%       LB, UB, nonlcon, iframe, noFrames) 
%       numerics.conSetOfPoints.plotConstraints(obj, dim, A, b, Aeq, beq,
%       LB, UB, nonlcon, iframe, noFrames, plotnonlcon) 
%       
%% Description
% |plotConstraints(obj, dim, A, b, Aeq, beq, LB, UB)| creates a plot visualizing
% the different boundaries. Depending on the dimension |dim| a 1-, 2- or
% 3-dimensional plot is created. 
%
%%
% @param |obj| : object of the <consetofpoints.html
% |numerics.conSetOfPoints|> class 
%
%%
% @param |dim| : the dimension of the to be plotted constraints. A number
% from 1 to 4. If |dim| is 4, then a video will be created (not in this
% function). Then only the |iframe| th boundary of |noFrames| boundaries is
% plotted. 
%
%%
% @param |A| : The matrix describing the linear inequality constraint
% $A \cdot \vec{x} \leq \vec{b}$. A linear inequality constraint is either
% visualized by a dot (1d), a line (2d) or a plane (3d). Furthermore an
% arrow is drawn using <matlab:doc('quiver') quiver> pointing into the
% valid space. 
%
%% 
% @param |b| : The column vector describing the linear inequality
% constraint $A \cdot \vec{x} \leq \vec{b}$. 
% 
%%
% @param |Aeq| : The matrix describing the linear equality constraint
% $A_{eq} \cdot \vec{x} = \vec{b}_{eq}$. A linear equality constraint is
% either visualized by a dot (1d), a line (2d) or a plane (3d). 
%
%% 
% @param |beq| : The column vector describing the linear equality
% constraint $A_{eq} \cdot \vec{x} = \vec{b}_{eq}$. 
%
%%
% @param |LB| : Lower Bound of the space, as a row vector.
%
%%
% @param |UB| : Upper Bound of the space, as a row vector. 
%
%%
% |plotConstraints(obj, dim, A, b, Aeq, beq, LB, UB, nonlcon)|
%
%%
% @param |nonlcon| : <matlab:doc('function_handle') function_handle> with
% the nonlinear constraints 
%
%%
% |plotConstraints(obj, dim, A, b, Aeq, beq, LB, UB, nonlcon, iframe)|
%
%%
% @param |iframe| : if |dim| == 4, then the 4th dimension is the time,
% which is represented by a video. Then only the |iframe| th boundary of
% |noFrames| boundaries is plotted. integer number. 
%
%%
% |plotConstraints(obj, dim, A, b, Aeq, beq, LB, UB, nonlcon, iframe,
% noFrames)| 
%
%%
% @param |noFrames| : number of frames of the video, defining the
% granularity of the 4th dimension. integer number. 
%
%%
% |plotConstraints(obj, dim, A, b, Aeq, beq, LB, UB, nonlcon, iframe,
% noFrames, plotnonlcon)| 
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
% numerics.conSetOfPoints.getPointsInFullDimension</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/plot1dlinconstraints')">
% data_tool/plot1dLinConstraints</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/plot2dlinconstraints')">
% data_tool/plot2dLinConstraints</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/plot3dlinconstraints')">
% data_tool/plot3dLinConstraints</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/plot4dlinconstraints')">
% data_tool/plot4dLinConstraints</a>
% </html>
% ,
% <html>
% <a href="../math/approxeq.html">
% numerics.math.approxEq</a>
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
% ,
% <html>
% <a href="matlab:doc('matlab/quiver')">
% matlab/quiver</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/quiver3')">
% matlab/quiver3</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/meshgrid')">
% matlab/meshgrid</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/ndgrid')">
% matlab/ndgrid</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/surf')">
% matlab/surf</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/plot3')">
% matlab/plot3</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/edge')">
% matlab/edge</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="validatesetforconstraints.html">
% numerics.conSetOfPoints.private.validateSetForConstraints</a>
% </html>
% ,
% <html>
% <a href="plotpointswithconstraints.html">
% numerics.conSetOfPoints.private.plotPointsWithConstraints</a>
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
% # improve documentation a bit
%
%% <<AuthorTag_DG/>>


