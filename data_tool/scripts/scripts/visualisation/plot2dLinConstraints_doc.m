%% Syntax
%       [X, Y]= plot2dLinConstraints(A, b, LB, UB)
%       [X, Y]= plot2dLinConstraints(A, b, LB, UB, noPoints) 
%       [X, Y]= plot2dLinConstraints(A, b, LB, UB, noPoints, color) 
%       
%% Description
% |[X, Y]= plot2dLinConstraints(A, b, LB, UB)| plots the 2d linear
% constraint, described by the matrix |A| and vector |b| in explicit form 
% using <matlab:doc('plot') plot>. This function plots a line between the
% |LB| and |UB| with 10 sampling points. With $\vec{x} := (x, y)^T$ the
% linear constraint can be formulated as $a_{11} \cdot x + a_{12} \cdot y=
% b$, $A := \left( a_{11}, a_{12} \right)$. Then the plotted line is: $x=
% \frac{ b - a_{12} \cdot y }{ a_{11} }$ with the |y| values generated
% between |LB(2)| and |UB(2)|. 
%
%%
% @param |A| : The matrix describing the linear (in-)equality constraint
% $A_{eq} \cdot \vec{x} = \vec{b}_{eq}$ or $A \cdot \vec{x} \leq \vec{b}$,
% respectively. You must provide |A| row by row, so here |A| is just a 2dim
% row vector. 
%
%% 
% @param |b| : The vector describing the linear (in-)equality constraint. 
% You must provide |b| row by row, so here |b| is just a scalar.
%
%%
% @param |LB| : Lower Bound of the 2-dim space, so a 2-dimensional row
% or column vector.
%
%%
% @param |UB| : Upper Bound of the 2-dim space, so a 2-dimensional row
% or column vector 
%
%%
% @return |X| : returns x coordinate of the median value of the sampling
% points forming the line
%
%%
% @return |Y| : returns y coordinate of the median value of the sampling
% points forming the line
%
%%
% |[X, Y]= plot2dLinConstraints(A, b, LB, UB, noPoints)| lets you specify
% the number of sampling points which are used to draw the constraint. 
%
%%
% @param |noPoints| : With this parameter you can specify the number of
% sampling points. double scalar, default: 10. 
%
%%
% |[X, Y]= plot2dLinConstraints(A, b, LB, UB, noPoints, color)|
%
%%
% @param |color| : color of the drawn line specified as char letter, see
% <matlab:doc('ColorSpec') ColorSpec>. 
%
%% Example
%
%

plot2dLinConstraints([-1 1], 5, [0 0], [10 10])

%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('plot') plot">
% matlab/plot</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
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
% <a href="plot3dlinconstraints.html">
% plot3dLinConstraints</a>
% </html>
% ,
% <html>
% <a href="plot4dlinconstraints.html">
% plot4dLinConstraints</a>
% </html>
%
%% TODOs
% # check appearance of documentation
% # add an example
%
%% <<AuthorTag_DG/>>


