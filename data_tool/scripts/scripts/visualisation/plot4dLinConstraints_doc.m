%% Syntax
%       [X, Y, Z]= plot4dLinConstraints(A, b, LB, UB) 
%       [X, Y, Z]= plot4dLinConstraints(A, b, LB, UB, alpha) 
%       [X, Y, Z]= plot4dLinConstraints(A, b, LB, UB, alpha, noPoints) 
%       [X, Y, Z]= plot4dLinConstraints(A, b, LB, UB, alpha, noPoints,
%       color)  
%       [X, Y, Z]= plot4dLinConstraints(A, b, LB, UB, alpha, noPoints,
%       color, iframe) 
%       [X, Y, Z]= plot4dLinConstraints(A, b, LB, UB, alpha, noPoints,
%       color, iframe, noFrames) 
%       
%% Description
% |[X, Y, Z]= plot4dLinConstraints(A, b, LB, UB)| the 4d boundary is drawn
% as a 3-dimensional plane, which position is dependent of a fourth
% parameter, the time. Over a time interval, defined by the parameter
% |noFrames|, the position of the boundary is changed and the different
% pictures of the plotted boundary are written as frames into a video. The
% current plotted frame is |iframe|. 
%
%%
% @param |A| : The matrix describing the linear (in-)equality constraint
% $A_{eq}
% \cdot \vec{x} = \vec{b}_{eq}$ resp. $A \cdot \vec{x} \leq \vec{b}$. You 
% must provide |A| row by row, so here |A| is just a 3-dimensional row
% vector. 
%
%% 
% @param |b| : The vector describing the linear (in-)equality constraint. 
% You must provide |b| row by row, so here |b| is just a scalar.
%
%%
% @param |LB| : Lower Bound of the 3-dim space, so a 3-dimensional row
% or column vector.
%
%%
% @param |UB| : Upper Bound of the 3-dim space, so a 3-dimensional row
% or column vector. 
%
%%
% @return |X| : median value of the surface, is inside the center of the
% surface. 
%
%%
% @return |Y| : median value of the surface, is inside the center of the
% surface. 
%
%%
% @return |Z| : median value of the surface, is inside the center of the
% surface. 
%
%%
% |[X, Y, Z]= plot4dLinConstraints(A, b, LB, UB, alpha)| sets the alpha
% channel of the surface. 
%
%%
% @param |alpha| : The surface is drawn as a grid surface, where the edges
% are drawn using the alpha channel. |alpha| must be a scalar between 0 and
% 1. 
%
%%
% |[X, Y, Z]= plot4dLinConstraints(A, b, LB, UB, alpha, noPoints)| sets the
% number of knots of the grid. 
%
%%
% @param |noPoints| : number of knots of the grid. scalar integer
%
%%
% |[X, Y, Z]= plot4dLinConstraints(A, b, LB, UB, alpha, noPoints, color)|
% sets the color of the surface. 
%
%%
% @param |color| : color of the drawn grid specified as char letter, see
% <matlab:doc('ColorSpec') ColorSpec>. 
%
%%
% |[X, Y, Z]= plot4dLinConstraints(A, b, LB, UB, alpha, noPoints, color,
% iframe)| 
%
%%
% @param |iframe| : number of the frame in the video. scalar integer
% running from 1 to |noFrames|. 
%
%%
% |[X, Y, Z]= plot4dLinConstraints(A, b, LB, UB, alpha, noPoints, color,
% iframe, noFrames)| 
%
%%
% @param |noFrames| : total number of frames of the video, defines the
% grid, the granularity of the fourth dimension. scalar integer
%     
%% Example
%
%
%% Dependencies
%
% This method calls:
%
% <html>
% <a href=matlab:doc('surf')>
% matlab/surf</a>
% </html>
% ,
% <html>
% <a href=matlab:doc('ndgrid')>
% matlab/ndgrid</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('numerics_tool/plotconstraints')">
% numerics_tool/numerics.conSetOfPoints.private.plotConstraints</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc('numerics_tool/consetofpoints')">
% numerics_tool/numerics.conSetOfPoints</a>
% </html>
% ,
% <html>
% <a href="plot1dlinconstraints.html">
% plot1dLinConstraints</a>
% </html>
% ,
% <html>
% <a href="plot2dlinconstraints.html">
% plot2dLinConstraints</a>
% </html>
% ,
% <html>
% <a href="plot3dlinconstraints.html">
% plot3dLinConstraints</a>
% </html>
%
%% TODOs
% # improve documentation
% # add an example
%
%% <<AuthorTag_DG/>>


