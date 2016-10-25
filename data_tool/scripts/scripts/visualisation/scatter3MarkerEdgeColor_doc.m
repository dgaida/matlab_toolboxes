%% Syntax
%       scatter3MarkerEdgeColor(x, y, z)
%       scatter3MarkerEdgeColor(x, y, z, c)
%       scatter3MarkerEdgeColor(x, y, z, c, edgeColor)
%
%% Description
% |scatter3MarkerEdgeColor(x, y, z)| plots 3d data (x, y, z) using
% <matlab:doc('scatter3') scatter3>. The color of the dots is defined by
% |z| and the color of the |MarkerEdgeColor| is set to black. 
%
%%
% @param |x| : double vector, specifying the x coordinate of the three
% dimensional dots. 
%
%%
% @param |y| : double vector, specifying the x coordinate of the three
% dimensional dots. Must have same size as |x|. 
%
%%
% @param |z| : double vector, specifying the x coordinate of the three
% dimensional dots. Must have same size as |x|. 
%
%%
% |scatter3MarkerEdgeColor(x, y, z, c)| lets you specify the color of the
% dots using |c|. 
%
%%
% @param |c| : double vector, specifying the color of the data points, must
% have same size as |x|. 
%
%%
% |scatter3MarkerEdgeColor(x, y, z, c, edgeColor)| lets you specify the
% |MarkerEdgeColor| of each dot. 
%
%%
% @param |edgeColor| : char
%
% * 'on' : Each data point gets an inidvidual |MarkerEdgeColor|, defined by
% parameter |c|. time consuming, because each dot is drawn separately
% * 'off' : No |MatrkerEdgeColor| is drawn, fast.
% * 'c', 'r', 'b', 'w', 'g', 'm', 'y', 'k' : The |MatrkerEdgeColor| for every
% point is set to the given color, fast. 
%
%% Example
%
% # draw dots with a cyan colored |MatrkerEdgeColor|

dataAnalysis= load_file('data_to_plot.mat');

scatter3MarkerEdgeColor(dataAnalysis(:,2), dataAnalysis(:,3), ...
                        dataAnalysis(:,8), dataAnalysis(:,end), ...
                        'c');

daspect([1 1 1]);
view(3);
axis('tight');


%%
% # draw dots where the color of the |MatrkerEdgeColor| is chosen
% complementary to the color of the dots. Thus dark dots get a light
% colored |MatrkerEdgeColor| and light colored dots get a dark colored
% |MatrkerEdgeColor|. 

dataAnalysis= load_file('data_to_plot.mat');

scatter3MarkerEdgeColor(dataAnalysis(:,2), dataAnalysis(:,3), ...
                        dataAnalysis(:,8), dataAnalysis(:,end), ...
                        'on');

daspect([1 1 1]);
view(3);
axis('tight');


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc scatter3">
% matlab/scatter3</a>
% </html>
% ,
% <html>
% <a href="matlab:doc validatestring">
% matlab/validatestring</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_gui/plot_xyz')">
% biogas_gui/plot_xyz</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc scatter">
% matlab/scatter</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_gui/gui_plot_optimresults')">
% biogas_gui/gui_plot_optimResults</a>
% </html>
% ,
% <html>
% <a href="plot3dsurface_alpha.html">
% data_tool/plot3dsurface_alpha</a>
% </html>
%
%% TODOs
% # make documentation for script file
% # solve TODO inside the file
%
%% <<AuthorTag_DG/>>


