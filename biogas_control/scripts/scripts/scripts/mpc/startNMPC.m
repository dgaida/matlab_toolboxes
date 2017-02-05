%% startNMPC
% Non-Linear MPC is used to control Biogas plants using stochastic optimization
% methods
%
function varargout= startNMPC(varargin)
%% Release: 1.0

%%
% wir sind hier im mpc unterordner!!!

%%

error( nargchk(0, 29, nargin, 'struct') );
%% TODO
% number of outputs not yet clear
error( nargoutchk(0, 5, nargout, 'struct') );

%% 
% INITIALIZATION
% read out varargin, delete database on demand and check all parameters

[ plant_id, method, change_type, change, N, timespan, control_horizon, ...
  id_read, id_write, parallel, nWorker, pop_size, nGenerations, OutputFcn, ...
  useInitPop, broken_sim, delete_db, database_name, trg, trg_opt, gui_opt, ...
  email, delta, use_real_plant, use_history, soft_feed ] = ...
                         NMPC_InitializationInputParams( varargin{1:min(26,numel(varargin))} );

%%
%

if nargin >= 27 && ~isempty(varargin{27}) % will be the name of the created zip file
  experiment_name= varargin{27};
  checkArgument(experiment_name, 'experiment_name', 'char', 27);
else
  experiment_name= sprintf('nmpc_test%i', id_write);
end

if nargin >= 28 && ~isempty(varargin{28}) % simulation at the beginning
  tend_ss= varargin{28};
  isR(tend_ss, 'tend_ss', 28);
else
  tend_ss= 750;     % end time of steady state simulation in the beginning
end

if nargin >= 29 && ~isempty(varargin{29}) % 
  nObjectives= varargin{29};
  isN(nObjectives, 'nObjectives', 29);
else
  nObjectives= 2;     % number of objectives in optimization problem
end

%%
% broken simulation is not working as it once was developed. the reason is,
% that we now have two loops. and the iterator of the first loop is not
% included in the broken_sim stuff. 

broken_sim= 'false';

%%
% change nObjectives value in fitness_params.mat/xml and save files again

set_nObjectives_in_fitness_params(plant_id, method, [], nObjectives);

%% 
% if 1, then use a real plant. if 0, then use a simulation model instead

%% TODO
% delete this - first implement this option
if use_real_plant
  error('NMPC scripts not yet implemented for use_real_plant == 1!!!');
end

%% 
% Using State Estimator
% 0 - Do not apply; 1 - Apply State Estimator 
% Currently it is not applied
% 
%% TODO
% diese Abfrage ist ein bisschen doof
% diese datei existiert im überordner nicht im UO mpc
if exist(fullfile(pwd, '..', 'dataset_flag_vec.mat'), 'file')
  %useStateEstimator= 1;
  % the variable useStateEstimator is redundant, because estimator_method
  % contains all the information needed, if it is not empty, then state
  % estimator is applied
  estimator_method= 'RF';%'LDA';
else
  %useStateEstimator= 0;
  
  estimator_method= [];
end


%% TODO
% in C# eine klasse implementierten: NMPCparams.cs oder ähnliches, welches
% nmpc parameter speichert in einem objekt und xml datei. 
% bsp.: sampling time, pred. horizon, control horizon


%% 
% name of simulation model

fcn= ['plant_', plant_id];


%%
% 1. Erzeuge Start Zustand (NMPC_getEquilibriumFromFiles) oder bekomme
% diesen von biogasanlage (getEquilibriumEstimateOfBiogasPlant,
% getFeedAndRecycleEstimateOfBiogasPlant) 

dispMessage('Trying to get initial state estimate of biogas plant.', mfilename);

%%

if use_real_plant

  %% TODO
  %
  
  equilibriumInit= getEquilibriumEstimateOfBiogasPlant(plant_id, estimator_method);
  
  %% TODO
  % setze volumeflow_const files zu aktuellem feed und sludge, wird für
  % NMPC_prepare_files unten benötigt, da darauf die aktuellen minmax files
  % drauf gesetzt werden
  
  %% TODO
  % the ref file has to be created here as well
  
  % NMPC_create_ref_biogas_1_slave(sensors, plant, 1);

  
else
  
  %%
  % get equilibrium from initstate user file and volumeflow const files
  % do a simulation to get a steady state, where the NMPC can start from,
  % just for comparison with the final simulation after the NMPC was
  % applied
  equilibriumInit= NMPC_getEquilibriumFromFiles(plant_id, fcn, control_horizon, delta, tend_ss);

end

%%                         
% Save the state of equilibrium obtained after 750 days of Steady state simulation. 
% This becomes the initial state for the NMPC simulation.

save ( ['equilibriaInitPop0_', plant_id], 'equilibriumInit' );

%%

dispMessage('Successfully acquired initial state estimate of biogas plant.', mfilename);


%%
% 1b prepare nmpc
% limits are set to given limits in files
% min and max are equal and equal to const files values
% change values are set

[ictrl_start, substrate_network_min_limit, substrate_network_max_limit, ...
  plant_network_min_limit, plant_network_max_limit, ...
  substrate_network_min, substrate_network_max, ...
  plant_network_min, plant_network_max, change_substrate, change_fermenter]= ...
  NMPC_prepare_files(plant_id, method, change_type, change, N, timespan, control_horizon, ...
    id_read, id_write, parallel, nWorker, pop_size, nGenerations, OutputFcn, ...
    useInitPop, broken_sim, delete_db, database_name, trg, trg_opt, gui_opt, ...
    email, delta, use_real_plant, use_history, soft_feed);
  
%%
% TODO - Daniel
% ich denke es wäre besser wenn er nur im aktuellen pfad sucht und nicht
% überall
%% 
% substrate_stock sollte ein cell array werden, so dass substrate_stock
% über iterationen aufgezeichnet wird.

if exist(sprintf('substrate_stock_%s.mat', plant_id), 'file')
  substrate_stock= load_file(sprintf('substrate_stock_%s', plant_id), [], plant_id);
  
  if iscell(substrate_stock)
    substrate_stock_iter= substrate_stock;
  else
    %% TODO
    % für simulationen könnte ich hier auch an höheren Iterationen eine
    % substrate_stock vorgeben um anzudeuten, dass substrate wieder aufgefüllt
    % ist
    % einrichten, dass substrate_stock in einer neuen iteration auch wieder
    % ansteigen bzw. sich auffüllen kann. dazu cell array erstellen und
    % dieses an ein, zwei stellen füllen, auf jeden fall am anfang

    substrate_stock_iter{1}= substrate_stock;

  end
else
  % all values are infinity
  substrate_stock_iter{1}= createDefaultSubstrateStock(plant_id);
end

%%
% substrate_network_min/max sollte ich über iterationen speichern, genau
% so wie auch substrate_stock. speichern als
% substrate_network_min/max_iter als cell array. 

substrate_network_min_iter{1}= substrate_network_min;
substrate_network_max_iter{1}= substrate_network_max;

%%
% init yerr, the error between measured and predicted measurement values.
% used for offset-free NMPC

plant= load_biogas_mat_files(plant_id, [], 'plant');
n_fermenter= plant.getNumDigesterD();

yerr.pH= zeros(1, n_fermenter);
yerr.ch4= zeros(1, n_fermenter);
yerr.co2= zeros(1, n_fermenter);
yerr.ch4p= zeros(1, n_fermenter);


%%
% save variables in mat file for NMPC_TmrFcn

save('NMPC_TmrFcn_vars.mat', 'equilibriumInit', 'ictrl_start', ...
     'substrate_network_min_iter', 'substrate_network_max_iter', ...
     'plant_network_min', 'plant_network_max', 'substrate_stock_iter', 'yerr');

%%
% ab hier eine for schleife starten, bzw. andere iterationsmöglichkeiten

if use_real_plant

  %% 
  % ich habe große bedenken, dass die parameter welche an die tmr funktion
  % übergeben werden nicht aktualisiert werden, von wem auch, deshalb
  % werden alle veränderlichen Parameter in eine mat Datei geschrieben, hier und am ende
  % der tmr fcn. diese mat datei wird von tmrfcn am anfang eingelesen. 
  
  %%
  % timer updating after every 24 hours
  mytmr= timer('TimerFcn', {@NMPC_TmrFcn, plant_id, method, change_type, N, ...
          timespan, control_horizon, id_write, parallel, nWorker, pop_size, ...
          nGenerations, OutputFcn, useInitPop, trg, trg_opt, email, delta, ...
          substrate_network_min_limit, substrate_network_max_limit, ...
          plant_network_min_limit, plant_network_max_limit, ...
          change_substrate, change_fermenter, estimator_method, fcn, ...
          use_history, soft_feed, nObjectives}, ...
               'BusyMode', 'Queue', ...
               'ExecutionMode', 'FixedRate', 'Period', 60*60*24);    % 24 h

  %% TODO
  % timer should always start in the evening, therefore determine current
  % time and start timer at given hour or just at 20.00 or something like
  % that
  %% TODO
  % there is a function startat: startat(obj,[Y,M,D,H,MI,S]), see my
  % function tonight, startat(obj, tonight()) should be possible
  %% TODO
  % maybe add while loop with doevents?
    
  startat(mytmr, tonight());

else

  %% TODO - Daniel

  % substrates= create_substrate_cell();

  %%
  
  for ictrl_outer= 1:N    % identisch mit ictrl_start
    
    %%
    %
    
    %% TODO - Daniel
    % simuliert, dass sich Substratparameter ändern
    %% TODO
    % wenn ich die xml datei in config path speicher, wirkt sich das auf
    % alle simulationsmodelle aus. für unterschiedung modell zur
    % optimierung und simulationsmodell mit regler, muss substrate.xml
    % lokal gespeichert werden. weiß nicht warum das sowieso so gemacht
    % wird. Grund war, dass load_biogas_mat_files falsch war, nur in config
    % path geschaut hat
    %% TODO
    % hier sollte in lokalem Pfad gespeichert werden, sollte jetzt klappen,
    % diese datei wird nur im unterordner mpc gespeichert
    % in darüber liegenden ordner wir mit substrateparams_..._user.mat
    % files gearbeitet. 
    if exist('substrates', 'var') && (ictrl_outer <= numel(substrates))    % aufsplitten der Simulation
      substrates{ictrl_outer}.saveAsXML( fullfile(getConfigPath(), plant_id, ...
        sprintf('substrate_%s.xml', plant_id)) );
    elseif exist('substrates', 'var') && (ictrl_outer > numel(substrates))
      disp('Keeping the latest substrate.xml file!');
    end

    
    %%
    % rufe Funktion mit N= 1 auf
    % 2nd parameter event = [], must be to recognize if using real plant or
    % not
    %% 
    % ich rufe diese funktion mit email auf 'off' auf, damit man nicht so
    % viele e-mails bekommt, ist im simulationsfall ein bisschen nervig
    %% TODO
    % irgendwo hier ictrl_outer übergeben
    NMPC_TmrFcn([], [], plant_id, method, change_type, 1, ...
        timespan, control_horizon, id_write, parallel, nWorker, pop_size, ...
        nGenerations, OutputFcn, useInitPop, trg, trg_opt, 'off', delta, ...
        substrate_network_min_limit, substrate_network_max_limit, ...
        plant_network_min_limit, plant_network_max_limit, ...
        change_substrate, change_fermenter, estimator_method, fcn, ...
        use_history, soft_feed, nObjectives);
    
  end
  
end


%% 
% Restore Backup data - wird eigentlich nicht mehr benötigt, da es kein
% danach mehr gibt, aber ok

substrate_network_min= substrate_network_min_limit; 
substrate_network_max= substrate_network_max_limit; 
plant_network_min=     plant_network_min_limit; 
plant_network_max=     plant_network_max_limit; 

% save files
save ( ['substrate_network_min_', plant_id], 'substrate_network_min' ); 
save ( ['substrate_network_max_', plant_id], 'substrate_network_max' );
save ( ['plant_network_min_',     plant_id], 'plant_network_min' );
save ( ['plant_network_max_',     plant_id], 'plant_network_max' );

save data_files_bkp substrate_network_min substrate_network_max ...
                    plant_network_min plant_network_max


%%
%

dispMessage('NMPC finished!', mfilename);

%% 
% send one final message as mail with the complete folders as mail

if ~strcmp(email, 'off')
  
  cd('..')    % go into parent folder

  subject= 'nmpc test results';
  msg1= ['Final simulation results of startNMPC are ready' 10 ...
         sprintf('Test number: %i', id_write)];

  attFile_name= experiment_name;
  attFile_path= pwd;
  % put all into zip file, also subfolder, funktioniert so
  % wirft nur eine warnung, dass erstellte zip nicht rekursiv wieder
  % gezippt werden kann, aber logisch
  attFiles= {'*.*', 'mpc/*.*'};%{'*.m', '*.mat', '*.csv', '*.mdb', '*.xls'};

  % send the simulation results per e-mail
  send_email_wrnmsg( email, subject, msg1, attFile_name, attFiles, attFile_path );

end

%%  TODO
% maybe shutdown computer

% shutdown(300);

%%

varargout{1}= [];

%%


