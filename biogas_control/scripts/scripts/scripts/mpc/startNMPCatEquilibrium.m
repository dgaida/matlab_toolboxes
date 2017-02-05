%% startNMPCatEquilibrium
% Start NMPC at given equilibrium
%
function varargout= startNMPCatEquilibrium(equilibriumInit, plant_id, method, change_type, N, ...
  timespan, control_horizon, id_write, parallel, nWorker, pop_size, ...
  nGenerations, OutputFcn, useInitPop, trg, trg_opt, email, delta, ...
  ictrl_start, tStart, substrate_network_min_limit, substrate_network_max_limit, ...
  plant_network_min_limit, plant_network_max_limit, ...
  substrate_network_min, substrate_network_max, ...
  plant_network_min, plant_network_max, change_substrate, change_fermenter, fcn, ...
  use_history, soft_feed, substrate_stock, nObjectives)
%% Release: 1.0

%%

error( nargchk(35, 35, nargin, 'struct') );
error( nargoutchk(0, 7, nargout, 'struct') );

%%
% check arguments

is_equilibrium(equilibriumInit, '1st');
is_plant_id(plant_id, '2nd');
checkArgument(method, 'method', 'char', '3rd');
validatestring(change_type, {'percentual', 'absolute'}, ...
               mfilename, 'change_type', 4);
isN(N, 'N', 5);
%% TODO
% das ist der Prädiktionshorizont, isN sollte genutzt werden
checkArgument(timespan, 'timespan', 'double', 6);

isN(control_horizon, 'control_horizon', 7);
isN0(id_write, 'id_write', 8);
validatestring(parallel, {'none', 'multicore', 'cluster'}, mfilename, 'parallel', 9);
isN(nWorker, 'nWorker', 10);
isN(pop_size, 'pop_size', 11);
isN(nGenerations, 'nGenerations', 12);
checkArgument(OutputFcn, 'OutputFcn', 'function_handle', 13, 'on');
is0or1(useInitPop, 'useInitPop', 14);
validatestring(trg, {'on', 'off'}, mfilename, 'trg', 15);
checkArgument(trg_opt, 'trg_opt', 'double', 16);
checkArgument(email, 'email', 'char', 17, 'on');
isR(delta, 'delta', 18, '+');

checkArgument(change_substrate, 'change_substrate', 'double', 29);
checkArgument(change_fermenter, 'change_fermenter', 'double', 30);
checkArgument(fcn, 'fcn', 'char', 31);
is0or1(use_history, 'use_history', 32);
is0or1(soft_feed, 'soft_feed', 33);
isRn(substrate_stock, 'substrate_stock', 34);
isN(nObjectives, 'nObjectives', 35);

%%
%% TODO: only works with SO fitness
fitness_trg= zeros(1,N);    %Target fitness

[substrate, plant, substrate_network, plant_network]= ...
    load_biogas_mat_files(plant_id);

fitness_params= load_biogas_mat_files(plant_id, [], 'fitness_params');

%%

is_substrate_network(substrate_network_min_limit, 21, substrate, plant);
is_substrate_network(substrate_network_max_limit, 22, substrate, plant);
is_plant_network(plant_network_min_limit, 23, plant);
is_plant_network(plant_network_max_limit, 24, plant);
is_substrate_network(substrate_network_min, 25, substrate, plant);
is_substrate_network(substrate_network_max, 26, substrate, plant);
is_plant_network(plant_network_min, 27, plant);
is_plant_network(plant_network_max, 28, plant);

%%
% dies enthält die ganze nonlinearMPC schleife
% nach Ende erster Iteration eine Mail mit neuer substratzufuhr schicken
% die idee der schleife ist, dass in der schleife nur mit idealem modell
% gearbeitet wird, was zeigt wie sich das system in zukunft reagieren wird.
% ohne zu wisen ob sich das reale system wirklich so verhält, ist eine
% prädiktion
%
% man teilt quasi das optimierungsproblem, welches man über den control
% horizon in mehreren schritten lösen sollte, in mehrere
% optimierungsprobleme auf, wobei in jedem optimierungsproblem nur ein
% schritt substratzufuhr genutzt wird. man könnte natürlich auch ein
% optimierungsproblem mit mehreren substratveränderungen über dem control
% horizon lösen. 
% diese vereinfachung, d.h. trennung in kleine optimierungsprobleme, ist
% nur eine approximation, aber beschleunigt das verfahren, da nach erster
% iteration die aktuell anzuwendende substratzufuhr bekannt ist und per
% mail an anlagenbetreiber geschickt werden kann. höhere iterationen werden
% nur benötigt, damit betreiber weiß wohin der weg gehen soll, bzw. was in
% den nächsten tagen zu füttern ist
%
% am ende aller iterationen noch mal eine mail senden, mit plot der
% zukunft. 


%%

%% Earlier an option of using a linearised model for MPC was considered. 
%  However it is not used now. So ignore the first initialization. We only
%  need plant ID.

plant_id_ctrl= 'sunderhooklinearized';  
plant_id_ctrl= plant_id;

%%
% Open Matlab Pool
[parallel]= setParallelConfiguration('open', parallel, nWorker);

%%
% Creating a copy of the necessary files.This is just a small code for
% verification purpose and this is not used in the NMPC process.
%createcopy(plant_id);    

%%
% String Variables Initialization : substrate_network_min/max_plant_id
% string, i.e. 'substrate_network_min_sunderhook'
substrate_network_min_plant= [ 'substrate_network_min_', char(plant_id_ctrl) ]; 
substrate_network_max_plant= [ 'substrate_network_max_', char(plant_id_ctrl) ];

% String Variables Initialization : plant_network_min/max_plant_id
% string, i.e. 'plant_network_min_sunderhook'
plant_network_min_plant= [ 'plant_network_min_', char(plant_id_ctrl) ];  
plant_network_max_plant= [ 'plant_network_max_', char(plant_id_ctrl) ];

%%
% just for initialization

substrate_network_min_1st= [];
substrate_network_max_1st= [];
plant_network_min_1st= [];
plant_network_max_1st= [];
equilibrium_1st= [];
substrate_stock_1st= [];
yhat= [];       % predicted measurements for the first step of the optimal feed

%%
  
num_steps= getNumSteps_Tc(control_horizon, delta);

%% TODO
% make a copy of both ADM params files if existent and copy them back at
% the end of the function
%% TODO
% if this is done delete copy file stuff in nmpc_tmrfcn


%%
% if we have a noisy plant then create here the probes files used for
% prediction

NMPC_create_feed_probes_files(substrate, (ictrl_start - 1) * delta, num_steps);


%%
%

dispMessage('Start NMPC at equilibrium.', mfilename);


%% 
% Main NMPC for loop 
% N: nº of Control Loops
% Prediction Time for MPC -> findOptimalEquilibrium 
% timespan*N -> ictrl
for ictrl= ictrl_start:N + ictrl_start - 1
  
  %%
  
  dispMessage(['Iteration: ', num2str(ictrl), ' of ', ...
              num2str(N + ictrl_start - 1)], mfilename);
  
  %% 
  % sets where the simulations start
  Ndelta= (ictrl - 1) * delta;
   

  %% 
  % NEW SUBSTRATE FLOW MAX/MIN,,
  % increments the ontrol strategy for the substrates and max/min new states
  % change_substrate, change_fermenter are overwritten by this function
  
  
  % Daniel-please check this
  % substrate_network_min and substrate_network_max are dependant on the
  % 'change' variable set before. This function also checks whether the 
  % limits, that is the 'lb'-substrate_network_min and 'ub'
  % -substrate_network_max were equal  and are modified 
  % in accordance with the 'change' value given. 'lb' and 'ub' are not
  % necessarily the same, since we call this after
  % NMPC_save_ctrl_strgy_SubstrateFlow.
  
  [ substrate_network_min, substrate_network_max ] = ...
      NMPC_ctrl_strgy_SubstrateFlow_MinMax( ...
          substrate, plant, substrate_network_min, substrate_network_max, ...
          substrate_network_min_limit, substrate_network_max_limit, ...
          change_type, change_substrate, trg, trg_opt, fitness_trg, 'on'); 

  %% TODO - Daniel
  
  %if exist('substrate_stock', 'var')
    % decrease substrate_stock by amount fed over delta
    
    %% 
    % das hier ist nicht die richtige stelle für substraktion, da
    % equlibriumInit ja gar nicht gefüttert wurde, weiter unten erst
    % substrahieren, s.u.
    
%     substrate_stock= substrate_stock - ...
%       get_volumeflow_outof_equilibrium(plant_id, equilibriumInit, ...
%         [], num_steps, 'const', 0) * delta;
    
    %%
    % min/max based on available substrate. 
    % if soft_feed == 1, then max is decreased incrementally, if not enough
    % substrate will be available over the prediction horizon |timespan|. 
    % if == 0, then max is set to 0 when no substrate is available
  [substrate_network_min, substrate_network_max]= ...
      change_bounds_substrate_stock(substrate_network_min, substrate_network_max, ...
      substrate_stock, timespan, control_horizon, substrate_network, soft_feed);
    
  %end
  
  %%
  % just save for plotting and analysing issues later
  
  save ( sprintf('%s_bounded_%i', substrate_network_min_plant, ictrl ), 'substrate_network_min' ); 
  % "substrate_network_max"
  save ( sprintf('%s_bounded_%i', substrate_network_max_plant, ictrl ), 'substrate_network_max' ); 

  
  %% TODO
  % rescale old paretosets of method SMS-EGO
  
  if strcmp(method, 'SMS-EGO')
  
    try
      
      LBold= load_file( char( substrate_network_min_plant ) );
      UBold= load_file( char( substrate_network_max_plant ) );
      
      rescale_paretoset_SMSEGO(LBold, UBold, ...
        substrate_network_min, substrate_network_max, 'results/SMSEGO/@(u)f');
      
    catch ME
      disp(ME.message);
    end
    
  elseif strcmp(method, 'CMAES')
    
    try
      
      LBold= load_file( char( substrate_network_min_plant ) );
      UBold= load_file( char( substrate_network_max_plant ) );
      
      rescale_population_CMAES(LBold, UBold, ...
        substrate_network_min, substrate_network_max, pwd);
      
    catch ME
      disp(ME.message);
    end
    
    %% TODO - was ist mit SMS-EMOA???????????????????
    % hat in ersten tests gefehlt. ergänzt am 22.12., expII tests für
    % SMS-EMOA soft muss ich wiederholen
  elseif strcmp(method, 'SMS-EMOA')
  
    try
      
      LBold= load_file( char( substrate_network_min_plant ) );
      UBold= load_file( char( substrate_network_max_plant ) );
      
      rescale_paretoset_SMSEMOA(LBold, UBold, ...
        substrate_network_min, substrate_network_max);
      
    catch ME
      disp(ME.message);
    end
    
  else
    warning('ps:rescale', 'If UB or LB changed then your PS is not rescaled!')
  end
  
  
  
  %% 
  % SUBSTRATE FLOW MAX/MIN
  %  Save latest iterations        
  % "substrate_network_min"  
  save ( char( substrate_network_min_plant ), 'substrate_network_min' ); 
  % "substrate_network_max"
  save ( char( substrate_network_max_plant ), 'substrate_network_max' ); 

  
  
  %% 
  % NEW FERMENTER FLOW MAX/MIN
  % Increments the limits for the fermenters max/min 

  [ plant_network_min, plant_network_max ] = ...
      NMPC_ctrl_strgy_FermenterFlow_MinMax( ...
                            plant, plant_network, ...
                            plant_network_min, plant_network_max, ...
                            plant_network_min_limit, plant_network_max_limit, ...
                            change_type, change_fermenter, ...
                            trg, trg_opt, fitness_trg, 'on');

  %% 
  % FERMENTER FLOW MAX/MIN 
  % Save latest interactions
  save ( char( plant_network_min_plant ), 'plant_network_min' ); % "plant_network_min"  
  save ( char( plant_network_max_plant ), 'plant_network_max' ); % "plant_network_max"

  
  %% 
  % NEW DIGESTER STATE
  % set digester_state_min/max to current optimal state (use equilibrium
  % structure) and save them to file

  % set digester bounds to states inside equilibriumInit
  %[digester_state_min, digester_state_max]= ...
                  setStateBoundsToEqState(equilibriumInit, plant_id);
          
  
  %% 
  % DIGESTER STATE MAX/MIN 
  % Save latest interactions i.e. 'digester_state_max_plant'  
%   save ( [ 'digester_state_min_', char(plant_id_ctrl) ] , 'digester_state_min' );   
%   save ( [ 'digester_state_max_', char(plant_id_ctrl) ] , 'digester_state_max' );

  %% 
  % NOISE
  % If noise should be added, then change the substrate structure here and save it in
  % the current folder, the new substrate structure is then loaded in the
  % findOptimalEquilibrium method.


  %% 
  % PREDICTION HORIZON
  % Substrate flow is calculated with prediction over the prediction
  % horizon and the number of steps of substrate flow change which should be
  % applied over control horizon.
  
  % Daniel have a look at this
  % Substrate flow is constant over the control horizon AND prediction
  % horizon, control horizon= 1 week, prediction horizon= 100, 200, 300
  % days?, try different
  
  %% TODO Daniel
  
  init_substrate_feed= get_init_feed_oo_equilibrium(equilibriumInit, ...
                                substrate, plant, control_horizon, delta);
  
  
  %%
  % 24 h == 1 day, sampling time in days, 5-10 days, for simulation
  % over prediction horizon, below it is set for simulation over sampling
  % time to a smaller value
  set_sensors_sampling_time(plant_id, min(delta, timespan/50));
  
  %%
  % when called the first time, allow 20 % higher population size
  % all tests in experimen1 I were not run with this option. for setpoint
  % control I thought this might be helpful (II and III)
  if ictrl == 1 && nObjectives > 1 % only for multi-objective methods
    my_nGenerations= round(nGenerations * 1.2);
  else
    my_nGenerations= nGenerations;
  end
  
  % time for SIMULATION to be added...
  [equilibrium, u, fitness]= findOptimalEquilibrium( ...
                        plant_id_ctrl, method, useInitPop, parallel, ... 
                        nWorker, pop_size, my_nGenerations, OutputFcn, ...
                        [Ndelta timespan + Ndelta], [], [], ...
                        num_steps, control_horizon, ...
                        use_history, init_substrate_feed, nObjectives);                     
                      

  %% 
  % CONTROL HORIZON

  % The latest predicted changes in substrate feed are saved into 'equilibriumInit' 
  % The 'delta' number of values in the predicted control horizon 
  % are applied to the plant.
  equilibriumInit.network_flux= equilibrium.network_flux;
  equilibriumInit.network_flux_string= equilibrium.network_flux_string;

  
  %%
  
  %if exist('substrate_stock', 'var')
    % decrease substrate_stock by amount fed over delta
    
    %% 
    % jetzt wurde equilibriumInit gefüttert und deshalb hier
    % substrate_stock verringern und speichern für nächste runde
    
    substrate_stock= substrate_stock - ...
      get_volumeflow_outof_equilibrium(plant_id, equilibriumInit, ...
        [], num_steps, 'const', 0) * delta;
    
    %%
    % to avoid negative substrate_stock
    substrate_stock= max(substrate_stock, 0);
    
    %% 
    % substrate_stock muss auch wieder in Datei gespeichert werden für
    % nächstes equilibrium, also nächstem aufruf dieser funktion
    
    %% TODO
    % das kann ich nicht einfach so machen, wenn ich hier weiter in die
    % zukunft schaue in dieser funktion, dann ist die datei bei dem
    % nächsten funktionsaufruf nicht mehr richtig. 
     
    %save(sprintf('substrate_stock_%s.mat', plant_id), 'substrate_stock');
    
  %end
  
  %% Applying the substrate flow to the plant until the next delta.
  % Do simulation over sampling interval
  
  %% TODO
  % this is new, we have two different plants, the one in the upper folder
  % is the real one to be controlled
  % but this is not called here, here the same model as used in
  % optimization is called, the model of the real plant is called somewhere
  % else, see startNMPC
  
  %cd('..');
  
  %%

  dispMessage(sprintf('Apply optimal feed to prediction model for sampling time from %.2f to %.2f.', ...
    Ndelta, Ndelta + delta), mfilename);

  %% 
  % evtl. oben bei sampling time die NKS begrenzen, auf wie viele NKS??
  % math.round müsste es geben, glaube ich
  
  samp_time= numerics.math.round_float(min(1/(24*20), delta / 20), 4);
  
  %%
  % 24 h == 1 day, sampling time in days, 0.25-0.5 days, for simulation
  % over sampling time delta, after that reset sampling time to a higher
  % value, minimum: 5 min. , done as in NMPC_TmrFcn., l. 250
  set_sensors_sampling_time(plant_id, samp_time);
    
  %% TODO
  % just for debugging
  
  copyfile(sprintf('initstate_%s.mat', plant_id), ...
    sprintf('initstate_%s_%i_before.mat', plant_id, ictrl));
  
  if exist(sprintf('adm1_param_vec_%s.mat', plant_id), 'file')
    
    copyfile(sprintf('adm1_param_vec_%s.mat', plant_id), ...
      sprintf('adm1_param_vec_%s_%i_before.mat', plant_id, ictrl));

  end
  
  %%
%   if useStateEstimator
%     [fit, equilibrium, new_sensor_data]= ...
%       NMPC_simBiogasPlantExtended(fcn, equilibriumInit, plant, substrate, ...
%                              plant_network, substrate_network, ...
%                              fitness_params, [Ndelta, delta + Ndelta], ...
%                          control_horizon, fix(control_horizon/delta), ...
%                          fix(control_horizon/delta), init_substrate_feed);
%                            
%     sensor_data= appendSensorData(sensor_data, new_sensor_data);                       
%   else
    [fit, equilibrium, plant, ~, sensors]= ...
      NMPC_simBiogasPlantExtended(fcn, equilibriumInit, plant, substrate, ...
                             plant_network, substrate_network, ...
                             fitness_params, [Ndelta, delta + Ndelta], ...
                             control_horizon, num_steps, ...
                             num_steps, use_history, init_substrate_feed);
%   end
  
  %% TODO
  % just for debugging

  save(sprintf('equilibria_internal_%i', ictrl), ...
    'equilibrium', 'equilibriumInit');
  
  copyfile(sprintf('initstate_%s.mat', plant_id), ...
    sprintf('initstate_%s_%i_after.mat', plant_id, ictrl));
  
  
  %% TODO
  % save ADM1 params as stream into a ts object and to a file
  % this is used as a test
  save_sensorsData2ts(sensors, plant, 'ts_ADM1params_model.mat', ...
                      'ts_ADM1state_model.mat');

  %%
  % save new adm params in file
  
  save_ADMparams_to_mat_file(plant);
  
  %%
  % save ADM1 param vector to file, is load again above in simBiogasPlant
  
  save_ADMparam_vec_to_file(plant);
  
  %% TODO
  % just for debugging
  
  copyfile(sprintf('adm1_param_vec_%s.mat', plant_id), ...
    sprintf('adm1_param_vec_%s_%i_after.mat', plant_id, ictrl));
  
  %%
  % get measurements only in first iteration, because this is the optimal
  % feed really applied to the plant, all following iterations are only
  % predictions
  if ictrl == ictrl_start
  
    %%
    % get 4 measurements assumed to be measurable in practice as well out of
    % sensors. same as used for state estimation. needed to compare estimated
    % y with really measured y, for offset-free NMPC
    [yhat.pH, yhat.ch4, yhat.co2, yhat.ch4p]= get4MeasurementsfromSensors(sensors, plant);

  end
  
  %% TODO
  % go back into subfolder, which must be named mpc
  
  %cd('mpc');
  
  %%

  dispMessage('Successfully applied optimal feed to prediction model for sampling time.', ...
    mfilename);

  
  %% TODO not general written
  % Compare equilibrium with equilibriumInit
  % equilibrium is the new state
  % equilibriumInit the one before the control horizon
  % If the two states are identical then the plant has not proceeded at all.
  fermenters= fieldnames(equilibrium.fermenter);
    
  if all( abs( equilibrium.fermenter.(fermenters{1}).x0 - ...
               equilibriumInit.fermenter.(fermenters{1}).x0 ) < 0.00001 )
      warning('nonlinearMPC:states', 'states are identical'); 
      sum( abs( equilibrium.fermenter.(fermenters{1}).x0 - ...
                equilibriumInit.fermenter.(fermenters{1}).x0 ) )
%   else
%       sum( abs( equilibrium.fermenter.(fermenters{1}).x0 - ...
%                 equilibriumInit.fermenter.(fermenters{1}).x0 ) )
  end

  %% 
  % Check fitness value
  % The fitness values need not be equal but should be close, because 'fitness' is
  % measured after prediction horizon and 'fit' is measured after
  % Delta. The variation can be close to 1.
  %% TODO
  % das kann man mit usehistory nicht mehr überprüfen
  % zusätzlich bei multiobjective gibt es eine fehlermeldung, da de
  % differenz kein skalar mehr ist in warning ausgabe
%   if abs(fit - fitness) > 1
%     warning('NMPC:fitness', 'abs(fit - fitness) > 1: %.2f', abs(fit - fitness));
% %   else
% %     abs(fit - fitness)
%   end

  %% 
  % New states
  % The control states are the actual states of the plant.
  
  %% 
  % never use state estimator here, but use it in startNMPC

  equilibriumInit= equilibrium;

  
  %% 
  % New Initial population
  % Save the current equilibrium of the plant as the equilibrium for further process  
  save ( ['equilibriaInitPop_', plant_id_ctrl], 'equilibriumInit' );

  
  %% 
  % Save fitness value for change control strategy : fitness_trg 
  fitness_trg( ictrl )= sum(fit);

  %% 
  % SAVE THE CONTROL STRATEGY OF SUBSTRATE FLOW
  % This function saves the current substrate flow into the
  % Volumeflow_substrateID_user.mat files and sets the substrate_min/max to
  % the current substrate flow. Also these values are loaded again the 
  % next time into the workspace
  
  %% TODO
  % volumeflow_user variablen müssen hier im workspace liegen, wenn diese
  % funktion noch mal aufgerufen wird
  
  [substrate_network_min, substrate_network_max]= ...
        NMPC_save_ctrl_strgy_SubstrateFlow( substrate, plant, ...
        substrate_network_min, substrate_network_max, equilibriumInit, ...
        control_horizon, num_steps);

  
  %% 
  % SAVE CONTROL STRATEGY OF FERMENTER FLOW
  % This function saves the current Fermenter flow into the
  % Volumeflow_source fermenter_destination fermenter_user.mat files and 
  % sets the Fermenter_min/max to the current Fermenter flow. 
  % Also these values are loaded again the next time into the workspace
  
  [ plant_network_min, plant_network_max ] = ...
            NMPC_save_ctrl_strgy_FermenterFlow( substrate, plant, ...
            plant_network, plant_network_min, plant_network_max, ...
            equilibriumInit, control_horizon, delta);

  
  %% 
  % LAST INTERATION DATA SAVING
  % used to reload and start from last point if the simulation is broken 
  if ~isempty(id_write)
    save( ['nmpc_sim_ALL_data_test_v1', sprintf('_%i', id_write)] );
  else
    save( 'nmpc_sim_ALL_data_test_v1' );
  end
    
  %%
  % save min/max if we are in the first iteration, they are returned by
  % this function below. they are used in next call of this function. min
  % and max are equal here and set to the optimal feed. 
  if ictrl == ictrl_start
    
    substrate_network_min_1st= substrate_network_min;
    substrate_network_max_1st= substrate_network_max;
    plant_network_min_1st= plant_network_min;
    plant_network_max_1st= plant_network_max;
    
    % this is the equilibrium after delta
    equilibrium_1st= equilibriumInit;
    
    substrate_stock_1st= substrate_stock;
    
    %% TODO
    % hier muss ich auch ref_biogas_1_slave.mat erstellen
    % das wird nur benötigt wenn ich eine ch4 setpoint regelung habe, sonst
    % wird hier evtl. was anderes benötigt, schadet aber auch nicht das
    % hier zu machen
    % das hier ist die prädizierte ch4 production mit dem prädiktionsmodell
    % bei der gefütterten menge an substrat. diese ch4 produktion gilt als
    % sollwert für den slave controller
    % daten in sensors kommen aus simulation über delta
    
    NMPC_create_ref_biogas_1_slave(sensors, plant);
    
    %%
    
  end
  
  %% TODO
  % send a mail with current substrate to operator
  
  
    
%% 
% END for loop NMPC
end

%% 
% Close Matlab Pool

if ~strcmp( parallel, 'none' )
  if exist('matlabpool', 'file') == 2
    matlabpool close;             
  end
end

%%

dispMessage('Do final steady state simulation with prediction model.', ...
    mfilename);

%% 
% FINAL STATE SIMULATION
% one final simulation to find the real final state after e.g. 500 days

[fit, equilibriumFinal]= ...
 NMPC_simBiogasPlantExtended(fcn, equilibriumInit, plant, substrate, ...
                             plant_network, substrate_network, ...
                             fitness_params, [Ndelta + delta 500 + Ndelta + delta], ...
                         control_horizon, num_steps, num_steps, use_history);
                     

%% 
% END Simulation time

tEnd= toc(tStart)/60; % simulation time minutes

estimatedtime_h= fix( tEnd / 60 ); % hours
estimatedtime_min= round( tEnd - estimatedtime_h * 60); % minutes

time_msg= sprintf( 'Simulation time:  %i h : %i min', ...
            estimatedtime_h, estimatedtime_min );

%% 
% NMPC_SAVE_ALL_DATAS_FUNC
% saves all new : 'volumeflow_(substrate_id)_const_(id_write)'
%                 'volumeflow_(fermenter_id)_const_(id_write)'
% saves control strategy :
%                 'volumeflow_(substrate_id)_user_(id_write)'
%                 'volumeflow_(fermenter_id)_user_(id_write)'
% saves new inistate :
%                 'inistate_(plant_id)_(id_write)'

%% TODO
% bin mir nicht ganz sicher ob das so ok ist, sollte aber, da in inten
% aufgerufener funktion zustände von equilibriumFinal in initstate
% gespeichert wird. da sich zustände von hydraulic delays nicht ändern,
% kann initstate her einfach geladen werden

initstate= load_file(sprintf('initstate_%s.mat', plant_id));

%%

NMPC_save_SimOptmimData( substrate, plant, plant_id, plant_network, ...
            plant_network_max, equilibriumFinal, initstate, id_write, ...
            num_steps, delta );

%% 
% Final simulation Data
if ~isempty(id_write)
  save( ['nmpc_sim_ALL_data_test_v2', sprintf('_%i', id_write)] );
else
  save( 'nmpc_sim_ALL_data_test_v2' );
end

%%
% DATA OUTPUT
% diese min und max variablen müssen aus ende erster iteration der for loop
% stammen, da diese beim nächsten aufruf wieder genutzt werden, welcher
% situation um delta verschoben durch simuliert. 

substrate_network_min= substrate_network_min_1st;
substrate_network_max= substrate_network_max_1st;
plant_network_min= plant_network_min_1st;
plant_network_max= plant_network_max_1st;

equilibriumInit= equilibrium_1st;

substrate_stock= substrate_stock_1st;

varargout= { equilibriumInit, substrate_network_min, substrate_network_max, ...
  plant_network_min, plant_network_max, substrate_stock, yhat };
  %u, fit, plant, substrate, plant_id }; % need more?
     

%% 
% Send email
% send the simulation results per e-mail

%% TODO
% this mail could also contain some plots, do plots first, save as png and
% add png to attFiles

if ~strcmp(email, 'off')

  subject= 'nmpc test results';
  msg1= ['Simulation results of startNMPCatEquilibrium are ready' 10 ...
         sprintf('Test number: %i', id_write) 10 ... 
         time_msg 10 ...
         sprintf('fitness value: %1.7f', fit) ];

  attFile_name= sprintf('nmpc_test%i', id_write);
  attFile_path= pwd;
  attFiles= {'*.m', '*.mat', '*.csv', '*.mdb', '*.xls'};

  % send the simulation results per e-mail
  send_email_wrnmsg( email, subject, msg1, attFile_name, attFiles, attFile_path );

end

%%
%
%diary off    



%%


