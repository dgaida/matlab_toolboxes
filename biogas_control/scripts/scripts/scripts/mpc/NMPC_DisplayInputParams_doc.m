%% Syntax
%       escKey= NMPC_DisplayInputParams(plant_id, method, change_type,
%       change, N, timespan, control_horizon, id_read, id_write, parallel,
%       nWorker, pop_size, nGenerations, OutputFcn, useInitPop, broken_sim,
%       delete_db, database_name, trg, trg_opt, sim_time, gui_opt, email,
%       delta, use_real_plant, use_history, soft_feed) 
%
%% Description
% |NMPC_DisplayInputParams(...)| displays Input parameters of
% |startNMPC| function in the command window. Furthermore asks for
% keyboard, if |gui_opt| is 'off'.
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
%% <<nGenerations/>>
%%
% @param |OutputFcn| : <matlab:doc('function_handle') function_handle> to a
% function which is called after 
% each generation of some optimization methods, at the momment only |GA|
% uses this method. The standard value is empty. This option is part of the 
% <matlab:doc('findoptimalequilibrium')
% findOptimalEquilibrium> function implemented in the |startNMPC|.
%
%%
% @param |useInitPop|  : This option is part of the <matlab:doc('findoptimalequilibrium')
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
% the standard value is 'false'. TODO: at the moment this option cannot be
% used anymore!
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
% is increased/decreased based on |trg_opt|.  
% * 'off' : trigger option deactivated. 
%
%%
% @param |trg_opt|   : double, if empty the standard value is |-Inf|. This
% parameter has only effect if |trg| is 'on'.
% 
% * Inf      : increases the step size |change| value by 10[%] over time.
% * -Inf     : decreases the step size |change| value by 10[%] over time.
% * some constant : the new step size |change| is a constant value.
%
%%
% @param |sim_time| : estimated simulation time measured in minutes
%
%%
% @param |gui_opt|   : If empty the standard value is 'off'.
%
% * 'on'  : Directly starts the NMPC optimization without pausing it in the
% beginning.
% * 'off' : pauses the NMPC optimization and waits for an input key to 
% start; this allows to check the option parameters for the |startNMPC|
% before the optimization starts. If 'ESC' is pressed, the method cancels.
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
% * 1 : control a real biogas plant (TODO: not yet implemented!)
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
% @return |escKey| : 'off' on default. If 'ESC' key is pressed, then user
% does not want to start NMPC, then it is 'on'.
%
%% Example
%
%

cd( fullfile( getBiogasLibPath(), 'examples/nmpc/Gummersbach' ) );

%%

varargin= cell(17,1);
varargin{17}= 'off';
varargin{21}= 'on';

[ plant_id, method, change_type, change, N, timespan, control_horizon, ...
  id_read, id_write, parallel, nWorker, pop_size, nGenerations, OutputFcn, ...
  useInitPop, broken_sim, delete_db, database_name, trg, trg_opt, gui_opt, ...
  email, delta, use_real_plant, use_history, soft_feed ]= ...
    NMPC_InitializationInputParams( varargin{1:end} );

%%   

sim_time = ( 125 + pop_size*nGenerations*30*N )/60; % minutes

NMPC_DisplayInputParams( plant_id, method, change_type, change, N, ...
                         timespan, control_horizon, id_read, ...
                         id_write, parallel, nWorker, pop_size, ...
                         nGenerations, OutputFcn, useInitPop, ...
                         broken_sim, delete_db, database_name, trg, ...
                         trg_opt, sim_time, gui_opt, email, delta, use_real_plant, ...
                         use_history, soft_feed );

                           
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/getkey')">
% script_collection/getkey</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="nmpc_prepare_files.html">
% NMPC_prepare_files</a>
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
%
%% TODOs
% # check all params
% # improve documentation a little
%
%% <<AuthorTag_ALSB/>>


