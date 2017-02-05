%% Syntax
%       NMPC_save_SimOptmimData(substrate, plant, plant_id, plant_network, 
%            plant_network_max, equilibrium, initstate)
%       NMPC_save_SimOptmimData(substrate, plant, plant_id, plant_network, 
%            plant_network_max, equilibrium, initstate, id_write)
%       NMPC_save_SimOptmimData(substrate, plant, plant_id, plant_network, 
%            plant_network_max, equilibrium, initstate, id_write, nsteps) 
%       NMPC_save_SimOptmimData(substrate, plant, plant_id, plant_network, 
%            plant_network_max, equilibrium, initstate, id_write, nsteps,
%            delta)
% 
%% Description
% |NMPC_save_SimOptmimData(substrate, plant, plant_id, plant_network, ...
% plant_network_max, equilibrium, initstate, id_read, id_write)| is called
% at the end of <startnmpc.html startNMPC>. It saves the last gotten
% substrate mix and fermenter flux, these are the "optimal" ones inside
% volumeflow_..._const.mat files. Furthermore the user files for both are
% saved, in those the feeds over the whole control process is saved. Before
% saving in user files, the last gotten value is appended a second time at
% the end of the stream to have a constant stream for simulation times
% higher then the control time.
%
%% <<substrate/>>
%% <<plant/>>
%% <<plant_network/>>
%% <<plant_network_max/>>
%% <<equilibrium/>>
%%
% @param |initstate| : initstate structure
%
%%
% @param |id_write|  : Defines the additional indice for writing in
% volumeflow and initstate files in which are saved in this function.
%
%%
% @param |nsteps| : ratio of control horizon / delta
%
%% <<delta/>>
%% Example
%
%

cd( fullfile( getBiogasLibPath(), 'examples/nmpc/Gummersbach' ) );

%%

[substrate, plant, ~, plant_network, ...
 substrate_network_min, substrate_network_max, ...
 plant_network_min, plant_network_max]= ...
 load_biogas_mat_files('gummersbach');

%%

equilibrium= load_file('equilibrium_gummersbach');
initstate= load_file('initstate_gummersbach');

control_horizon= 3; % days

%%

[substrate_network_min, substrate_network_max]= ...
 NMPC_save_ctrl_strgy_SubstrateFlow(substrate, plant, ...
 substrate_network_min, substrate_network_max, equilibrium, control_horizon, 1);

[plant_network_min, plant_network_max]= ...
  NMPC_save_ctrl_strgy_FermenterFlow(substrate, plant, ...
  plant_network, plant_network_min, plant_network_max, equilibrium, ...
  control_horizon, 3);
  
%%

NMPC_save_SimOptmimData(substrate, plant, 'gummersbach', plant_network, ...
            plant_network_max, equilibrium, initstate, [], 1, 3);


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
% <a href="matlab:doc('createvolumeflowfile')">
% createvolumeflowfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_initstate_dig_oo_equilibrium')">
% biogas_scripts/get_initstate_dig_oo_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/getnumdigestersplits')">
% biogas_scripts/getNumDigesterSplits</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_feed_oo_equilibrium')">
% biogas_scripts/get_feed_oo_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_sludge_oo_equilibrium')">
% biogas_scripts/get_sludge_oo_equilibrium</a>
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
% # lenGenomSubstrate, s. file
% # improve documentation
% # improve code
%
%% <<AuthorTag_ALSB_AKV/>>


