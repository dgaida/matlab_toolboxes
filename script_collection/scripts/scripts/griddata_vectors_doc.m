%% Syntax
%       [X, Y]= griddata_vectors(x, y, z, f)
%       [...]= griddata_vectors(x, y, z, f, c)
%       [...]= griddata_vectors(x, y, z, f, c, samples)
%       [...]= griddata_vectors(x, y, z, f, c, samples, min_step_size)
%       [...]= griddata_vectors(x, y, z, f, c, samples, min_step_size,
%       interp_method) 
%       [...]= griddata_vectors(x, y, z, f, c, samples, min_step_size,
%       interp_method, useKriging) 
%       [X, Y, Z]= griddata_vectors(x, y, z, f, ...)
%       [X, Y, Z, F]= griddata_vectors(x, y, z, f, ...)
%       [X, Y, Z, F, C]= griddata_vectors(x, y, z, f, c, ...)
%       [X, Y, Z, F, C, model]= griddata_vectors(x, y, z, f, c, ...)
%       [X, Y, F]= griddata_vectors(x, y, [], f, ...)
%       [X, Y, F, C]= griddata_vectors(x, y, [], f, c, ...)
%       [X, Y, F, C, model]= griddata_vectors(x, y, [], f, c, ...)
%
%% Description
% |[X, Y]= griddata_vectors(x, y, z, f)| fits a surface of the form 
% |f= func(x,y,z)| to the data in the (usually) nonuniformly spaced vectors 
% (|x,y,z,f|). |griddata_vectors| interpolates this surface at a uniform 
% grid spanning from |min(x,y,z)| to |max(x,y,z)| containing |samples| grid 
% points in each direction (x,y,z) (default: 35, in total: 3 * 35) and a 
% minimal step size of |min_step_size| (default: 0.2). As interpolation
% method the given |interp_method| is used (default: 'linear'). Where the
% interpolation method returns |NaN|, there the 'nearest' neighbour
% interpolation method is used for interpolation. 
%
% This function is very similar to <matlab:doc('griddata') griddata>.
% Basically the grid is created in this function calling
% <matlab:doc('meshgrid') meshgrid>, which is needed by
% <matlab:doc('griddata') griddata>, which is called thereafter. 
%
%%
% @param |x| : double vector containing data of the 1st dimension
%
%%
% @param |y| : double vector containing data of the 2nd dimension. Must
% have as many elements as |x| has. 
%
%%
% @param |z| : double vector containing data of the 3rd dimension. Must
% have as many elements as |x| has. 
%
%%
% @param |f| : double vector containing data of a vector function f=
% func(x,y,z). Must have as many elements as |x| has. 
%
%%
% @return |X| : a grid data generated with <matlab:doc('meshgrid')
% meshgrid> and reaching from |min(x)| to |max(x)|. This grid contains 35
% points (argument: |samples|) and has a minimal step size of
% |min_step_size| (default: 0.2). 
%
%%
% @return |Y| : a grid data generated with <matlab:doc('meshgrid')
% meshgrid> and reaching from |min(y)| to |max(y)|. This grid contains 35
% points (argument: |samples|) and has a minimal step size of
% |min_step_size| (default: 0.2). 
%
%%
% |[...]= griddata_vectors(x, y, z, f, c)| lets you specify a further
% column vector |c|, which will interpolated over the grid |X|, |Y| as
% well. Is returned as |C|. 
%
%%
% @param |c| : double vector containing data, could be the colour for
% colour plots. Must have as many elements as |x| has. 
%
%%
% |[...]= griddata_vectors(x, y, z, f, c, samples)| lets you specify the
% number of samples the grid will have in each dimension. 
%
%%
% @param |samples| : number of samples between min and max values of |x|,
% |y| and |z|. double integer
% 
%%
% |[...]= griddata_vectors(x, y, z, f, c, samples, min_step_size)| lets you
% specify the minimum step size which must be fulfilled, independent of
% |samples|. If it would not be fulfilled with |samples| sample points,
% then more sample points are generated. 
%
%%
% @param |min_step_size| : minimum step size which must be fulfilled,
% independent of |samples|. double scalar. 
% 
%%
% |[...]= griddata_vectors(x, y, z, f, c, samples, min_step_size,
% interp_method)| lets you specify the interpolation method used to
% interpolate the function |f= func(x,y,z)| over the grid |X, Y, Z|. 
%
%%
% @param |interp_method| : interpolation method, char. 
% 
% * 'linear'  : Triangle-based linear interpolation (default) 
% * 'cubic'   : Triangle-based cubic interpolation
% * 'nearest' : Nearest neighbor interpolation
%
%%
% |[...]= griddata_vectors(x, y, z, f, c, samples, min_step_size,
% interp_method, useKriging)| 
%
%%
% @param |useKriging| : double scalar. 
%
% * 0 : do not use Kriging approximation (default).
% * 1 : use Kriging approximation instead of 'normal' interpolation. 
%
%%
% |[X, Y, Z]= griddata_vectors(x, y, z, f, c, ...)| also returns the grid
% over the 3rd dimension. 
%
%%
% @return |Z| : a grid data generated with <matlab:doc('meshgrid')
% meshgrid> and reaching from |min(z)| to |max(z)|. This grid contains 35
% points (argument: |samples|) and has a minimal step size of
% |min_step_size| (default: 0.2). 
%
%%
% |[X, Y, Z, F]= griddata_vectors(x, y, z, f, c, ...)| additionally returns
% the interpolated function |f| over the grid |X|, |Y|, |Z|. 
%
%%
% @return |F| : The interpolated function |f| over the grid |X|, |Y|, |Z|. 
% So |F|= func( |X|, |Y|, |Z| ). This grid contains 35
% points (argument: |samples|) and has a minimal step size of
% |min_step_size| (default: 0.2). 
%
%%
% |[X, Y, Z, F, C]= griddata_vectors(x, y, z, f, c, ...)| additionally
% returns the interpolated vector |c| over the grid |X|, |Y|, |Z|. 
%
%%
% @return |C| : The interpolated values |c| over the grid |X|, |Y|, |Z|. 
%
%%
% |[X, Y, Z, F, C, model]= griddata_vectors(x, y, z, f, c, ...)| returns the
% Kriging model. This call only applies, if |useKriging| is set to 1. 
%
%%
% @return |model| : Kriging model used for interpolation. 
%
%%
% |[X, Y, F]= griddata_vectors(x, y, [], f, c, ...)| lets you interpolate
% over a 2-dimensional domain, so: |f= func(x, y)| and |F= func(X, Y)|. 
%
%%
% |[X, Y, F, C]= griddata_vectors(x, y, [], f, c, ...)| addiotionally
% returns |C|. 
%
%%
% |[X, Y, F, C, model]= griddata_vectors(x, y, [], f, c, ...)| returns the
% Kriging model. This call only applies, if |useKriging| is set to 1. 
%
%%
% @return |model| : Kriging model used for interpolation. 
%
%% Example
%
% # Example I: 
%

rng(0);   % create random number generator
x= rand(100,1)*4 - 2;
y= rand(100,1)*4 - 2;
f= x .* exp(-x.^2 - y.^2);

[X, Y, F]= griddata_vectors(x, y, [], f);

mesh(X, Y, F);
hold on;
plot3(x, y, f, 'o');
hold off


%%
%
% # Example II: 
%

data= load_file('data_to_plot.mat');

inputs= [double(data(:, 2:3)), double(data(:,8))];

outputs= double(data(:, end));

[X, Y, Z, Fitness]= ...
          griddata_vectors(inputs(:,1), inputs(:,2), inputs(:,3), outputs, ...
                           [], [], [], [], 1);

subplot(1,2,1);

plot3dsurface_alpha(X, Y, Z, Fitness);

scatter3(inputs(:,1), inputs(:,2), inputs(:,3), [], outputs(:,1), ...
         's', 'filled', 'LineWidth', 0.01, 'MarkerEdgeColor', 'k');

hold('off');
daspect([1 1 1]);
view(3);
axis('tight');


subplot(1,2,2);

[X, Y, Z, Fitness, ~, model]= ...
          griddata_vectors(inputs(:,1), inputs(:,2), inputs(:,3), outputs, ...
                           [], [], [], [], 0);

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
% <a href="matlab:doc('ml_tool/evaluate_kriging')">
% ml_tool/evaluate_kriging</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/deleteduplicates')">
% data_tool/deleteDuplicates</a>
% </html>
% ,
% <html>
% <a href="matlab:doc meshgrid">
% matlab/meshgrid</a>
% </html>
% ,
% <html>
% <a href="matlab:doc triscatteredinterp">
% matlab/TriScatteredInterp</a>
% </html>
% ,
% <html>
% <a href="matlab:doc griddata">
% matlab/griddata</a>
% </html>
% ,
% <html>
% <a href="matlab:doc griddata3">
% matlab/griddata3</a>
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
% ,
% <html>
% <a href="matlab:doc script_collection/isn">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isr">
% script_collection/isR</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_gui/plot4dscatterdata">
% biogas_gui/plot4Dscatterdata</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_gui/plot_xyz">
% biogas_gui/plot_xyz</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc interp2">
% matlab/interp2</a>
% </html>
% ,
% <html>
% <a href="matlab:doc interp3">
% matlab/interp3</a>
% </html>
% ,
% <html>
% <a href="matlab:doc data_tool/plot3dsurface_alpha">
% data_tool/plot3dsurface_alpha</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/scatter3">
% matlab/scatter3</a>
% </html>
%
%% TODOs
% # make documentation for script file
% # check appearance of documentation
% # make TODO
%
%% <<AuthorTag_DG/>>


