%% Syntax
%       arrow3d_connect_dots(x_c, y_c, z_c)
%       arrow3d_connect_dots(x_c, y_c, z_c, model)
%       arrow3d_connect_dots(x_c, y_c, z_c, xm, ym, zm, fm)
%       arrow3d_connect_dots(x_c, y_c, z_c, xm, ym, zm, fm, interp_method)
%
%% Description
% |arrow3d_connect_dots(x_c, y_c, z_c)| draws a <arrow3d.html 3d-arrow>
% between the points |(x_c, y_c, z_c)| starting at the first |(x_c(1),
% y_c(1), z_c(1))| and ending at the last point |(x_c(N), y_c(N), z_c(N))|.
% The color of the arrow is equal to data in |z_c|. 
%
%%
% @param |x_c| : data double column vector, specifying the first coordinate
% of the 3d dots the arrow will go through. 
%
%%
% @param |y_c| : data double column vector, specifying the 2nd coordinate
% of the 3d dots the arrow will go through. Must have same dimension as
% |x_c|. 
%
%%
% @param |z_c| : data double column vector, specifying the 3rd coordinate
% of the 3d dots the arrow will go through. Must have same dimension as
% |x_c|. 
%
%%
% |arrow3d_connect_dots(x_c, y_c, z_c, model)| draws a <arrow3d.html
% 3d-arrow> between the points (x_c, y_c, z_c) starting at the first and
% ending at the last point. The color of the arrow we get from the trained
% Kriging model |model|. 
%
%%
% @param |model| : a trained <matlab:doc('ml_tool/evaluate_kriging') DACE
% Kriging> model 
%
%%
% |arrow3d_connect_dots(x_c, y_c, z_c, xm, ym, zm, fm)| draws a
% <arrow3d.html 3d-arrow> between the points (x_c, y_c, z_c) starting at
% the first and ending at the last point. The color of the arrow is
% determined using interpolation. As interpolation samples are used fm=
% F(xm, ym, zm). 
%
%%
% @param |xm| : data double column vector, defining the 1st coordinate of
% the sample points used to set the color of the arrow. 
%
%%
% @param |ym| : data double column vector, defining the 2nd coordinate of
% the sample points used to set the color of the arrow. Must have same
% dimension as |xm|. 
%
%%
% @param |zm| : data double column vector, defining the 3rd coordinate of
% the sample points used to set the color of the arrow. Must have same
% dimension as |xm|. 
%
%%
% @param |fm| : data double column vector, defining the color of
% the sample points. Must have same dimension as |xm|. 
%
%%
% |arrow3d_connect_dots(x_c, y_c, z_c, xm, ym, zm, fm, interp_method)| 
%
%%
% @param |interp_method| : interpolation method used for color
% interpolation. See also: <matlab:doc('TriScatteredInterp')
% matlab/TriScatteredInterp>. 
%
% * 'natural' : Natural neighbor interpolation
% * 'linear' : Linear interpolation (default)
% * 'nearest' : Nearest neighbor interpolation
%
%% Example
%
% plot arrow

dataAnalysis= load_file('NMPC_data_to_plot.mat');

t_datum= double(dataAnalysis(:,1));

% t_datum in Tagen, 1,0 = 1 Tage
t_datum= t_datum - min(t_datum);
% in Stunden
x= t_datum * 24.0;

y= double(dataAnalysis(:,2));
z= double(dataAnalysis(:,3));
fitness= double(dataAnalysis(:,end));

col_simtime= 10;

M= [double(dataAnalysis(:,col_simtime)), x, y, z];

% get values with : simtime < 10 or > 100
criteria= max( M(:,1) < 10, M(:,1) > 100 );

x_c= M(criteria, 2);
y_c= M(criteria, 3);
z_c= M(criteria, 4);

arrow3d_connect_dots(x_c, y_c, z_c, x, y, z, fitness);

set(gca, 'CLim', [min(fitness), max(fitness)]);

view([19.5 28]);

%%
% plot dots over the arrow

hold on;
    
scatter3(x, y, z, [], fitness, 's', 'filled');

hold off;

rotate3d on;

%%
% do color approximation using a Kriging model

inputs= [x, y, z];

[X, Y, Z, Fitness, model]= evaluate_kriging(inputs, fitness);

arrow3d_connect_dots(x_c, y_c, z_c, model);

set(gca, 'CLim', [min(fitness), max(fitness)]);

view([19.5 28]);

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="arrow3d.html">
% data_tool/arrow3d</a>
% </html>
% ,
% <html>
% <a href="predict_data.html">
% data_tool/predict_data</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
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
% <a href="matlab:doc('biogas_gui/gui_plot_optimresults')">
% biogas_gui/gui_plot_optimResults</a>
% </html>
% ,
% <html>
% <a href="arrow.html">
% data_tool/arrow</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('scatter3')">
% matlab/scatter3</a>
% </html>
% ,
% <html>
% <a href="plot3dsurface_alpha.html">
% data_tool/plot3dsurface_alpha</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/evaluate_kriging')">
% ml_tool/evaluate_kriging</a>
% </html>
%
%% TODOs
% # create documentation for script file
%
%% <<AuthorTag_DG/>>


