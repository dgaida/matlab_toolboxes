%% Syntax
%       fitness= getRecordedFitness(y, t)
%       fitness= getRecordedFitness(y, t, use_history)
%       fitness= getRecordedFitness(sensors, fitness_params)
%       fitness= getRecordedFitness(sensors, fitness_params, use_history)
%       
%% Description
% |fitness= getRecordedFitness(y, t)| returns the fitness out of the output
% stream |y| of a biogas plant simulation. In this call it is just the last
% row of |y|. For |use_history| = 1 it is more interesting, see the
% parameter. 
%
%%
% @param |y| : double column vector or matrix. It is a column vector if the
% objective function is scalar and a matrix if the objective function is a
% vector function (multi-objective optimization). Then the number of
% columns equals the dimension of the objective function and the number of
% rows equals the length of |t|.
%
%%
% @param |t| : double vector of time stream of simulation. 
%
%%
% @return |fitness| : double scalar or vector, result depends on argument
% |use_history|. It is a scalar if the objective function is scalar and a
% row vector if the objective function is a vector function
% (multi-objective optimization). 
%
%%
% @param |use_history| : 0 or 1, integer (double) or boolean
%
% * 0 : default behaviour, just the last row of |y| is returned as
% |fitness|. 
% * 1 : First, each column of |y| is resampled onto a sampletime of 1 day.
% Then fitness is the sum of the resampled |y| values over each column.
% Therefore the fitness value depends on the simulation duration, given by
% |t|. To |fitness| also a terminal cost is added. It is just the last
% value in |y| for each column of |y| and gets a weight of 10 %. 
%
%%
% |fitness= getRecordedFitness(sensors, fitness_params)| does the same as
% above with the only difference, that the out put of the model "y" is
% taken out of the C# |biogas.sensors| object |sensors|. 
%
%% <<sensors/>>
%
%%
% @param |fitness_params| : the |fitness_params| structure. Needed to get
% dimension of objective function. 
%
%% Example
%
%

getRecordedFitness(rand(21,1), 0:0.5:10, 1)


%% Dependencies
% 
% This function calls:
%
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
% <a href="matlab:doc biogas_scripts/is_sensors">
% biogas_scripts/is_sensors</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_fitness_params">
% biogas_scripts/is_fitness_params</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/interp1">
% matlab/interp1</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_optimization/getrecordedfitnessextended">
% biogas_optimization/getRecordedFitnessExtended</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc biogas_blocks/fitness_costs">
% biogas_blocks/fitness_costs</a>
% </html>
%
%% TODOs
% # improve documentation a bit, check it
% # maybe add a further example
% # make todos
%
%% <<AuthorTag_DG/>>


