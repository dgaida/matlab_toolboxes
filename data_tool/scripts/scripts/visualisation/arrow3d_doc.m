%% Syntax
% h=arrow3d(x,y,z,head_frac,radii,radii2,colr)
%
%% Description
% The inputs are:
%       x,y,z =  vectors of the starting point and the ending point of the
%           arrow, e.g.:  x=[x_start, x_end]; y=[y_start, y_end];z=[z_start,z_end];
%       head_frac = fraction of the arrow length where the head should  start
%       radii = radius of the arrow
%       radii2 = radius of the arrow head (defult = radii*2)
%       colr =   color of the arrow, can be string of the color name, or RGB vector  (default='blue')
%
% The output is the handle of the surfaceplot graphics object.
% The settings of the plot can changed using: set(h, 'PropertyName', PropertyValue)
%
%% Example
% example #1:

arrow3d([0 0],[0 0],[0 6],.5,3,4,[1 0 .5]);

%%
% example #2:
        
arrow3d([2 0],[5 0],[0 -6],.2,3,5,'r');

%%
% example #3:

h = arrow3d([1 0],[0 1],[-2 3],.8,3);
set(h,'facecolor',[1 0 0])

%%
% 
% Written by Moshe Lindner , Bar-Ilan University, Israel.
% July 2010 (C)
%
%% TODOs
% # make documentation
% # understand code
%


