%% Syntax
%       [X]= plot1dLinConstraints(A, b)
%       [X]= plot1dLinConstraints(A, b, color)
%       
%% Description
% |[X]= plot1dLinConstraints(A, b)| plots the 1d linear constraint,
% described by the matrix |A| and vector |b| in explicit form using
% <matlab:doc('plot') plot>. A 1d constraint is just a point. Here the x
% coordinate is defined by the constraint, the y-coordinate is always fixed
% to 1. This is the reason why in <matlab:doc('data_tool/setaxislimits')
% data_tool/setAxisLimits> in the 1-dimensional case, the y-axis is bound
% around 1. 
%
%%
% @param |A| : The matrix describing the linear (in-)equality constraint
% $A_{eq} \cdot \vec{x} = \vec{b}_{eq}$ or $A \cdot \vec{x} \leq \vec{b}$,
% respectively. You must provide |A| row by row, so here |A| is just a row
% vector. Since the space is 1-dimensional it is a 1-dim. row-vector -> a
% scalar. 
%
%% 
% @param |b| : The vector describing the linear (in-)equality constraint. You
% must provide |b| row by row, so here |b| is just a scalar.
%
%%
% @return |X| : |b| / |A|
%
%%
% |[X]= plot1dLinConstraints(A, b, color)| plots the constraint in the
% given color, where |color| is a char defining the color, see
% <matlab:doc('ColorSpec') ColorSpec>.
%
%%
% @param |color| : color of the drawn line specified as char letter, see
% <matlab:doc('ColorSpec') ColorSpec>. 
%
%% Example
%
%
%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('plot')">
% matlab/plot</a>
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
% <a href="plot2dlinconstraints.html">
% plot2dLinConstraints</a>
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
% ,
% <html>
% <a href="matlab:doc('data_tool/setaxislimits')">
% data_tool/setAxisLimits</a>
% </html>
%
%% TODOs
% # create documentation for script file
% # add an example
%
%% <<AuthorTag_DG/>>


