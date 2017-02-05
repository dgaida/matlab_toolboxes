%% Syntax
%       [ictrl_start, substrate_network_min_limit,
%       substrate_network_max_limit, plant_network_min_limit,
%       plant_network_max_limit, substrate_network_min,
%       substrate_network_max, plant_network_min, plant_network_max,
%       change_substrate, change_fermenter]= NMPC_prepare_files(plant_id,
%       method, change_type, change, N, timespan, control_horizon, id_read,
%       id_write, parallel, nWorker, pop_size, nGenerations, OutputFcn,
%       useInitPop, broken_sim, delete_db, database_name, trg, trg_opt,
%       gui_opt, email, delta, use_real_plant, use_history, soft_feed)
%
%% Description
% |[ictrl_start, substrate_network_min_limit, substrate_network_max_limit,
% plant_network_min_limit, plant_network_max_limit, substrate_network_min,
% substrate_network_max, plant_network_min, plant_network_max,
% change_substrate, change_fermenter]= NMPC_prepare_files(plant_id, method,
% change_type, change, N, timespan, control_horizon, id_read, id_write,
% parallel, nWorker, pop_size, nGenerations, OutputFcn, useInitPop,
% broken_sim, delete_db, database_name, trg, trg_opt, gui_opt, email,
% delta, use_real_plant, use_history, soft_feed)| first displays all parameters, calling
% <nmpc_displayinputparams.html NMPC_DisplayInputParams>. Then, it sets the
% min/max to the volumeflow_..._const values. At the end the change values
% are set. FOr this script the const mat files for the substrates and the
% sludge must exist. 
%
%% <<plant_id/>>
%% <<opt_method/>>
%%
% @param |change_type|   :
%
% * 'percentual' : sets the stepwise control increment/decrement as a 
% percentage [100 %] value
% * 'absolute' : sets the stepwise control increment/decrement as an 
% absolute [m³/day] value
%
%%
% @param |change|   : defines the step size of the NMPC. If |change_type| is 
% 'percentual' the value is taken as a percentage [100 %] and if empty the standard 
% value is 5 % (0.05). If |change_type| is 'absolute' the value is taken as an 
% absolute [m³/day] and if empty the standard value is 1 m³/day. 
%
%%
% @param |N|   : double scalar defining the number of iterations for the 
% Nonlinear Model Predictive Control loop. If empty the standard value is 
% 15 iterations. 
%
%% <<pred_horizon/>>
%% <<control_horizon/>>
%%
% @param |id_read|   : select the id *.mat files for the plants inputs 
% (substrate flow, flow between fermenters); e.g. if id_read == 1 the 
% |nonlinearMPC| loads the input *.mat files such as 
% volumeflow_bullmanure_const_1.mat for the optimization. If empty the
% standard value is [].
%
%%
% @param |id_write|   : select the id in which the *.mat files results will
% be saved for the NMPC optimization; e.g. volumeflow_bullmanure_user_1.mat. 
% If empty the standard value is 1.
%
%% <<parallel/>>
%% <<nWorker/>>
%% <<pop_size/>>
%% <<nGenerations/>>
%%
% @param |OutputFcn| : <matlab:doc('function_handle') function_handle> to a
% function which is called after 
% each generation of some optimization methods, at the momment only |GA|
% uses this method. The standard value is empty. This option is part of the 
% <matlab:doc('findoptimalequilibrium')
% findOptimalEquilibrium> function implemented in the |nonlinearMPC|.
%
%%
% @param |useInitPop|  : This option is part of the <matlab:doc('findoptimalequilibrium')
% findOptimalEquilibrium> 
% function implemented in the |nonlinearMPC|.
%
% * 1, if, then the initial population is loaded out of the
% file |equilibriaInitPop__plant_id.mat|, else set to 0 or ignore this
% param (set to [] for ignoring, if you want to use the following params).
% The standard value is 0.
%
%%
% @param |broken_sim|   : if the NMPC simulation breaks for any reason the
% siulation can be retarded from the its last iteration point. If empty
% the standard value is 'false'.
%
% * 'true'  : restart the NMPC optimization from its last intaration point.
% The previous simulation data is reloaded from the 
% nmpc_sim_ALL_data_test_v1.mat or nmpc_sim_ALL_data_test_v1_id_write.mat.
% TODO: this does not work at the moment!
% * 'false' : the NMPC optimization starts from the predefined initial 
% states and configured parameters.
%
%%
% @param |delete_db|   : If empty the standard value is 'on'.
%
% * 'on'  : Deletes all rows in the ODBC data base regarding the previous
% simulation data, e.g. equilibria_gummersbach.mdb. Also deltes the mat file
% equilibria_gummersbach.mat.
% * 'off' : continues to save the simulation data in the following rows of 
% the ODBC data base, e.g. equilibria_gummersbach.mdb. Same holds for the
% mat file, in which a dataset is saved. 
%
%%
% @param |database_name|   : char defining the ODBC data base for the NMPC
% simulation data saving/deleting. If empty the standard value is 
% 'equilibria_' + |plant_id|.
%
%%
% @param |trg|   : If empty the standard value is 'off'.
%
% * 'on'  : activates the trigger for the fitness value; if the fitness 
% does not change in the last five NMPC interation the step size |change| 
% is increased/decreased |trg_opt|.  
% * 'off' : triger option deactivated. 
%
%%
% @param |trg_opt|   : double, if empty the standard value is |-Inf|.
% 
% * Inf      : increases the step size |change| value by 10[%] over time.
% * -Inf     : decreases the step size |change| value by 10[%] over time.
% * some constant : the new step size |change| is a constant value.
%
%%
% @param |gui_opt|   : If empty the standard value is 'off'.
%
% * 'on'  : Directly starts the NMPC optimization without pausing it in the
% beginning.
% * 'off' : pauses the NMPC optimization and waits for an input key to 
% start; this allows to check the option parameters for the |nonlinearMPC|
% before the optimization starts.
%
%%
% @param |email|   : char specifing the e-mail which to be sent the NMPC
% simulation results, e.g. 'user@example.com' 
%
%% <<delta/>>
%%
% @param |use_real_plant| : if 1, then a real biogas plant is controlled,
% if 0, then a simulation model is controlled. Default: 0. 
%
% * 0 : control a simulation model
% * 1 : control a real biogas plant
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
% @param |soft_feed| : 
%
%%
% @return |ictrl_start| : 1. 
%
%%
% @return |substrate_network_min_limit| : is set to values load from
% 'substrate_network_min_...mat' or 'data_files_bkp.mat', if existent. 
%
%%
% @return |substrate_network_max_limit| : is set to values load from
% 'substrate_network_max_...mat' or 'data_files_bkp.mat', if existent. 
%
%%
% @return |plant_network_min_limit| : is set to values load from
% 'plant_network_min_...mat' or 'data_files_bkp.mat', if existent. 
%
%%
% @return |plant_network_max_limit| : is set to values load from
% 'plant_network_max_...mat' or 'data_files_bkp.mat', if existent. 
%
%%
% @return |substrate_network_min| : set to current substrate
% volumeflow_const files. min and max are the same. 
%
%%
% @return |substrate_network_max| : set to current substrate
% volumeflow_const files. min and max are the same. 
%
%%
% @return |plant_network_min| : set to current sludge volumeflow_const
% files. min and max are the same. 
%
%%
% @return |plant_network_max| : set to current sludge volumeflow_const
% files. min and max are the same. 
%
%%
% @return |change_substrate| : values returned by
% <matlab:doc('biogas_control/nmpc_ctrl_strgy_change')
% biogas_control/NMPC_ctrl_strgy_change> 
%
%%
% @return |change_fermenter| : values returned by
% <matlab:doc('biogas_control/nmpc_ctrl_strgy_change')
% biogas_control/NMPC_ctrl_strgy_change> 
%
%% Example
%
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_mat_files')">
% biogas_scripts/load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="nmpc_displayinputparams.html">
% NMPC_DisplayInputParams</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_load_substrateflow')">
% biogas_control/NMPC_load_SubstrateFlow</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_load_fermenterflow')">
% biogas_control/NMPC_load_FermenterFlow</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_ctrl_strgy_change')">
% biogas_control/NMPC_ctrl_strgy_change</a>
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
% <a href="matlab:doc('fitness_costs')">
% fitness_costs</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('findoptimalequilibrium')">
% findOptimalEquilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_tmrfcn')">
% biogas_control/NMPC_TmrFcn</a>
% </html>
%
%% TODOs
% # improve script
% # improve documentation
% # see TODOs
%
%% <<AuthorTag_ALSB_AKV/>>
%% References
%
% <html>
% <ol>
% <li> 
% Findeisen, R. and Allgöwer, F.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\02 An Introduction to Nonlinear Model Predictive Control.pdf'', 
% biogas_control.getHelpPath())'))">
% An Introduction to Nonlinear Model Predictive Control</a>, 
% 21st Benelux Meeting on Systems and Control, vol. 11, 2002
% </li>
% <li> 
% Gaida, D.; Sousa Brito, André Luis; Wolf, Christian; Bäck, Thomas;
% Bongards, Michael and McLoone, Seán: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\162.pdf'', 
% biogas_control.getHelpPath())'))">
% Optimal Control of Biogas Plants using Nonlinear Model Predictive Control</a>, 
% ISSC 2011, Trinity College Dublin, 2011. 
% </li>
% <li> 
% Gaida, D.; Wolf, Christian; Bäck, Thomas and Bongards, Michael: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\ThA3-01.pdf'', 
% biogas_control.getHelpPath())'))">
% Nonlinear Model Predictive Substrate Feed Control of Biogas Plants</a>, 
% 20th Mediterranean Conference on Control & Automation (MED), Barcelona,
% 2012. 
% </li>
% <li> 
% Sousa Brito, André Luis: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\Thesis_Brito_final_online.pdf'', 
% biogas_control.getHelpPath())'))">
% Optimization of full-scale Biogas Plants using Nonlinear Model Predictive Control</a>, 
% Master Thesis, Cologne University of Applied Sciences, 2011.
% </li>
% <li> 
% Venkatesan, Ashwin Kumar: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\NMPC Final Report.pdf'', 
% biogas_control.getHelpPath())'))">
% Optimization of Substrate Feed in a Biogas Plant using Non-linear Model Predictive Control</a>, 
% Master Thesis, Cologne University of Applied Sciences, 2012.
% </li>
% </ol>
% </html>
%


