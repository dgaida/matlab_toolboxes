%% Preliminaries
% # You need a Simulink simulation model of a biogas plant created with
% this toolbox with the *.mat files used for simulation. See the
% documentation of this toolbox.
% # Insert the fitness block in the simulation model outside the plant and
% write the name of the fitness function into the parameters field of the
% fitness block. 
% # The model used for preiction must exist in a subfolder, called 'mpc',
% the controlled model must be in the upperlevel folder. This function must
% be called out of the 'mpc' folder. 
% # more to be added. TODO. 
% # After you have created the folder structure and its content, make a
% copy of them as a backup and always start the NMPC from a copy of this
% backup. 
%
%% Syntax
%       varargout= startNMPC()
%       [...]= startNMPC(plant_id)
%       [...]= startNMPC(plant_id, method)
%       [...]= startNMPC(plant_id, method, change_type, change, N,
%       timespan)
%       [...]= startNMPC(plant_id, method, change_type, change, N,
%       timespan, control_horizon, id_read, id_write, parallel, nWorker,
%       pop_size, nGenerations, OutputFcn, useInitPop) 
%       [...]= startNMPC(plant_id, method, change_type, change, N,
%       timespan, control_horizon, id_read, id_write, parallel, nWorker,
%       pop_size, nGenerations, OutputFcn, useInitPop, broken_sim)
%       [...]= startNMPC(plant_id, method, change_type, change, N, 
%       timespan, control_horizon, id_read, id_write, parallel, nWorker,
%       pop_size, nGenerations, OutputFcn, useInitPop, broken_sim,
%       delete_db, database_name)
%       [...]= startNMPC(plant_id, method, change_type, change, N, 
%       timespan, control_horizon, id_read, id_write, parallel, nWorker,
%       pop_size, nGenerations, OutputFcn, useInitPop, broken_sim,
%       delete_db, database_name, trg, trg_opt)
%       [...]= startNMPC(plant_id, method, change_type, change, N, 
%       timespan, control_horizon, id_read, id_write, parallel, nWorker,
%       pop_size, nGenerations, OutputFcn, useInitPop, broken_sim,
%       delete_db, database_name, trg, trg_opt, gui_opt)
%       [...]= startNMPC(plant_id, method, change_type, change, N, 
%       timespan, control_horizon, id_read, id_write, parallel, nWorker,
%       pop_size, nGenerations, OutputFcn, useInitPop, broken_sim,
%       delete_db, database_name, trg, trg_opt, gui_opt, email)
%       [...]= startNMPC(plant_id, method, change_type, change, N, 
%       timespan, control_horizon, id_read, id_write, parallel, nWorker,
%       pop_size, nGenerations, OutputFcn, useInitPop, broken_sim,
%       delete_db, database_name, trg, trg_opt, gui_opt, email, delta)
%       [...]= startNMPC(plant_id, method, change_type, change, N, 
%       timespan, control_horizon, id_read, id_write, parallel, nWorker,
%       pop_size, nGenerations, OutputFcn, useInitPop, broken_sim,
%       delete_db, database_name, trg, trg_opt, gui_opt, email, delta,
%       use_real_plant) 
%       [...]= startNMPC(plant_id, method, change_type, change, N, 
%       timespan, control_horizon, id_read, id_write, parallel, nWorker,
%       pop_size, nGenerations, OutputFcn, useInitPop, broken_sim,
%       delete_db, database_name, trg, trg_opt, gui_opt, email, delta,
%       use_real_plant, use_history) 
%       [...]= startNMPC(plant_id, method, change_type, change, N, 
%       timespan, control_horizon, id_read, id_write, parallel, nWorker,
%       pop_size, nGenerations, OutputFcn, useInitPop, broken_sim,
%       delete_db, database_name, trg, trg_opt, gui_opt, email, delta,
%       use_real_plant, use_history, soft_feed) 
%       [...]= startNMPC(plant_id, method, change_type, change, N, 
%       timespan, control_horizon, id_read, id_write, parallel, nWorker,
%       pop_size, nGenerations, OutputFcn, useInitPop, broken_sim,
%       delete_db, database_name, trg, trg_opt, gui_opt, email, delta,
%       use_real_plant, use_history, soft_feed, experiment_name) 
%
%       [equilibrium, u, fit, plant, substrate, plant_id] = startNMPC(...)
%
%% Description
% |varargout= startNMPC(plant_id, method, change_type, change, N, 
% timespan, control_horizon, id_read, id_write, parallel, nWorker, pop_size,
% nGenerations, OutputFcn, useInitPop, broken_sim, delete_db, database_name, 
% trg, trg_opt, gui_opt, email)| finds the optimal operating point using a
% step-wise constant control starting in the current equilibrium. The
% Nonlinear Model Predictive control is implemented in a discretized model
% to control the plants inputs (substrate flow, flow between fermenters)
% and therefore maximize/minimize a fitness defined by a fitness function 
% like
% <matlab:doc('fitness_wolf_adapted')
% |fitness_wolf_adapted|>.

% ------------------------------ Delete ----------------------------------
% Goals:
%
% # Find an optimal operating point using a step-wise constant control
% starting in the current equilibrium. The control input is bounded around
% the current plant input (substrate flow, flow between fermenters) and the
% aim of the control is to maximize/minimize a fitness defined by a fitness
% function like
% <matlab:doc('fitness_wolf_adapted')
% |fitness_wolf_adapted|>. You have to implement a fitness function
% yourself, use an existing one as a starting point, use
% <matlab:doc('fitness_costs') 
% |fitness_costs|>. At first the control input may be constant over the
% control horizon, 1 week, later it should maybe also step wise variable
% inside the control horizon, maybe a change once a day. Use 100, 200, 300,
% days for the prediction horizon. If you use a short prediction horizon,
% 100 days (not yet in equilibrium), then pay attention on the biogas
% production, a biogas production which rises fast may fall down rapidly
% when achieving the equilibrium. Bad increase left, increasing steps are
% growing. Good increase right, increasing steps are decaying.
%
% <<biogas_increase.png>>
% 
% # Achieve a given steady state starting in the actual state using the
% same approach/function. The only difference is, that you have to define a
% new fitness function which now measures the distance between the current
% state and input vector and the final state and input vector.
% # Additionally to the above one: If the steady state originally was found
% as a step response from the current state, then this is maybe a useful
% information which can be used in the fitness function to get faster to
% the step-wise control to achieve the steady state.
% 
% Optional (if there is time left):
%
% # Add noise to the model and control using MPC around the optimal
% equilibrium. Noise could be a change in substrate parameters (cod, nh4,
% density, ...), therefore change here substrate structure and save it in
% the current folder. The task of the control is still to minimize the
% fitness of, e.g.
% <matlab:doc('fitness_cost')  
% |fitness_costs|>, by changing the substrate feed a little bit. Use a
% small control horizon, e.g. 1 day. 
%
% ------------------------------ Delete ----------------------------------
%% <<plant_id/>>
%
% If empty the default value is 'gummersbach'.
%
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
% |startNMPC| loads the input *.mat files such as 
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
%
% If empty the standard value is 10.
%
%% <<nGenerations/>>
%
% If empty the standard value is 10.
%
%%
% @param |OutputFcn| : <matlab:doc('function_handle') function_handle> to a
% function which is called after 
% each generation of some optimization methods, at the momment only |GA|
% uses this method. The standard value is empty. This option is part of the 
% <matlab:doc('findoptimalequilibrium')
% findOptimalEquilibrium> function implemented in the |startNMPC|.
%
%%
% @param |useInitPop|  : This option is part of the
% <matlab:doc('findoptimalequilibrium') 
% findOptimalEquilibrium> 
% function implemented in the |startNMPC|.
%
% * 1, if, then the initial population is loaded out of the
% file |equilibriaInitPop__plant_id.mat|, else set to 0 or ignore this
% param (set to [] for ignoring, if you want to use the following params).
% The standard value is 0.
%
%%
% @param |broken_sim|   : if the NMPC simulation breaks for any reason the
% siulation can be retarded from the its last iteration point. If empty
% the standard value is 'false'. TODO: this option will not work anymore.
% |broken_sim| is set to 'false' in this function. 
%
% * 'true'  : restart the NMPC optimization from its last intaration point.
% The previous simulation data is reloaded from the 
% nmpc_sim_ALL_data_test_v1.mat or nmpc_sim_ALL_data_test_v1_id_write.mat
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
% start; this allows to check the option parameters for the |startNMPC|
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
% @param |soft_feed| : 0 or 1
%
% * 0 : the amount of substrate in stock is NOT considered in the
% prediction. Therefore, a change of feed might be very abrupt. 
% * 1 : the amount of substrate in stock is considered in the prediction.
% This allows to change the substrate feed softly if one substrate is
% depleted. 
%
%%
% @param |experiment_name| : char with the name of the experiment, this is
% also the name of the zip file created to send via mail. Default:
% |sprintf('nmpc_test%i', id_write)| 
%
%% Example
%
% |startNMPC('sunderhook')|
%
% |{equilibrium, u, fit, plant, substrate, plant_id}= 
% startNMPC('sunderhook', 'GA')|
%
% |nmpc_test = startNMPC('sunderhook', 'CMAES')|
% 
% |nmpc_test= startNMPC('sunderhook', 'CMAES', 'percentual', 0.025, 40,
% 50, 7)|
% 
% |nmpc_test= startNMPC('sunderhook', 'CMAES', 'percentual', 0.025, 40, 
% 50, 7, [], 1)|
% 
% |nmpc_test= startNMPC('sunderhook', 'CMAES', 'percentual', 0.025, 40, 
% 50, 7, [], 1, 'multicore', 4)|
% 
% |nmpc_test= startNMPC('sunderhook', 'CMAES', 'percentual', 0.025, 40,
% 50, 7, [], 1, 'multicore', 4, 8, 4)|
% 
% |nmpc_test= startNMPC('sunderhook', 'CMAES', 'percentual', 0.025, 40,
% 50, 7, [], 1, 'multicore', 4, 8, 4, [], 1)|
% 
% |nmpc_test= startNMPC('sunderhook', 'CMAES', 'percentual', 0.025, 40, 
% 50, 7, [], 1, 'multicore', 4, 8, 4, [], 1, 'false')|
% 
% |nmpc_test= startNMPC('sunderhook', 'CMAES', 'percentual', 0.025, 40,
% 50, 7, [], 1, 'multicore', 4, 8, 4, [], 1, 'false', 'on', 
% 'equilibria_sunderhook')|
% 
% |nmpc_test= startNMPC('sunderhook', 'CMAES', 'percentual', 0.025, 40,
% 50, 7, [], 1, 'multicore', 4, 8, 4, [], 1, 'false', 'on',
% 'equilibria_sunderhook', 'on', -Inf)|
% 
% |nmpc_test= startNMPC('sunderhook', 'CMAES', 'percentual', 0.025, 40,
% 50, 7, [], 1, 'multicore', 4, 8, 4, [], 1, 'false', 'on', 
% 'equilibria_sunderhook', 'on', -Inf, 'off')|
% 
% |nmpc_test= startNMPC('sunderhook', 'CMAES', 'percentual', 0.025, 40,
% 50, 7, [], 1, 'multicore', 4, 8, 4, [], 1, 'false', 'on',
% 'equilibria_sunderhook', 'on', -Inf, 'off')|
% 
% |nmpc_test= startNMPC('sunderhook', 'CMAES', 'percentual', 0.025, 40,
% 50, 7, [], 1, 'multicore', 4, 8, 4, [], 1, 'false', 'on', 
% 'equilibria_sunderhook', 'on', -Inf, 'off', 'user@example.com')|
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="nmpc_initializationinputparams.html">
% NMPC_InitializationInputParams</a>
% </html>
% ,
% <html>
% <a href="nmpc_prepare_files.html">
% NMPC_prepare_files</a>
% </html>
% ,
% <html>
% <a href="getequilibriumestimateofbiogasplant.html">
% getEquilibriumEstimateOfBiogasPlant</a>
% </html>
% ,
% <html>
% <a href="nmpc_getequilibriumfromfiles.html">
% NMPC_getEquilibriumFromFiles</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('timer')">
% matlab/timer</a>
% </html>
% ,
% <html>
% <a href="nmpc_tmrfcn.html">
% NMPC_TmrFcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/send_email_wrnmsg')">
% script_collection/send_email_wrnmsg</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/dispmessage')">
% script_collection/dispMessage</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_gui/gui_nmpc')">
% biogas_gui/gui_nmpc</a>
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
%
%% TODOs
% # MPC mit kriging als prädiktor umsetzen
% # mpc mit wechselnden substratgrenzen umsetzen, im grunde muss
% algorithmus vor optimierung immer die neuen grenzen abfragen und auch
% andere RB's
% # make a backup of volumeflow files in MATLAB version 2010 and save at
% the end of the function. Because they are overwritten by the nonlinearmpc
% script.
% # variable substrate_lager einführen, welche in m³ misst, wieviel
% Substrat noch auf Lager ist, Spaltenvektor. substrate_network_max in NMPC
% muss über den control_horizon dieser Variable genügen:
% substrate_network_max [m³/d] * control_horizon [d] <= substrate_lager [m³]
% # add use_real_plant as parameter
% # in C# eine klasse implementierten: NMPCparams.cs oder ähnliches, welches
% nmpc parameter speichert in einem objekt und xml datei. 
% bsp.: sampling time, pred. horizon, control horizon
% # use_real_plant= 1 muss komplett überarbeitet bzw. fertig gestellt
% werden 
% # variable substrate parameter funktioniert noch nicht, überarbeiten
% # was ist eigentlich mit dem parameter use_history, wo kann ich den
% setzen?
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


