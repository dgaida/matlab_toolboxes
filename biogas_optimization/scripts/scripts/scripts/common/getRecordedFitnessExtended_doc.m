%% Syntax
%       fitness= getRecordedFitnessExtended(sensors, substrate, plant, y,
%       t) 
%       fitness= getRecordedFitnessExtended(sensors, substrate, plant, y,
%       t, fitness_params) 
%       fitness= getRecordedFitnessExtended(sensors, substrate, plant, y,
%       t, fitness_params, use_history) 
%       fitness= getRecordedFitnessExtended(sensors, substrate, plant, y,
%       t, fitness_params, use_history, init_substrate_feed) 
%       [fitness, udotnorm, xdotnorm]= getRecordedFitnessExtended(...) 
%       
%% Description
% |fitness= getRecordedFitnessExtended(sensors, substrate, plant, y, t)|
% returns the fitness of a simulation. Must be called after the simulation
% is finished. It calls the following three functions. The latter two
% functions are only called if |use_history| == 1: 
%
% * <matlab:doc('biogas_optimization/getrecordedfitness')
% biogas_optimization/getRecordedFitness> 
% * <matlab:doc('biogas_optimization/getudotnorm')
% biogas_optimization/getudotnorm>
% * <matlab:doc('biogas_optimization/getxdotnorm')
% biogas_optimization/getxdotnorm>
%
% The values returned by the latter two functions is added to the last
% |fitness| value. In case of a single-objective optimization problem there
% is only one fitness value. 
%
%% <<sensors/>>
%
%% <<substrate/>>
%
%% <<plant/>>
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
% @param |fitness_params| : the |fitness_params| structure. Needed to get
% dimension of objective function. 
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
% @param |init_substrate_feed| : this is the initial substrate feed of the
% plant, before the simulation is started. This is needed to calculate the
% change of the substrate feed from the initial to the one first applied to
% the plant. If this is unknown, it is assumed, that the feed which is
% applied in the beginning of the simulation is equal to the initial feed.
% It is in the responsibility of the user to assure this, otherwise the
% returned value of the called function <getudotnorm.html getudotnorm> will
% not be exact. It is a double matrix 
% with number of rows equal to the substrates and number of columns equal
% to number of digesters. The values are the feeds measured in m³/d. 
%
%%
% @return |udotnorm| : value returned by
% <matlab:doc('biogas_optimization/getudotnorm') 
% biogas_optimization/getudotnorm>
%
%%
% @return |xdotnorm| : value returned by
% <matlab:doc('biogas_optimization/getxdotnorm') 
% biogas_optimization/getxdotnorm>
%
%% Example
%
%

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
% <a href="matlab:doc biogas_scripts/is_substrate">
% biogas_scripts/is_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_plant">
% biogas_scripts/is_plant</a>
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
% <a href="matlab:doc biogas_optimization/getrecordedfitness">
% biogas_optimization/getRecordedFitness</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_optimization/getudotnorm">
% biogas_optimization/getudotnorm</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_optimization/getxdotnorm">
% biogas_optimization/getxdotnorm</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_optimization/simbiogasplant">
% biogas_optimization/simBiogasPlant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_optimization/simbiogasplantbasic">
% biogas_optimization/simBiogasPlantBasic</a>
% </html>
% ,
% <html>
% <a href="matlab:doc data_tool/writetodatabase">
% data_tool/writetodatabase</a>
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
% # improve documentation
% # add code documentation
% # add an example
% # make todos
% # increase release number when numbers of getudotnorm and getxdotnorm
% increase
% # xdotnorm gefällt mir noch nicht
% # vorfaktor vor udotnorm könnte man noch als parameter machen, damping
% factor
%
%% <<AuthorTag_DG/>>


