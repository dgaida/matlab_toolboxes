%% Syntax
%       [change_substrate, change_fermenter]= NMPC_ctrl_strgy_change(
%       change, substrate, plant, plant_network, plant_network_max)
%
%% Description
% |[change_substrate, change_fermenter]= NMPC_ctrl_strgy_change(change,
% substrate, plant, plant_network, plant_network_max)| sets change for
% substrate and fermenter flow. |change| and the returned values are either
% measured in |m³/d| or |100 %|. 
%
%%
% @param |change| : double scalar or vector defining the change value of
% the substrates and flows. If a scalar, then change of substrate and
% fermenter flows are the same for all substrates and flows. If it is a
% vector, then the first |n_fermenter| * |n_substrate| elements define the
% change values for the substrates and the rest for the fermenter flows.
% There are errors and warnings thrown, if size of vector is not correct.
%
%% <<substrate/>>
%% <<plant/>>
%% <<plant_network/>>
%% <<plant_network_max/>>
%%
% @return |change_substrate| : a scalar, then change for all substrates is
% equal or a matrix with n_substrate rows and n_fermenter columns, where
% the change value is defined for each substrate and digester. 
%
%%
% @return |change_fermenter| : either a scalar, then change is equal for
% all digester connections or a matrix of size |plant_network|. 
%
%% Example
% 
%

try
  [substrate, plant, substrate_network, plant_network, ...
   substrate_network_min, substrate_network_max, ...
   plant_network_min, plant_network_max]= ...
  load_biogas_mat_files('gummersbach');
catch ME
  disp(ME.message);
end

%%
% change measured in m³/d
change= [1,3,2,0,0,0,6];

[change_substrate, change_fermenter]= ...
       NMPC_ctrl_strgy_change( change, substrate, plant, ...
                               plant_network, plant_network_max );

disp(change_substrate)

disp(change_fermenter)

%%

change= 6;

[change_substrate, change_fermenter]= ...
       NMPC_ctrl_strgy_change( change, substrate, plant, ...
                               plant_network, plant_network_max );

disp(change_substrate)

disp(change_fermenter)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('reshape')">
% matlab/reshape</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/getnumdigestersplits')">
% biogas_scripts/getNumDigesterSplits</a>
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
%
% and is called by:
%
% <html>
% <a href="nmpc_prepare_files.html">
% biogas_control/NMPC_prepare_files</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="startnmpc.html">
% biogas_control/startNMPC</a>
% </html>
% ,
% <html>
% <a href="nmpc_load_fermenterflow.html">
% biogas_control/NMPC_load_FermenterFlow</a>
% </html>
% ,
% <html>
% <a href="nmpc_save_ctrl_strgy_fermenterflow.html">
% biogas_control/NMPC_save_ctrl_strgy_FermenterFlow</a>
% </html>
%
%% TODOs
% # improve documentation a little
% # check appearance of documentation
%
%% <<AuthorTag_ALSB/>>


