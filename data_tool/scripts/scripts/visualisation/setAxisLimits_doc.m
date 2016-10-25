%% Syntax
%       setAxisLimits(dim, LB, UB)
%       
%% Description
% |setAxisLimits(dim, LB, UB)| sets axis limits using <matlab:doc('xlim')
% matlab/xlim>, <matlab:doc('ylim') matlab/ylim> and <matlab:doc('zlim')
% matlab/zlim> depending on the given dimension |dim|. If |dim| is 1, then
% next to |xlim| also |ylim| is set. It is set to |ylim([0.90, 1.10])|.
% This is useful to plot 1-dimensional data with an artificial second
% dimension being 1. 
%
%%
% @param |dim| : dimension, double scalar integer value greater equal 1.
%
%%
% @param |LB| : lower bound, |dim| dimensional numeric (double) vector
%
%%
% @param |UB| : upper bound, |dim| dimensional numeric (double) vector
%
%% Example
% 

plot(0:0.1:pi, sin(0:0.1:pi) + 1)
setAxisLimits(2, [0,1], [pi,2])

%%
% plot 1-dimensional data

plot(0:0.1:pi, 1)
setAxisLimits(1, 0, pi)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc xlim">
% matlab/xlim</a>
% </html>
% ,
% <html>
% <a href="matlab:doc ylim">
% matlab/ylim</a>
% </html>
% ,
% <html>
% <a href="matlab:doc zlim">
% matlab/zlim</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/validateattributes">
% matlab/validateattributes</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('numerics_tool/plotpointswithconstraints')">
% numerics_tool/numerics.conSetOfPoints.plotPointsWithConstraints</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('numerics_tool/validatesetforconstraints')">
% numerics_tool/numerics.conSetOfPoints.validateSetForConstraints</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc pi">
% matlab/pi</a>
% </html>
%
%% TODOs
% # create documentation for script file
%
%% <<AuthorTag_DG/>>


