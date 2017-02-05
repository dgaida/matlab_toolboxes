%% Syntax
%       varargout= startNMPCatEquilibrium(equilibriumInit, plant_id,
%       method, change_type, N, timespan, control_horizon, id_write,
%       parallel, nWorker, pop_size, nGenerations, OutputFcn, useInitPop,
%       trg, trg_opt, email, delta, ictrl_start, tStart,
%       substrate_network_min_limit, substrate_network_max_limit,
%       plant_network_min_limit, plant_network_max_limit,
%       substrate_network_min, substrate_network_max, plant_network_min,
%       plant_network_max, change_substrate, change_fermenter, fcn,
%       use_history, soft_feed) 
%
%% Description
% |varargout= startNMPCatEquilibrium(equilibriumInit, plant_id, method,
% change_type, N, timespan, control_horizon, id_write, parallel, nWorker,
% pop_size, nGenerations, OutputFcn, useInitPop, trg, trg_opt, email,
% delta, ictrl_start, tStart, substrate_network_min_limit,
% substrate_network_max_limit, plant_network_min_limit,
% plant_network_max_limit, substrate_network_min, substrate_network_max,
% plant_network_min, plant_network_max, change_substrate, change_fermenter,
% fcn)| starts NMPC at given equilibrium |equilibriumInit|. It runs a for
% loop predicting |N| steps into the future, starting at |ictrl_start|. In
% the for loop the optimization over the prediction horizon |timespan| and
% the application of the first step of the optimal feed on the model for
% the control sampling time |delta|. At the end of the first iteration an
% email is send to |email| (should be the address of the operator) with the
% today to be fed substrate. The further predictions just show how the
% ideal plant model would behave. After the for loop has finished a further
% mail is send to the operator, visualizing the prediction in some plots. 
%
%%
% @param |equilibriumInit| : 
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
% @param |N|   : double scalar defining the number of iterations for the 
% Nonlinear Model Predictive Control loop.
%
%% <<pred_horizon/>>
%% <<control_horizon/>>
%%
% @param |id_write|   : select the id in which the *.mat files results will
% be saved for the NMPC optimization; e.g. volumeflow_bullmanure_user_1.mat. 
%
%% <<parallel/>>
%% <<nWorker/>>
%% <<pop_size/>>
%% <<nGenerations/>>
%%
% @param |OutputFcn| : <matlab:doc('function_handle') function_handle> to a
% function which is called after 
% each generation of some optimization methods, at the momment only |GA|
% uses this method. 
%
%%
% @param |useInitPop|  : This option is part of the <matlab:doc('findoptimalequilibrium')
% findOptimalEquilibrium> 
% function implemented in the |nonlinearMPC|.
%
% * 1, if, then the initial population is loaded out of the
% file |equilibriaInitPop__plant_id.mat|, else set to 0 or ignore this
% param (set to [] for ignoring, if you want to use the following params).
%
%%
% @param |trg|   : If empty the standard value is 'off'.
%
% * 'on'  : activates the trigger for the fitness value; if the fitness 
% does not change in the last five NMPC interation the step size |change| 
% is increased/decreased |trg_opt|.  
% * 'off' : trigger option deactivated. 
%
%%
% @param |trg_opt|   : double, if empty the standard value is |-Inf|.
% 
% * Inf      : increases the step size |change| value by 10[%] over time.
% * -Inf     : decreases the step size |change| value by 10[%] over time.
% * some constant : the new step size |change| is a constant value.
%
%%
% @param |email|   : char specifing the e-mail which to be sent the NMPC
% simulation results, e.g. 'user@example.com' 
%
%% <<delta/>>
%%
% @param |substrate_network_min_limit| : lower limit for substrate flows 
%
%%
% @param |substrate_network_max_limit| : upper limit for substrate flows 
%
%%
% @param |plant_network_min_limit| : lower limit for fermenter flows 
%
%%
% @param |plant_network_max_limit| : upper limit for fermenter flows 
%
%% <<substrate_network_min/>>
%% <<substrate_network_max/>>
%% <<plant_network_min/>>
%% <<plant_network_max/>>
%%
% @param |change_substrate| : 
%
%%
% @param |change_fermenter| : 
%
%%
% @param |fcn| : ['plant_', plant_id]
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
% @param |soft_feed| : 0 or 1
%
% * 0 : the amount of substrate in stock is NOT considered in the
% prediction. Therefore, a change of feed might be very abrupt. 
% * 1 : the amount of substrate in stock is considered in the prediction.
% This allows to change the substrate feed softly if one substrate is
% depleted. 
%
%%
% @return |equilibriumInit| : equilibrium structure at the end of the 1st
% iteration of the for loop. This is the equilibrium after the control
% sampling time |delta| and can be used to call this function the next
% time. 
%
%%
% @return |substrate_network_min| : min substrate feed at the end of the 1st
% iteration of the for loop. This is the boundary after the control
% sampling time |delta| and can be used to call this function the next
% time. It is equal to optimal feed applied to the real plant or the real
% simulation model and equal to max. 
%
%%
% @return |substrate_network_max| : max substrate feed at the end of the 1st
% iteration of the for loop. This is the boundary after the control
% sampling time |delta| and can be used to call this function the next
% time. It is equal to optimal feed applied to the real plant or the real
% simulation model and equal to min. 
%
%%
% @return |plant_network_min| : min recycle sludge at the end of the 1st
% iteration of the for loop. This is the boundary after the control
% sampling time |delta| and can be used to call this function the next
% time. It is equal to optimal recycles applied to the real plant or the real
% simulation model and equal to max. 
%
%%
% @return |plant_network_max| : max recycle sludge at the end of the 1st
% iteration of the for loop. This is the boundary after the control
% sampling time |delta| and can be used to call this function the next
% time. It is equal to optimal recycles applied to the real plant or the real
% simulation model and equal to min. 
%
%%
% @return |yhat| : predicted measurements for the first step of the optimal
% feed. needed for offset free NMPC. is compared with real measured values
% of the plant. 
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
% <a href="matlab:doc('optimization_tool/setparallelconfiguration')">
% optimization_tool/setParallelConfiguration</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_file')">
% biogas_scripts/load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/dispmessage')">
% script_collection/dispMessage</a>
% </html>
% ,
% <html>
% <a href="nmpc_ctrl_strgy_substrateflow_minmax.html">
% NMPC_ctrl_strgy_SubstrateFlow_MinMax</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_volumeflow_outof_equilibrium')">
% biogas_scripts/get_volumeflow_outof_equilibrium</a>
% </html>
% ,
% <html>
% <a href="nmpc_ctrl_strgy_fermenterflow_minmax.html">
% NMPC_ctrl_strgy_FermenterFlow_MinMax</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/setstateboundstoeqstate')">
% biogas_optimization/setStateBoundsToEqState</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/get_init_substrate_feed')">
% biogas_control/get_init_substrate_feed</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/findoptimalequilibrium')">
% biogas_optimization/findOptimalEquilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_simbiogasplantextended')">
% biogas_control/NMPC_simBiogasPlantExtended</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_save_ctrl_strgy_substrateflow')">
% biogas_control/NMPC_save_ctrl_strgy_SubstrateFlow</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_save_ctrl_strgy_fermenterflow')">
% biogas_control/NMPC_save_ctrl_strgy_FermenterFlow</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_save_simoptmimdata')">
% biogas_control/NMPC_save_SimOptmimData</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/send_email_wrnmsg')">
% script_collection/send_email_wrnmsg</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_control/nmpc_tmrfcn')">
% biogas_control/NMPC_TmrFcn</a>
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
% <a href="matlab:doc('biogas_gui/gui_nmpc')">
% biogas_gui/gui_nmpc</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/startnmpc')">
% biogas_control/startNMPC</a>
% </html>
%
%% TODOs
% # improve script
% # improve documentation
% # check whether substrate_stock is working
% # see TODOs inside file
% # send mail at end of for loop
% # die methode ruft zu viele methoden auf, welche eine höhere release nr.
% verhindern
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


