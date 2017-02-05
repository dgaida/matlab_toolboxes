%% Syntax
%       [substrate_network_min, substrate_network_max]=
%       NMPC_load_SubstrateFlow(substrate, substrate_network, plant)
%       [substrate_network_min, substrate_network_max]=
%       NMPC_load_SubstrateFlow(substrate, substrate_network, plant,
%       id_read)
%
%% Description
% |NMPC_load_SubstrateFlow(substrate, substrate_network, plant)| loads the
% input substrate feed for each substrate (_substrate_id_) from the 
% |volumeflow__substrate_id__const.mat| file for the |startNMPC| 
% function. The values of these files are assigned to the caller workspace 
% calling <matlab:doc('assignin') assignin> (not anymore, not needed). 
% Furthermore |substrate_network_min| and |substrate_network_max| are set
% to the current volumeflow inside these files. Using |substrate_network|
% the volumeflows are splitted over the digesters. The volumeflow_const
% files define the initial state from which the nonlinear MPC algorithm
% should start from. 
%
%% <<substrate/>>
%% <<substrate_network/>>
%% <<plant/>>
%%
% @param |id_read|   : select the id *.mat files for the plants inputs 
% (substrate flow, flow between fermenters); e.g. if id_read == 1 the 
% |startNMPC| loads the input *.mat files such as 
% |volumeflow_bullmanure_const_1.mat| for the optimization. If empty the
% standard value is [].
%
%% Example
% 
%

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

%%

[substrate, plant, substrate_network]= load_biogas_mat_files('gummersbach');

%%

[substrate_network_min, substrate_network_max]= ...
  NMPC_load_SubstrateFlow(substrate, substrate_network, plant);

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
% <a href="matlab:doc('load_file')">
% load_file</a>
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
% <a href="nmpc_load_fermenterflow.html">
% NMPC_load_FermenterFlow</a>
% </html>
% ,
% <html>
% <a href="nmpc_save_ctrl_strgy_fermenterflow.html">
% NMPC_save_ctrl_strgy_FermenterFlow</a>
% </html>
%
%% TODOs
% # improve documentation
% # be careful: volumeflow const files are used! is this correct??? it is
% correct, becasue they define the initial state where to start from
% # why are the volumeflow files assigned to the caller workspace? not
% anymore
% # check appearance of documentation
%
%% <<AuthorTag_ALSB/>>

    
