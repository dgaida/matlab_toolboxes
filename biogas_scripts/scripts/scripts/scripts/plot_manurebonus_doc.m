%% Syntax
%       plot_manurebonus(plant_id, feed_indices)
%       plot_manurebonus(plant_id, feed_indices, LB)
%       plot_manurebonus(plant_id, feed_indices, LB, UB)
%       
%% Description
% |plot_manurebonus(plant_id, feed_indices)| plots manurebonus as linear
% constraint as line or plane (hyperplane). In general the manurebonus is a
% hyperplane. In this function it is only possible to plot it as line or
% plane. Using |feed_indices| one can specify two or three substrates that
% will span up the space in which the line or plane will be drawn. 
%
%% <<plant_id/>>
%%
% @param |feed_indices| : a two or three dimensional vector with the
% indices of the substrates that will be plotted. The first substrate has
% the index 1. 
%
%%
% @param |LB| : lower boundary of the plot, 2- or 3-dimensional. Must have
% same number of dimensions as has |feed_indices|. Default: 0s. 
%
%%
% @param |UB| : upper boundary of the plot, 2- or 3-dimensional. Must have
% same number of dimensions as has |feed_indices|. Default: 10s. 
%
%% Example
%
% # Plot manurebonus as plane between 1st, 2nd and 4th substrate of plant
% geiger. 

figure
plot_manurebonus('geiger', [1 2 4])

%%
% # Plot manurebonus as line between 1st and 2nd substrate of plant geiger. 

figure
plot_manurebonus('geiger', [1 2])


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_mat_files')">
% biogas_scripts/load_biogas_mat_files</a>
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
% <a href="matlab:doc('biogas_scripts/is_plant_id')">
% biogas_scripts/is_plant_id</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
%
% <html>
% <a href="matlab:doc('matlab/plot')">
% matlab/plot</a>
% </html>
%
%% TODOs
% # improve documentation a little
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


