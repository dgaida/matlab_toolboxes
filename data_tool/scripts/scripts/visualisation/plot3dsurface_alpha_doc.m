%% Syntax
%       plot3dsurface_alpha(X, Y, Z, Fitness)
%       plot3dsurface_alpha(X, Y, Z, Fitness, plotBoundaryLines)
%       plot3dsurface_alpha(X, Y, Z, Fitness, plotBoundaryLines, alpha_val)
%       plot3dsurface_alpha(X, Y, Z, Fitness, plotBoundaryLines, alpha_val,
%       eval_at_1) 
%       plot3dsurface_alpha(X, Y, Z, Fitness, plotBoundaryLines, alpha_val,
%       eval_at_1, eval_at_2) 
%        
%% Description
% |plot3dsurface_alpha(X, Y, Z, Fitness)| plots a partly transparent cube
% in the space (X, Y, Z). The color of the cube is gotten from |Fitness|.
% The alpha channel is set to 0.25. In the beginning of the function
% <matlab:doc('newplot') newplot> is called, such that in each case a new
% plot is generated, thus a |hold on| call before calling this function
% will not work. 
%
%%
% @param |X| : data of the first of the 3 axes, format as it would be
% created using <matlab:doc('meshgrid') meshgrid> or 
% <matlab:doc('ml_tool/evaluate_kriging') evaluate_kriging>
%
%%
% @param |Y| : data of the second of the 3 axes, format as it would be
% created using <matlab:doc('meshgrid') meshgrid> or
% <matlab:doc('ml_tool/evaluate_kriging') evaluate_kriging> 
%
%%
% @param |Z| : data of the third of the 3 axes, format as it would be
% created using <matlab:doc('meshgrid') meshgrid> or
% <matlab:doc('ml_tool/evaluate_kriging') evaluate_kriging> 
%
%%
% @param |Fitness| : to be plotted data against the 3 axes, format as it
% would be created using <matlab:doc('griddata3') griddata3> or
% <matlab:doc('ml_tool/evaluate_kriging') evaluate_kriging> 
%
%%
% |plot3dsurface_alpha(X, Y, Z, Fitness, plotBoundaryLines)| plots lines
% which bound the cube. 
%
%%
% @param |plotBoundaryLines| : if 1, then plot lines at the boundary of the
% to be plotted region, else 0, no lines are plotted (default).
%
%%
% |plot3dsurface_alpha(X, Y, Z, Fitness, plotBoundaryLines, alpha_val)|
% lets you specify the alpha value. 
%
%%
% @param |alpha_val| : alpha value, double scalar between 0 and 1 (default:
% 0.25). The lower the alpha value is, the more transparent the cube will
% be. 
%
%%
% |plot3dsurface_alpha(X, Y, Z, Fitness, plotBoundaryLines, alpha_val,
% eval_at_1)| defines where the color of the cube is gotten from, which is
% visualized at the lower boundary of the cube.  
%
%%
% @param |eval_at_1| : basically a cube is plotted. If data |Fitness| was
% created using interpolation, then maybe the edges and boundaries of the
% cube are not interpolated well, so maybe you do not want to evaluate the
% |Fitness| array at the lower boundary but elsewhere. Pass here a char,
% ranging from '1', '2', ..., 'end'. default: '1'.
%
%%
% |plot3dsurface_alpha(X, Y, Z, Fitness, plotBoundaryLines, alpha_val,
% eval_at_1, eval_at_2)| defines where the color of the cube is gotten
% from, which is visualized at the upper boundary of the cube.  
%
%%
% @param |eval_at_2| : basically a cube is plotted. If data |Fitness| was
% created using interpolation, then maybe the edges and boundaries of the
% cube are not interpolated well, so maybe you do not want to evaluate the
% |Fitness| array at the upper boundary but elsewhere. Pass here a char,
% ranging from '1', '2', ..., 'end'. default: 'end'.
%
%% Example
%

data= load_file('data_to_plot.mat');

inputs= [double(data(:, 2:3)), double(data(:,8))];

outputs= double(data(:, end));

[X, Y, Z, Fitness, model]= evaluate_kriging(inputs, outputs);

plot3dsurface_alpha(X, Y, Z, Fitness);

scatter3(inputs(:,1), inputs(:,2), inputs(:,3), [], outputs(:,1), ...
         's', 'filled', 'LineWidth', 0.01, 'MarkerEdgeColor', 'k');

hold('off');
daspect([1 1 1]);
view(3);
axis('tight');

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('surface')">
% matlab/surface</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('line')">
% matlab/line</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('newplot')">
% matlab/newplot</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('alpha')">
% matlab/alpha</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/is0or1">
% script_collection/is0or1</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_gui/gui_plot_optimresults')">
% biogas_gui/gui_plot_optimResults</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('ml_tool/evaluate_kriging')">
% ml_tool/evaluate_kriging</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/fitness_kriging')">
% ml_tool/fitness_kriging</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/findoptimalkrigingmodel')">
% ml_tool/findOptimalKrigingModel</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('scatter3')">
% matlab/scatter3</a>
% </html>
% ,
% <html>
% <a href="matlab:doc data_tool/scatter3markeredgecolor">
% data_tool/scatter3MarkerEdgeColor</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('daspect')">
% matlab/daspect</a>
% </html>
%
%% TODOs
% # create documentation for script file
%
%% <<AuthorTag_DG/>>


