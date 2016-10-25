%% Preliminaries
% # This function depends on the MATLAB Kriging Toolbox DACE
% <http://www2.imm.dtu.dk/~hbn/dace/>
% so this toolbox has to be installed first. 
%
%% Syntax
%       [fitness]= fitness_kriging(inputs, outputs, validSet_index, ...
%                                  regMethod, corrMethod)
%       [fitness]= fitness_kriging(inputs, outputs, validSet_index, ...
%                                  regMethod, corrMethod, theta)
%       [fitness]= fitness_kriging(inputs, outputs, validSet_index, ...
%                                  regMethod, corrMethod, theta,
%                                  lob) 
%       [fitness]= fitness_kriging(inputs, outputs, validSet_index, ...
%                                  regMethod, corrMethod, theta,
%                                  lob, upb) 
%       [fitness, theta]= fitness_kriging(inputs, outputs, validSet_index, ...
%                                         regMethod, corrMethod, ...)
%       [fitness, theta, model]= fitness_kriging(inputs, outputs,
%                                                validSet_index, 
%                                                regMethod, corrMethod, ...)
%        
%% Description
% |[fitness]= fitness_kriging(inputs, outputs, validSet_index, regMethod,
% corrMethod)| 
%
%% 
% @param |inputs| : Contains the input variables for the interpolation. The
% column number defines the dimension of the set, the number of rows the
% number of samples. 
%
% es dürfen keine Duplikate in den Daten vorhanden sein, unter Nutzung
% von <evaluate_kriging.html evaluate_kriging> werden schon automatisch
% in der funktion die duplikate gelöscht, alternativ kann die Funktion
% |dsmerge| aus der Kriging Toolbox genutzt werden.
%
%%
% @param |outputs| : Contains one or several output variables to
% interpolate. The column number defines the dimension of the set, the
% number of rows the number of samples. Must have the same number of rows
% as |inputs|, otherwise an error is thrown. 
%
% es dürfen keine Duplikate in den Daten vorhanden sein, unter Nutzung
% von <evaluate_kriging.html evaluate_kriging> werden schon automatisch
% in der funktion die duplikate gelöscht, alternativ kann die Funktion
% |dsmerge| aus der Kriging Toolbox genutzt werden.
%
%%
% @param |validSet_index| : defines the cross validation sets. Must be a
% vector of numel of inputs respectively output dimensions. If you want to do a
% k-fold cross validation to determine the fitness, then the elements of
% the vector must be integers from 1 to k. You could use
% <matlab:doc('randi') randi> to generate 
% it, see example. If you do not want to do a cross validation, then you
% define the training dataset using 1's and the test data set using 0's.
%
%%
% @param |regMethod| : Chooses the regression methods for Kriging
%
% * 'poly0'  :   regression polynom of zero order
% * 'poly1'  :   regression polynom of first order
% * 'poly2'  :   regression polynom of second order
% 
%%
% @param |corrMethod| : Chooses the correlation model for interpolation
% between design sites
%
% * 'exponential'   :   exponential function
% * 'gaussian'      :   gaussian function
% * 'linear'        :   linear function
% * 'spherical'     :   spherical function
% * 'cubic spline'  :   cubic spline function
%
%%
% @return |fitness| : fitness of the kriging model : mean rmse over the
% k-fold cross validation between prediction and test data
%
%% 
% |[fitness]= fitness_kriging(inputs, outputs, validSet_index, regMethod,
% corrMethod, theta)| lets you specify the initial value of the parameter
% $theta$ of the Kriging model. 
%
%%
% @param |theta| : correlation constant of the Kriging model. Double vector
% with same number of dimension as |inputs|. Default: 10 for each
% dimension. 
%
%%
% |[fitness]= fitness_kriging(inputs, outputs, validSet_index, regMethod,
% corrMethod, theta, lob)| 
%
%%
% @param |lob| : lower bound for theta, double vector, length equals
% dimension of |inputs|. Default: 1e-3 for each dimension.
%
%%
% |[fitness]= fitness_kriging(inputs, outputs, validSet_index, regMethod,
% corrMethod, theta, lob, upb)| 
%
%%
% @param |upb| : upper bound for theta, double vector, length equals
% dimension of |inputs|. Default: 20 for each dimension.
%
%%
% |[fitness, theta]= fitness_kriging(inputs, outputs, validSet_index,
% regMethod, corrMethod, ...)| 
%
%%
% @return |theta| : optimal theta values. TODO: not yet the optimal values
%
%%
% |[fitness, theta, model]= fitness_kriging(inputs, outputs,
% validSet_index, regMethod, corrMethod, ...)| 
%
%%
% @return |model| : Kriging model. TODO: not yet the optimal model
%
%% Example
%

data= load_file('data_to_plot.mat');

inputs= [double(data(:, 2:3)), double(data(:,8))];

outputs= double(data(:, end));

[inputs, outputs]= deleteDuplicates(inputs, outputs);

validSet_index= randi(5, size(outputs, 1), 1);

[ fitness, model ]= ...
          fitness_kriging(inputs, outputs, validSet_index, ...
                          'poly0', 'gaussian');
                        
disp(fitness)
disp(model)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('unique')">
% doc('unique')</a>
% </html>
% ,
% <html>
% <a href="matlab:edit('dacefit.m')">
% edit('dacefit.m')</a>
% </html>
% ,
% <html>
% <a href="matlab:edit('predictor.m')">
% edit('predictor.m')</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="findoptimalkrigingmodel.html">
% findOptimalKrigingModel</a>
% </html>
% ,
% <html>
% <a href="evaluate_kriging.html">
% evaluate_kriging</a>
% </html>
%
%% See also
% 
% <html>
% <a href="matlab:doc('randi')">
% doc('randi')</a>
% </html>
%
%% TODOs
% # check input params
% # improve and create documentation for script file
% # add a reference
% # Leave-One-Out-Kreuzvalidierung implementieren, should be possible using
% findOptimalKrigingModel.m and setting validSet_index explicitly to ones,
% except one value to 0. and then shift the 0 through the vector. 
% # solve TODO inside file
%
%% <<AuthorTag_DG/>>
%% References
% # 
%


