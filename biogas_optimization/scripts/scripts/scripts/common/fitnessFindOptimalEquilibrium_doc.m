%% Syntax
%     [fitness]= fitnessFindOptimalEquilibrium(u, popBiogas, plant,
%     substrate, plant_network, substrate_network, fitness_params,
%     timespan, savePop, nWorker, method) 
%     [...]= fitnessFindOptimalEquilibrium(u, popBiogas, plant, substrate,
%     plant_network, substrate_network, fitness_params, timespan, savePop,
%     nWorker, method, model_suffix) 
%     [...]= fitnessFindOptimalEquilibrium(u, popBiogas, plant, substrate,
%     plant_network, substrate_network, fitness_params, timespan, savePop,
%     nWorker, method, model_suffix, control_horizon) 
%     [fitness, linIneq]= fitnessFindOptimalEquilibrium(...) 
%
%% Description
% fitness function used to find the optimal equilibrium point of a biogas
% plant
%
%%
% @param |u| : individual (consists out of flux and state of digesters and
% ADM params). double row vector 
%
%%
% @param |popBiogas| : object of class 
% <matlab:doc('biogas_optimization/popbiogas')
% biogasM.optimization.popBiogas>  
%
%%
% @param |plant|, |substrate| : well known structures of the plant
%
%%
% @param |plant_network|, |substrate_network| : see structure files
%
%%
% @param |fitness_params| : contains a structure with fitness parameters
%
%%
% @param |timespan| : simulation duration in the form [0, 50]. to simulate
% 50 days. 
%
%%
% @param |savePop| : if 1, then the population is saved, else 0. This
% parameter is not used at the moment. TODO!!!
%
%%
% @param |nWorker| : double scalar with the number of workers in the
% cluster or multicore environment
%
%%
% @param |method| : char defining the used optimization method
%
%%
% @param |model_suffix| : a char specifying the to be simulated model
% the model has the name ['plant_sunderhook', model_suffix]
%
% default is []
%
%%
% @param |control_horizon| : double scalar defining the duration of the
% control horizon in days
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
% @return |fitness| : fitness of the equilibrium point
%
%%
% @return |linIneq| : methods like ISRES and DE need the linear inequality
% constraints as a second return value
%
%% Example
%
%
%% Dependencies
%
% This method calls:
%
% <html>
% <a href="simbiogasplantextended.html">
% simBiogasPlantExtended</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/getmatlabversion')">
% script_collection/getMATLABVersion</a>
% </html>
% ,
% <html>
% <a href="matlab:doc optimization_tool/getismatlabpoolopen">
% optimization_tool/getIsMatlabPoolOpen</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/getequilibriumfromindividual')">
% biogas_optimization/biogasM.optimization.popBiogas.getEquilibriumFromIndividual</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/evalindividualforconstraints')">
% biogas_optimization/biogasM.optimization.popBiogas.evalIndividualForConstraints</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/init_admparams_from_mat_file')">
% biogas_blocks/init_ADMparams_from_mat_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/getadm1paramsfromindividual')">
% biogas_optimization/biogasM.optimization.popBiogas.getADM1ParamsFromIndividual</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('numerics_tool/getpointsinfulldimension')">
% numerics_tool/getPointsInFullDimension</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="findoptimalequilibrium.html">
% findOptimalEquilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/popbiogas')">
% biogas_optimization/biogasM.optimization.popBiogas</a>
% </html>
%
%% See Also
%
%
%% TODOs
% # es gibt ein paar TODOs im file
% # improve documentation
% # parallel mode not implemented
%
%% <<AuthorTag_DG/>>


