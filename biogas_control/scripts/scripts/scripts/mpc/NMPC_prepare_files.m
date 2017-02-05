%% NMPC_prepare_files
% Creates variables for NMPC and is called before the NMPC loop
%
function [ictrl_start, substrate_network_min_limit, substrate_network_max_limit, ...
  plant_network_min_limit, plant_network_max_limit, ...
  substrate_network_min, substrate_network_max, ...
  plant_network_min, plant_network_max, change_substrate, change_fermenter]= ...
  NMPC_prepare_files(plant_id, method, change_type, change, N, timespan, control_horizon, ...
    id_read, id_write, parallel, nWorker, pop_size, nGenerations, OutputFcn, ...
    useInitPop, broken_sim, delete_db, database_name, trg, trg_opt, gui_opt, ...
    email, delta, use_real_plant, use_history, soft_feed)
%% Release: 1.3

%%

error( nargchk(26, 26, nargin, 'struct') );
error( nargoutchk(11, 11, nargout, 'struct') );

%%

ictrl=       0;             %Iteration control
ictrl_start= 1;

%%
% init return values

substrate_network_min_limit= [];
substrate_network_max_limit= [];
plant_network_min_limit= [];
plant_network_max_limit= [];
substrate_network_min= [];
substrate_network_max= [];
plant_network_min= [];
plant_network_max= [];
change_substrate= [];
change_fermenter= [];

%% 
% Estimating Simulation time [hrs] 
% 125 secs is an aproximation for ( 750 + 500 ) days for Steady State simulation.
% The second part is used for estimation of simulation time using the NMPC.
% That is the value '30' is an aproximation of 30 secs omputation time for
% predhorz days simulation. + 30 sec. for simulation over delta. 
sim_time= ( 125 + pop_size*nGenerations*30*N + 1*30 )/60; % minutes

%% 
% Broken Simulation -> if true load previus run data and continue... 

if strcmp(broken_sim, 'true') 
        
  %%
  % das wird nie aufgerufen, da broken_sim nicht mehr funktioniert seit der
  % Skriptumstellung
  
  %%
  
  warning('broken_sim:true', 'broken_sim == true may not work!');
  
  %%
  
  if ~isempty(id_write)
    load( ['nmpc_sim_ALL_data_test_v1', sprintf('_%i', id_write)] );
  else
    load( 'nmpc_sim_ALL_data_test_v1' );
  end

  % broken_sim 
  broken_sim= 'true';
  
  %% TODO Daniel
  
  N= 15;
  
  %%
  
  % N -> Number of days for NMPC
  if ictrl > 0, 
    %N= abs( N - ictrl - 1 ); 
    %ictrl= 0;
    %% TODO
    % warum? sollte so stimmen. die geladene datei wird am ende der
    % iteration gespeichert, dort wird ictrl noch nicht hochgezählt,
    % deshalb hier + 1
    ictrl_start= ictrl + 1; %% eigentlich nicht + 1, da noch nicht zu ende gelaufen ist
  end

  %% 
  % DISPLAY OF OPTIONS
  escKey= NMPC_DisplayInputParams( plant_id, method, change_type, change, N, ...
               timespan, control_horizon, id_read, id_write, ...
               parallel, nWorker, pop_size, nGenerations, OutputFcn, ...
               useInitPop, broken_sim, delete_db, database_name, trg, trg_opt, ...
               sim_time, gui_opt, email, delta, use_real_plant, ...
               use_history, soft_feed );

  % Is set in NMPC_DisplayInputParams
  if strcmp(escKey, 'on'), return; end % stops simulation if esc Key pressed

  %%
  % Save/Overwrite Broken Plants Model
  try
    save_system( [ 'plant_',plant_id ], [], 'OverwriteIfChangedOnDisk', true );
  catch ME
    disp(ME.message)
  end
  
else % no broken simulation
       
  %% 
  % DISPLAY OF OPTIONS
  escKey= NMPC_DisplayInputParams( plant_id, method, change_type, change, N, ...
               timespan, control_horizon, id_read, id_write, ...
               parallel, nWorker, pop_size, nGenerations, OutputFcn, ...
               useInitPop, broken_sim, delete_db, database_name, trg, trg_opt, ...
               sim_time, gui_opt, email, delta, use_real_plant, ...
               use_history, soft_feed );

  %%
  % Is set in NMPC_DisplayInputParams
  if strcmp(escKey, 'on'), return; end % stops simulation if esc Key pressed

  %% 
  % NOISE
  % A parameter defining Noise if enabled and also the type of noise which should be added
  % Noise may include changing parameters in the substrate strcuture, like cod,
  % nh4, density etc ...
  % this is not done here! done elsewhere

  %% 
  % LOAD PLANT's DATA
    
  [substrate, plant, substrate_network, plant_network,substrate_network_min,...
   substrate_network_max, plant_network_min, plant_network_max]= ...
    load_biogas_mat_files(plant_id);

  %% 
  % Load Initial States from Backup Variables if it exist
  % that's not nice!!!
  if ~(exist( 'data_files_bkp.mat', 'file' ) == 2)

%       plant_network_max = [ 0, Inf, 0; 40, 0, Inf ];
%       plant_network_min = [ 0, 0, 0; 40, 0, 0 ];
%       substrate_network_max = [40, 0; 30, 0; 0.01, 0; 3, 0; 0.01, 0; 0.01, 0; 5, 0];
%       substrate_network_min = [20, 0; 10, 0; 0, 0; 1, 0; 0, 0; 0, 0; 0, 0];

    % if not existent, then assume, that bounds loaded are ok
    % so they are saved here for backup
    
    save data_files_bkp substrate_network_min substrate_network_max ...
                          plant_network_min plant_network_max
  end

  %%
  % Load Backup Variables
  load data_files_bkp 

  %% TODO
  % why are they saved here, they are overwritten later anyway
  
  % save files
  save ( ['substrate_network_min_', plant_id], 'substrate_network_min' );
  % this will join the first string and the second variable by converting
  % the variable value to string
  save ( ['substrate_network_max_', plant_id], 'substrate_network_max' );
  save ( ['plant_network_min_',     plant_id], 'plant_network_min' );
  save ( ['plant_network_max_',     plant_id], 'plant_network_max' );

  %% 
  % 'UB' and 'LB' for Substrate and Plant network are reassigned to another
  % variable.
  % subs(substrate)_nw(network)_min/max_limit is the new 'LB' and 'UB'
  % This is done here because the back up file should have LB and UB and
  % not 'lb' and 'ub'. Since the back up file is saved we assign another
  % variable name and use substrate_network_min/max for 'lb' and 'ub'
  
  %% LB and UB for Substrate and Plant network are set here
  % LB and UB are Lower and Upper Bound. The capital letters indicate they
  % are the maximum overall limits. When 'lb' and 'ub' are used they mean
  % limits or bounds for optimization.
  
  substrate_network_min_limit= substrate_network_min; 
  substrate_network_max_limit= substrate_network_max;

  plant_network_min_limit= plant_network_min;
  plant_network_max_limit= plant_network_max;

  
  %% 
  % SUBSTRATE FLOW
  % Set substrate_network bounds(lb and ub) to current (constant) volumeflow.
  % This also creates 'volumeflow_substrateID_const' variables for each
  % substrate in this workspace.
  %% TODO
  % volumeflow const files are assigned to this workspace! why??? is not
  % done anymore, so OK
  %% TODO
  % muss gemacht werden, da es min und max const auf aktuelle
  % substratzufuhr setzt
  %% TODO
  % volumeflow const files müssen vorher existieren, wichtig für reale
  % anlage, dass vorher getFeedAndRecycleEstimateOfBiogasPlant aufgereufen
  % werden muss und aktuelle feeds in const dateien geschrieben werden
  
  [substrate_network_min, substrate_network_max]= ...
      NMPC_load_SubstrateFlow( substrate, substrate_network, plant, id_read );

  %% 
  % FERMENTER FLOW
  % Set plant_network bounds to current fermenter flux
  % This also creates 'volumeflow_substrateID_const' variables for each
  % Fermenter Flux in this workspace.
  %% TODO
  % volumeflow const files are assigned to this workspace! why??? is not
  % done anymore, so OK
  %% TODO
  % muss gemacht werden, da es min und max const auf aktuelle
  % rezi setzt
  
  [plant_network_min, plant_network_max]= ...
      NMPC_load_FermenterFlow( plant, plant_network, plant_network_min, ...
                               plant_network_max, id_read );

  %% 
  % CHANGE 
  % This function returns the change value for substrate and fermenter flux, this is
  % independent of whether the variable is optimized or not. Therefore even for a
  % constant variable the change value could be greater than 0
  
  [ change_substrate, change_fermenter ] = ...
          NMPC_ctrl_strgy_change( change, substrate, plant, ...
                                  plant_network, plant_network_max );
    
%% 
% END broken simulation option
end

%%


