%% Syntax
%       [plant_id, method, change_type, change, N, timespan,
%       control_horizon, id_read, id_write, parallel, nWorker, pop_size,
%       nGenerations, OutputFcn, useInitPop, broken_sim, delete_db, 
%       database_name, trg, trg_opt, gui_opt, email, delta, use_real_plant,
%       use_history, soft_feed]= NMPC_InitializationInputParams()
%       [...]= NMPC_InitializationInputParams(...)
%       [plant_id, method, change_type, change, N, timespan,
%       control_horizon, id_read, id_write, parallel, nWorker, pop_size,
%       nGenerations, OutputFcn, useInitPop, broken_sim, delete_db, 
%       database_name, trg, trg_opt, gui_opt, email, delta, use_real_plant,
%       use_history, soft_feed]= 
%       NMPC_InitializationInputParams(plant_id, method, change_type,
%       change, N, timespan, control_horizon, id_read, id_write, parallel,
%       nWorker, pop_size, nGenerations, OutputFcn, useInitPop, broken_sim,
%       delete_db, database_name, trg, trg_opt, gui_opt, email, delta,
%       use_real_plant, use_history, soft_feed) 
%
%% Description
% |[...]= NMPC_InitializationInputParams(...)| initializes the input
% parameters |varargin| for the <matlab:doc('biogas_control/startnmpc')
% startNMPC> function. If the parameter 
% |delete_db| is 'on', then the |equilibria_plant_id_...mat| is deleted as
% well as the content of the |equilibria_plant_id_...mdb| is deleted in
% this function. All arguments are optional. 
%
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
% absolute [m³/day] and if empty the standard value is 1 m³/day. |change|
% may be a scalar or a vector. If it is a vector, then each element
% specifies the change value for a substrate and the recirculations. 
%
%%
% @param |N|   : double scalar defining the number of iterations for the 
% Nonlinear Model Predictive Control loop. If empty the standard value is 
% 15 iterations. 
%
%% <<pred_horizon/>>
%%
% If empty the standard value is 250 [days]. This option is part of the
% <matlab:doc('findoptimalequilibrium') findOptimalEquilibrium> function 
% implemented in the |startNMPC|.  
%
%% <<control_horizon/>>
%%
% If empty the standard value is 14 [days]. This option is part of the
% <matlab:doc('simbiogasplantextended') simBiogasPlantExtended> function 
% implemented in the |startNMPC|.
%
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
%%
% If |parallel == 'none'|, the parameter |nWorker| is set to one. 
%
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
% @param |useInitPop|  : This option is part of the <matlab:doc('findoptimalequilibrium')
% findOptimalEquilibrium> 
% function implemented in the |startNMPC|.
%
% * 0 : The standard value is 0.
% * 1 : if, then the initial population is loaded out of the
% file |equilibriaInitPop__plant_id.mat|, else set to 0 or ignore this
% param (set to [] for ignoring, if you want to use the following params).
%
%%
% @param |broken_sim|   : if the NMPC simulation breaks for any reason the
% siulation can be retarded from the its last iteration point. If empty
% the standard value is 'false'. TODO: does not work at the moment!
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
% start; this allows to check the option parameters for the |nonlinearMPC|
% before the optimization starts.
%
%%
% @param |email|   : char specifing the e-mail which to be sent the NMPC
% simulation results, e.g. 'user@example.com' 
%
%% <<delta/>>
%%
% As default it is set to |control_horizon|. 
%
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
%% Example
% 

cd( fullfile( getBiogasLibPath(), 'examples/nmpc/Gummersbach' ) );

%%

varargin= cell(17,1);
varargin{17}= 'on';

[ plant_id, method, change_type, change, N, timespan, control_horizon, ...
      id_read, id_write, parallel, nWorker, pop_size, nGenerations, ...
      OutputFcn, useInitPop, broken_sim, delete_db, database_name, trg, ...
      trg_opt, gui_opt, email, delta, use_real_plant, use_history, soft_feed ]= ...
      NMPC_InitializationInputParams( varargin{1:end} )

    
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
% <a href="matlab:doc('database')">
% matlab/database</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is_onoff')">
% script_collection/is_onoff</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn0')">
% script_collection/isN0</a>
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
% <a href="matlab:doc('dataset')">
% matlab/dataset</a>
% </html>
%
%% TODOs
% # check documentation
% # check appearance of documentation
% # check script for deleting database (maybe create a script out of that)
%
%% <<AuthorTag_ALSB/>>


