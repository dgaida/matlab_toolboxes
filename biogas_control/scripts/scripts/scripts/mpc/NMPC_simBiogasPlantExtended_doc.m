%% Syntax
%       [fit, equilibrium]= NMPC_simBiogasPlantExtended(fcn, equilibrium,
%       plant, substrate, plant_network, substrate_network, fitness_params,
%       timespan, control_horizon, lenGenomSubstrate, nSteps) 
%       [...]= NMPC_simBiogasPlantExtended(fcn, equilibrium,
%       plant, substrate, plant_network, substrate_network, fitness_params,
%       timespan, control_horizon, lenGenomSubstrate, nSteps, use_history, 
%       init_substrate_feed) 
%       [fit, equilibrium, plant]= NMPC_simBiogasPlantExtended(...) 
%       [fit, equilibrium, plant, data]= NMPC_simBiogasPlantExtended(...) 
%
%% Description
% |[...]= NMPC_simBiogasPlantExtended(...)| calls
% <matlab:doc('simbiogasplantextended') simBiogasPlantExtended> to run a
% simulation. Before <matlab:doc('setsavestateofadm1blocks')
% setSaveStateofADM1Blocks> is called, such that the state at the end of
% the simulation is saved inside the respective workspace. After the
% simulation this setting is reset again. The plant model is load and
% closed in this function. 
%
%%
% @param |fcn| : char with the plant name, e.g. 'plant_gummersbach'
%
%% <<equilibrium/>>
%% <<plant/>>
%% <<substrate/>>
%% <<plant_network/>>
%% <<subtrate_network/>>
%%
% @param |fitness_params| : structure with fitness parameters
%
%%
% @param |timespan| : 2dim double array defining the simulation time, e.g.
% [0 100], to simulate 100 days
%
%% <<control_horizon/>>
%%
% @param |lenGenomSubstrate| : 
% 
%%
% @param |nSteps| : 
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
% @param |init_substrate_feed| : 
% 
%%
% @return |fit| : fitness of the new equilibrium at the end of the
% simulation, double scalar
%
%%
% @return |equilibrium| : the new equilibrium
%
%%
% @return |plant| : C# object of |biogas.plant|, same as given |plant|
% object, except it is evaluated after the simulation in the modelworkspace.
% First of all it contains the correct ADM1 parameters. 
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_system')">
% biogas_scripts/load_biogas_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/setsavestateofadm1blocks')">
% biogas_scripts/setSaveStateofADM1Blocks</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('simbiogasplantextended')">
% simBiogasPlantExtended</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/close_biogas_system')">
% biogas_scripts/close_biogas_system</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_control/startnmpcatequilibrium')">
% biogas_control/startNMPCatEquilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_tmrfcn')">
% biogas_control/NMPC_TmrFcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_getequilibriumfromfiles')">
% biogas_control/NMPC_getEquilibriumFromFiles</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="nmpc_load_fermenterflow.html">
% NMPC_load_FermenterFlow</a>
% </html>
% ,
% <html>
% <a href="nmpc_save_ctrl_strgy_fermenterflow.html">
% NMPC_save_ctrl_strgy_FermenterFlow</a>
% </html>
% ,
% <html>
% <a href="nmpc_ctrl_strgy_substrateflow_minmax.html">
% NMPC_ctrl_strgy_SubstrateFlow_MinMax</a>
% </html>
% ,
% <html>
% <a href="nmpc_save_ctrl_strgy_substrateflow.html">
% NMPC_save_ctrl_strgy_SubstrateFlow</a>
% </html>
%
%% TODOs
% # improve documentation
% # check code
%
%% <<AuthorTag_ALSB_AKV/>>


