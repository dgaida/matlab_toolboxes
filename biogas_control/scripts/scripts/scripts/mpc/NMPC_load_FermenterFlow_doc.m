%% Syntax
%       [plant_network_min, plant_network_max]=
%       NMPC_load_FermenterFlow(plant, plant_network, plant_network_min,
%       plant_network_max)
%       [...]= NMPC_load_FermenterFlow(plant, plant_network,
%       plant_network_min, plant_network_max, id_read)
% 
%% Description
% |NMPC_load_FermenterFlow(plant, plant_network, plant_network_min,
% plant_network_max)| loads the fermenter flux from
% the |volumeflow_fermenter1_fermenter2_const.mat| files for the |startNMPC|
% function. The values of these files are assigned to the caller workspace
% (not anymore, not needed). 
% Furthermore |plant_network_min| and |plant_network_max| are set to the
% current volumeflow inside these files.
%
%% <<plant/>>
%% <<plant_network/>>
%% <<plant_network_min/>>
%% <<plant_network_max/>>
%%
% @param |id_read|   : select the id *.mat files for the plants inputs 
% (substrate flow, flow between fermenters); e.g. if id_read == 1 the 
% |startNMPC| loads the input *.mat files such as 
% volumeflow_bullmanure_const_1.mat for the optimization. If empty the
% standard value is [].
%
%% Example
% 
%

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

%%

[~, plant, ~, plant_network, ~, ~, ...
 plant_network_min, plant_network_max]= load_biogas_mat_files('gummersbach');

%%

[plant_network_min, plant_network_max]= ...
  NMPC_load_FermenterFlow( plant, plant_network, plant_network_min, ...
                           plant_network_max );

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
% <a href="matlab:doc('biogas_scripts/getnumdigestersplits')">
% biogas_scripts/getNumDigesterSplits</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_file')">
% biogas_scripts/load_file</a>
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
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_control/nmpc_prepare_files')">
% biogas_control/NMPC_prepare_files</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="nmpc_load_substrateflow.html">
% biogas_scripts/NMPC_load_SubstrateFlow</a>
% </html>
% ,
% <html>
% <a href="nmpc_save_ctrl_strgy_fermenterflow.html">
% biogas_scripts/NMPC_save_ctrl_strgy_FermenterFlow</a>
% </html>
%
%% TODOs
% # improve documentation a little
% # why are volumeflow_const variables assigned to the caller workspace?
%
%% <<AuthorTag_ALSB/>>


