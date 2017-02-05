%% Syntax
%       NMPC_check_plant_network_bounds(plant_network_min,
%       plant_network_max, plant_network_min_limit,
%       plant_network_max_limit, plant, plant_network)
%
%% Description
% |NMPC_check_plant_network_bounds(plant_network_min, plant_network_max,
% plant_network_min_limit, plant_network_max_limit, plant, plant_network)|
% checks whether any element of |plant_network_min/max| is below (above) the
% corresponding value of |plant_network_min/max_limit| and throws a warning in
% that case. 
%
%% <<plant_network_min/>>
%% <<plant_network_max/>>
%%
% @param |plant_network_min_limit| :
% <matlab:doc('define_lb_ub_optim') |plant_network_min|>,
%
%%
% @param |plant_network_max_limit| :
% <matlab:doc('define_lb_ub_optim') |plant_network_max|>
%
%% <<plant/>>
%% <<plant_network/>>
%% Example
% 
%

[substrate, plant, ~, plant_network, ~, ~, ...
 plant_network_min, plant_network_max]= ...
 load_biogas_mat_files('gummersbach');

%%

plant_network_min_limit= plant_network_min;
plant_network_max_limit= plant_network_max;

%%
% this call is ok

NMPC_check_plant_network_bounds(plant_network_min, plant_network_max, ...
  plant_network_min_limit, plant_network_max_limit, plant, plant_network);

%%

plant_network_max_limit(2)= 15;
plant_network_min_limit(2)= 25;

%%
% this call throws two warnings

NMPC_check_plant_network_bounds(plant_network_min, plant_network_max, ...
  plant_network_min_limit, plant_network_max_limit, plant, plant_network);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/getnumdigestersplits')">
% biogas_scripts/getNumDigesterSplits</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('warning')">
% matlab/warning</a>
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
% <a href="nmpc_ctrl_strgy_fermenterflow_minmax.html">
% biogas_control/NMPC_ctrl_strgy_FermenterFlow_MinMax</a>
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
% ,
% <html>
% <a href="nmpc_ctrl_strgy_substrateflow_minmax.html">
% biogas_control/NMPC_ctrl_strgy_SubstrateFlow_MinMax</a>
% </html>
% ,
% <html>
% <a href="nmpc_save_ctrl_strgy_substrateflow.html">
% biogas_control/NMPC_save_ctrl_strgy_SubstrateFlow</a>
% </html>
%
%% TODOs
% # improve documentation a little
% # check appearance of documentation
%
%% <<AuthorTag_ALSB/>>


