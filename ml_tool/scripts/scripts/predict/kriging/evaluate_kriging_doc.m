%% Preliminaries
% # This function depends on the MATLAB Kriging Toolbox DACE
% <http://www2.imm.dtu.dk/~hbn/dace/ http://www2.imm.dtu.dk/~hbn/dace/>
% so this toolbox has to be installed first. 
%
%% Syntax
%       [X, Y, Z, Fitness, model]= evaluate_kriging(inputs, outputs)
%       [...]= evaluate_kriging(inputs, outputs, k)
%       [...]= evaluate_kriging(inputs, outputs, k, grid_size) 
%       [...]= evaluate_kriging(inputs, outputs, k, grid_size, opt_method) 
%       [X, Y, Z, Fitness, model, fit_kriging]= evaluate_kriging(inputs,
%       outputs, ...) 
%        
%% Description
% |[X, Y, Z, Fitness, model]= evaluate_kriging(inputs, outputs)| creates an
% optimal Kriging model fitting to the data |outputs|= F(|inputs|).
% Therefore the parameter |theta| is optimized using 5-fold
% cross-correlation and the optimization method CMA-ES calling
% <findoptimalkrigingmodel.html findOptimalKrigingModel>. Please pay
% attention to the fact, that the data is splitted randomly into the 5
% folds! Thus, this function only applies to time independent data. if the
% dimension of the input data |inputs| is smaller or equal 3, then the
% trained model is validated on a grid defined by the range of values of
% |inputs| with 20 sample points in each dimension. 
%
%% 
% @param |inputs| : Contains the input variables for the interpolation. The
% column number defines the dimension of the set, the number of rows the
% number of samples. 
%
%%
% @param |outputs| : Contains one or several output variables to
% interpolate.  The column number defines the dimension of the set, the
% number of rows the number of samples. Must have the same number of rows
% as |inputs|, otherwise an error is thrown. 
%
%%
% @return |X| : if dimension of |inputs| is smaller equal 3, then |X|
% contains the first dimension of the validation data, which is created
% validating the trained model on a grid defined by the range of values of 
% |inputs| with 20 sample points in each dimension. The format of the
% data is almost as it would be created using <matlab:doc('meshgrid')
% meshgrid>. If dimension of |inputs| is greater 3, then |X| is empty. 
%
%%
% @return |Y| : if dimension of |inputs| is smaller equal 3, then |Y|
% contains the 2nd dimension of the validation data, which is created
% validating the trained model on a grid defined by the range of values of 
% |inputs| with 20 sample points in each dimension. The format of the
% data is almost as it would be created using <matlab:doc('meshgrid')
% meshgrid>. If dimension of |inputs| is greater 3, then |Y| is empty. 
%
%%
% @return |Z| : if dimension of |inputs| is smaller equal 3, then |Z|
% contains the 3rd dimension of the validation data, which is created
% validating the trained model on a grid defined by the range of values of 
% |inputs| with 20 sample points in each dimension. The format of the
% data is almost as it would be created using <matlab:doc('meshgrid')
% meshgrid>. If dimension of |inputs| is greater 3, then |Z| is empty. 
%
%%
% @return |Fitness| : to be plotted data against the three axis. |Fitness|
% is the data returned by the Kriging model, thus |Fitness|= F(|X|, |Y|,
% |Z|). You can plot |Fitness| over (|X|, |Y|, |Z|) using
% <matab:doc('data_tool/plot3dsurface_alpha')
% data_tool/plot3dsurface_alpha>. 
%
%%
% @return |model| : Kriging model returned by the function
% <fitness_kriging.html fitness_kriging> or
% <matlab:doc('findoptimalkrigingmodel') findOptimalKrigingModel>,
% respectively. TODO: is this really the model which has created Fitness
% out of X, Y, Z ???
%
%%
% |[...]= evaluate_kriging(inputs, outputs, k)| lets you specify the k-fold
% cross-correlation. 
%
%%
% @param |k| : k of the k-fold cross validation. If no cross validation is
% desired then set k= 1 and then 15 % of the given data is used as test
% data. Default k= 5. Please pay attention to the fact, that the data is
% splitted randomly into the k folds! Thus, this function only applies to
% time independent data. 
%
%%
% |[...]= evaluate_kriging(inputs, outputs, k, grid_size)| lets you specify
% the number of evaluations in the to be evaluated grid. If the dimension
% of |inputs| is smaller or equal 3, then a grid is defined which has as
% many knots on each dimension as is specifed by |grid_size|. 
%
%%
% @param |grid_size| : number of evaluations in the to be evaluated grid.
% Either a acalar or a vector with the size of the number of input
% dimensions. 
%
%%
% |[...]= evaluate_kriging(inputs, outputs, k, grid_size, opt_method)| lets
% you specify the optimization method which is used to determine the
% optimal |theta| parameter of the Kriging model. If you do not want to
% optimize the Kriging model, then set |opt_method| to []. 
%
%%
% @param |opt_method| : char with the optimization method 
%
% * [] : no optimization of parameter |theta|
% * 'PSO' : Particle Swarm Optimization 
% * 'CMAES' : Covariance Matrix Adaptation Evolution Strategy
% * ...
%
%%
% |[X, Y, Z, Fitness, model, fit_kriging]= evaluate_kriging(inputs,
% outputs, ...)| returns the fitness of the Kriging model, as it is
% returned by the function <fitness_kriging.html fitness_kriging> or
% <matlab:doc('findoptimalkrigingmodel') findOptimalKrigingModel>,
% respectively.
%
%%
% @return |fit_kriging| : fitness of the Kriging model
%
%% Example
%

data= load_file('data_to_plot.mat');

inputs= [double(data(:, 8)), double(data(:, 2)), double(data(:, 3))];

outputs= double(data(:, end));

[X, Y, Z, Fitness, model, fit_model]= evaluate_kriging(inputs, outputs);

plot3dsurface_alpha(X, Y, Z, Fitness);

scatter3(inputs(:,1), inputs(:,2), inputs(:,3), [], ...
         outputs(:,1), 's', 'filled', 'LineWidth', 0.01, ...
         'MarkerEdgeColor', 'k');

hold off

daspect([1 1 1])

view(3); axis tight


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="findoptimalkrigingmodel.html">
% findOptimalKrigingModel</a>
% </html>
% ,
% <html>
% <a href="fitness_kriging.html">
% fitness_kriging</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('randi')">
% doc randi</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% doc validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/deleteduplicates')">
% data_tool/deleteDuplicates</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See also
% 
% <html>
% <a href="matlab:doc(data_tool/plot3dsurface_alpha')">
% data_tool/plot3dsurface_alpha</a>
% </html>
%
%% TODOs
% # create documentation for script
% # add reference
%
%% <<AuthorTag_DG/>>
%% References
% # 
%


