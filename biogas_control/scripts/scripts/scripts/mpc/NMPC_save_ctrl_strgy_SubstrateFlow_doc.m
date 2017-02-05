%% Syntax
%       [substrate_network_min, substrate_network_max]= ...
%       NMPC_save_ctrl_strgy_SubstrateFlow(substrate, plant,
%       substrate_network_min, substrate_network_max, equilibrium,
%       control_horizon, nSteps)  
% 
%% Description
% |[substrate_network_min, substrate_network_max]= ...
% NMPC_save_ctrl_strgy_SubstrateFlow(substrate, plant,
% substrate_network_min, substrate_network_max, equilibrium,
% control_horizon, nSteps)| adds the new simulated values for substrate 
% flow, which are saved inside |equilibrium|, to the
% volumeflow_..._user variables in the workspace of the 
% calling function <startnmpc.html startNMPC>. Furthermore it
% sets |substrate_network_min| and |substrate_network_max| to the current
% substrate flow values.
%
%% <<substrate/>>
%% <<plant/>>
%% <<substrate_network_min/>>
%% <<substrate_network_max/>>
%% <<equilibrium/>>
%% <<control_horizon/>>
%%
% @param |nSteps| : ratio of control horizon / delta
%
%% Example
%
%

[substrate, plant, ~, ~, ...
 substrate_network_min, substrate_network_max]= ...
 load_biogas_mat_files('gummersbach');

%%

equilibrium= load_file('equilibrium_gummersbach');

control_horizon= 3; % days

%%

[substrate_network_min, substrate_network_max]= ...
 NMPC_save_ctrl_strgy_SubstrateFlow(substrate, plant, ...
 substrate_network_min, substrate_network_max, equilibrium, control_horizon, 1);

disp(substrate_network_min)
disp(substrate_network_max)


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
% <a href="matlab:doc('biogas_scripts/get_feed_oo_equilibrium')">
% biogas_scripts/get_feed_oo_equilibrium</a>
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
% <a href="matlab:doc('biogas_scripts/is_substrate_network')">
% biogas_scripts/is_substrate_network</a>
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
% <a href="nmpc_save_simoptmimdata.html">
% NMPC_save_SimOptmimData</a>
% </html>
% ,
% <html>
% <a href="nmpc_save_ctrl_strgy_fermenterflow.html">
% NMPC_save_ctrl_strgy_FermenterFlow</a>
% </html>
% ,
% <html>
% <a href="nmpc_load_substrateflow.html">
% NMPC_load_SubstrateFlow</a>
% </html>
%
%% TODOs
% # improve documentation
% # improve code
% # adapt towards lenGenomPump - WHY?
%
%% <<AuthorTag_ALSB_AKV/>>


