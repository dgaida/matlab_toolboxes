%% Syntax
%       plotValidPoints(x, A, b)
%       plotValidPoints(x, A, b, p)
%       plotValidPoints(x, A, b, p, dispValidBounds)
%
%% Description
% |plotValidPoints(x, A, b)| checks for each point $\vec{x}$ in matrix |x|,
% if the linear inequality constraints $A \cdot \vec{x} \leq \vec{b}$ hold.
% Eitherway it prints a message for each point that the constraints hold or
% do not hold. If they hold and the point is 1- til 4-dimensional, then it
% is plotted on the current figure.
%
% The points are plotted:
%
% * 1-dim : calling <matlab:doc('scatter') scatter> with the 2nd coordinate
% beeing fixed to 1 (see <matlab:doc('data_tool/setaxislimits')
% setAxisLimits>). 
% * 2-dim : calling <matlab:doc('scatter3') scatter3> with the z-axis fixed
% to 20000, such that the point is drawn before everything else.
% Furthermore the <matlab:doc('view') view> is set to |view(0,90)|. 
% * 3-dim : calling <matlab:doc('plot3') plot3> 
% * 4-dim : calling <matlab:doc('plot3') plot3> 
%
%%
% @param |x| : double matrix representing the set of points. The points
% itself are row vectors, so the 
% number of rows of the matrix |x| equals the number of points, and the
% number of columns of |x| equals the dimension of the points.
% 
%%
% @param |A| : double matrix with the linear inequality constraints: $A
% \cdot \vec{x} \leq \vec{b}$. One constraint is defined as a row vector
%
%%
% @param |b| : double column vector, representing the right side of the 
% linear inequality constraints 
%
%%
% |plotValidPoints(x, A, b, p)|
%
%%
% @param |p| : If |x| contains points with a dimension bigger then 4, then it is
% possible to pass with |p| the same set of points, which are living in a
% smaller dimension, such that this smaller dimension is plotted. The
% connection between |x| and |p| could be linear equality constraints, meaning
% that the |x| are living, e.g. on a plane, but are 3-dimensional and the
% |p|'s are living in the 2-dimensional world of the plane. Or the connection
% could be achieved by projecting the |x| on a maximal 4-dim subspace, in
% which the |p|'s are living.
%
%%
% |plotValidPoints(x, A, b, p, dispValidBounds)| lets you change how much
% informations are printed by this method. 
%
%%
% @param |dispValidBounds| : double scalar, 
%
% * 1 : if 1, then it is always displayed if each point of the set
% satisfies bounds or not. 
% * 0 : If 0, then this information is only displayed if bounds do not hold
% (default). 
%
%% Example
%
% x= [1,2,3; 4,5,6];
% A= [1,0,0];
% b= [2];
% 
% numerics.conSetOfPoints.private.plotValidPoints(x, A, b);
%
%% Dependencies
%
% This method calls:
%
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
% <a href="matlab:doc scatter3">
% matlab/scatter3</a>
% </html>
% ,
% <html>
% <a href="matlab:doc scatter">
% matlab/scatter</a>
% </html>
% ,
% <html>
% <a href="matlab:doc plot3">
% matlab/plot3</a>
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
% ,
% <html>
% <a href="plotconstraints.html">
% numerics.conSetOfPoints.private.plotConstraints</a>
% </html>
%
%% TODOs
% # make an example
% # is it possible to extend this function such that also nonlinear
% constraints are checked?
%
%% <<AuthorTag_DG/>>


