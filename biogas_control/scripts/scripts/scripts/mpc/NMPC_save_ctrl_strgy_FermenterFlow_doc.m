%% Syntax
%       [plant_network_min, plant_network_max]= 
%       NMPC_save_ctrl_strgy_FermenterFlow(substrate, plant,
%       plant_network, plant_network_min, plant_network_max, equilibrium,
%       control_horizon, delta)  
% 
%% Description
% |[plant_network_min, plant_network_max]= 
% NMPC_save_ctrl_strgy_FermenterFlow(substrate, plant,
% plant_network, plant_network_min, plant_network_max, equilibrium,
% control_horizon, delta)| adds the new simulated values for fermenter
% fluxes, which are saved inside |equilibrium|, to the
% volumeflow_..._user variables in the workspace of the 
% calling function <startnmpc.html startNMPC>. Furthermore it
% sets |plant_network_min| and |plant_network_max| to the current
% fermenter flux values.
%
%% <<substrate/>>
%% <<plant/>>
%% <<plant_network/>>
%% <<plant_network_min/>>
%% <<plant_network_max/>>
%% <<equilibrium/>>
%% <<control_horizon/>>
%% <<delta/>>
%% Example
%
%

[substrate, plant, ~, plant_network, ~, ~, ...
 plant_network_min, plant_network_max]= ...
  load_biogas_mat_files('gummersbach');

%%

equilibrium= load_file('equilibrium_gummersbach');

control_horizon= 3; % days

%%

[plant_network_min, plant_network_max]= ...
  NMPC_save_ctrl_strgy_FermenterFlow(substrate, plant, ...
    plant_network, plant_network_min, plant_network_max, equilibrium, ...
    control_horizon, 3);

disp(plant_network_min)
disp(plant_network_max)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('assignin')">
% matlab/assignin</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('evalin')">
% matlab/evalin</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/getnumdigestersplits')">
% biogas_scripts/getNumDigesterSplits</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_sludge_oo_equilibrium')">
% biogas_scripts/get_sludge_oo_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_append2volumeflow_user')">
% biogas_control/NMPC_append2volumeflow_user</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_substrate')">
% biogas_scripts/is_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant')">
% biogas_scripts/is_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant_network')">
% biogas_scripts/is_plant_network</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_equilibrium')">
% biogas_scripts/is_equilibrium</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_control/startnmpc')">
% biogas_control/startNMPC</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="nmpc_save_ctrl_strgy_substrateflow.html">
% NMPC_save_ctrl_strgy_SubstrateFlow</a>
% </html>
% ,
% <html>
% <a href="nmpc_save_simoptmimdata.html">
% NMPC_save_SimOptmimData</a>
% </html>
% ,
% <html>
% <a href="nmpc_load_substrateflow.html">
% NMPC_load_SubstrateFlow</a>
% </html>
% ,
% <html>
% <a href="nmpc_load_fermenterflow.html">
% NMPC_load_FermenterFlow</a>
% </html>
%
%% TODOs
% # improve documentation a little bit
% # check appearance of documentation
%
%% <<AuthorTag_ALSB_AKV/>>


