%% Syntax
%       [x, success]= numerics.conSetOfPoints.validateSetForConstraints(obj)
%       [...]= validateSetForConstraints(obj, dispValidBounds)
%       [...]= validateSetForConstraints(obj, dispValidBounds, plotnonlcon)
%       
%% Description
% |[x, success]= validateSetForConstraints(obj)| checks if the set
% |obj.conData| holds for all the boundaries and constraints. The actual
% validation is performed in the full dimension using the original
% constraints and boundaries calling <evalndimsetforconstraints.html
% numerics.conSetOfPoints.private.evalNDimSetForConstraints>. 
%
% If the
% dimension of the set (either the full or the subset) is smaller or equal
% 4, then the set and the boundaries are additionally plotted calling
% <plotpointswithconstraints.html 
% numerics.conSetOfPoints.private.plotPointsWithConstraints>. 
%
% * |dim == 1| or |conDim == 1| : <plotpointswithconstraints.html 
% numerics.conSetOfPoints.private.plotPointsWithConstraints> is called with
% the original or the constrained problem. 
% * |dim == 2| or |conDim == 2| : <plotpointswithconstraints.html 
% numerics.conSetOfPoints.private.plotPointsWithConstraints> is called with
% the original and the constrained problem, if both dimensions are not
% equal. 
% * |dim == 3| or |conDim == 3| : The points and constraints are visualized
% from four different views (front, left, top, 3d) in a
% <matlab:doc('subplot') subplot>. 
% * |dim == 4| or |conDim == 4| : For the
% 4-dimensional space the 4th dimension is represented by the time, such
% that a video is created using <matlab:doc('avifile') avifile>. The video
% also contains the points and constraints visualized
% from four different views (front, left, top, 3d) in a
% <matlab:doc('subplot') subplot>. 
%
%%
% @param |obj| : object of the class <consetofpoints.html
% |numerics.conSetOfPoints|>.
%
%%
% @return |x| : set of points in the full dimension. double matrix. Number
% of columns equal to dimension of the dataset, number of rows the size of
% the dataset. 
%
%%
% @return |success| : returns 1, if all constraints hold, else 0.
%
%%
% |[...]= validateSetForConstraints(obj, dispValidBounds)| lets you specify
% whether for every valid boundary a message should be returned. This does
% not affect the warnings thrown, when a boundary does not hold. 
%
%%
% @param |dispValidBounds| : integer, scalar
% 
% * 0 : If boundaries hold then no message is returned. Default. 
% * 1 : for each boundary that holds a message is returned. 
%
%%
% |[...]= validateSetForConstraints(obj, dispValidBounds, plotnonlcon)| 
%
%%
% @param |plotnonlcon| : if 1, then nonlinear constraints are plotted, else
% 0. Since plotting the nonlinear constraints is very ressources consuming,
% this parameter should be set to 0 to spare time and memory.
%
%% Example
%
% Create a set containing ten 3-dimensional points satisfying the given 
% boundaries and the linear inequality constraint

mySet= numerics.conSetOfPoints(3, 10, [1 1 0], 7, [], [], [0, 0, 1], [5, 5, 10]);

%%
% see if all boundaries and constraints hold

mySet.validateSetForConstraints(1)


%% Dependencies
%
% This method calls:
%
% <html>
% <a href="plotconstraints.html">
% numerics.conSetOfPoints.private.plotConstraints</a>
% </html>
% ,
% <html>
% <a href="plotpointswithconstraints.html">
% numerics.conSetOfPoints.private.plotPointsWithConstraints</a>
% </html>
% ,
% <html>
% <a href="getpointsinfulldimension.html">
% numerics.conSetOfPoints.getPointsInFullDimension</a>
% </html>
% ,
% <html>
% <a href="plotvalidpoints.html">
% numerics.conSetOfPoints.private.plotValidPoints</a>
% </html>
% ,
% <html>
% <a href="evalndimsetforconstraints.html">
% numerics.conSetOfPoints.private.evalNDimSetForConstraints</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/setaxislimits')">
% data_tool/setAxisLimits</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/avifile')">
% matlab/avifile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/ndgrid')">
% matlab/ndgrid</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/getframe')">
% matlab/getframe</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/addframe')">
% matlab/addframe</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="..\conrandmatrix\getoptimalpopulation.html">
% numerics.conRandMatrix.private.getOptimalPopulation</a>
% </html>
% ,
% <html>
% <a href="getvalidsetofpoints.html">
% numerics.conSetOfPoints.private.getValidSetOfPoints</a>
% </html>
%
%% See Also
%
% <html>
% <a href="consetofpoints.html">
% numerics.conSetOfPoints</a>
% </html>
% ,
% <html>
% <a href="getpointsinconstraineddimension.html">
% numerics.conSetOfPoints.getPointsInConstrainedDimension</a>
% </html>
%
%% TODOs
% # check appearance of documentation
% # maybe use data_tool/plot3views
%
%% <<AuthorTag_DG/>>


