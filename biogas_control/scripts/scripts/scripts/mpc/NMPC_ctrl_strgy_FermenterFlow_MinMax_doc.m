%% Syntax
%       [plant_network_min, plant_network_max]=
%       NMPC_ctrl_strgy_FermenterFlow_MinMax(plant, plant_network,
%       plant_network_min, plant_network_max, plant_network_min_limit,
%       plant_network_max_limit) 
%       [...]= NMPC_ctrl_strgy_FermenterFlow_MinMax(plant, plant_network,
%       plant_network_min, plant_network_max, plant_network_min_limit,
%       plant_network_max_limit, change_type)
%       [...]= NMPC_ctrl_strgy_FermenterFlow_MinMax(plant, plant_network,
%       plant_network_min, plant_network_max, plant_network_min_limit,
%       plant_network_max_limit, change_type, change_fermenter)
%       [...]= NMPC_ctrl_strgy_FermenterFlow_MinMax(plant, plant_network,
%       plant_network_min, plant_network_max, plant_network_min_limit,
%       plant_network_max_limit, change_type, change_fermenter, trg)
%       [...]= NMPC_ctrl_strgy_FermenterFlow_MinMax(plant, plant_network,
%       plant_network_min, plant_network_max, plant_network_min_limit,
%       plant_network_max_limit, change_type, change_fermenter, trg,
%       trg_opt) 
%       [...]= NMPC_ctrl_strgy_FermenterFlow_MinMax(plant, plant_network,
%       plant_network_min, plant_network_max, plant_network_min_limit,
%       plant_network_max_limit, change_type, change_fermenter, trg,
%       trg_opt, fitness_trg)
%       [...]= NMPC_ctrl_strgy_FermenterFlow_MinMax(plant, plant_network,
%       plant_network_min, plant_network_max, plant_network_min_limit,
%       plant_network_max_limit, change_type, change_fermenter, trg,
%       trg_opt, fitness_trg, wrng_msg)
%
%% Description
% |[...]= NMPC_ctrl_strgy_FermenterFlow_MinMax(...)| creates
% |plant_network_min| and |plant_network_max| out ouf current
% |plant_network_min| and |plant_network_max|, which are identical when
% calling the function, this is due to the function
% <nmpc_save_ctrl_strgy_fermenterflow.html
% NMPC_save_ctrl_strgy_FermenterFlow>. Further checks if bounds hold and
% sets the |change_fermenter| value in the workspace of the caller
% depending on the |trg| option.  
%
%% <<plant/>>
%% <<plant_network/>>
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
%%
% @param |change_type| : char. Default: 'percentual'. 
%
% * 'percentual' : sets the stepwise control increment/decrement as a 
% percentage [100 %] value
% * 'absolute' : sets the stepwise control increment/decrement as an 
% absolute [m³/day] value
%
%%
% @param |change_fermenter| : either a scalar, then change is equal for
% all digester connections or a matrix of size |plant_network|. The unit of
% the values is defined by the parameter |change_type|. Default: 0.05,
% meaning 5 %. 
%
%%
% @param |trg|   : If empty the standard value is 'off'.
%
% * 'on'  : activates the trigger for the fitness value; if the fitness 
% does not change in the last five NMPC iterations the step size |change| 
% is increased/decreased, see |trg_opt|.  
% * 'off' : trigger option deactivated. 
%
%%
% @param |trg_opt|   : double, if empty the standard value is |-Inf|. This
% parameter has only effect if the parameter |trg| is 'on'. 
% 
% * Inf      : increases the step size |change_fermenter| value by 10[%]
% over time. 
% * -Inf     : decreases the step size |change_fermenter| value by 10[%]
% over time. 
% * some constant : the new step size |change_fermenter| is changed by the
% given factor. If it is 1.1, this means an increase by 10 %, if it is 0.9
% it means a decrease by 10 %. The number must be positive. 
%
%%
% @param |fitness_trg| : row vector of fitness values gotten over the last
% iterations. At the moment does only work with SO optimization methods.
% Default: []. 
%
%%
% @param |wrng_msg| : Show a warning if min < min_limit or max > max_limit.
% If empty the standard value is 'on'. 
%
% * 'on'  : show warning
% * 'off' : do not show warning
%
%% Example
% 
%

[substrate, plant, ~, plant_network, ~, ~, ...
 plant_network_min, plant_network_max]= ...
 load_biogas_mat_files('gummersbach');

%%

plant_network_min_limit= plant_network_min;
plant_network_max_limit= plant_network_max;

equilibrium= load_file('equilibrium_gummersbach');

control_horizon= 3; % days

%%

[plant_network_min, plant_network_max]= ...
  NMPC_save_ctrl_strgy_FermenterFlow(substrate, plant, ...
    plant_network, plant_network_min, plant_network_max, equilibrium, ...
    control_horizon, 3);

%%

disp(plant_network_min)
disp(plant_network_max)

%%

[ plant_network_min, plant_network_max ]= ...
  NMPC_ctrl_strgy_FermenterFlow_MinMax( ...
    plant, plant_network, plant_network_min, plant_network_max, ...
    plant_network_min_limit, plant_network_max_limit);

%%

disp(plant_network_min)
disp(plant_network_max)

%%

plant_network_max_limit(2)= 50;

%%
% call with change_fermenter being a matrix

[ plant_network_min, plant_network_max ]= ...
  NMPC_ctrl_strgy_FermenterFlow_MinMax( ...
    plant, plant_network, plant_network_min, plant_network_max, ...
    plant_network_min_limit, plant_network_max_limit, [], [0 0 0; 0.5 0 0]);

%%

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
% <a href="matlab:doc('validatestring')">
% matlab/validatestring</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
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
% <a href="matlab:doc('biogas_control/nmpc_check_plant_network_bounds')">
% biogas_control/NMPC_check_plant_network_bounds</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="startnmpcatequilibrium.html">
% startNMPCatEquilibrium</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="startnmpc.html">
% startNMPC</a>
% </html>
% ,
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
% # improve documentation a little
% # solve TODOs inside function
% # check appearance of documentation
% # does not work with MO optimization methods yet
%
%% <<AuthorTag_ALSB/>>


