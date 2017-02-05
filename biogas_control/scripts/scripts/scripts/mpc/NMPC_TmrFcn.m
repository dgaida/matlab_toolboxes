%% NMPC_TmrFcn
% Calls startNMPCatEquilibrium, is called by a timer
%
function NMPC_TmrFcn(src, event, plant_id, method, change_type, N, ...
  timespan, control_horizon, id_write, parallel, nWorker, pop_size, ...
  nGenerations, OutputFcn, useInitPop, trg, trg_opt, email, delta, ...
  substrate_network_min_limit, substrate_network_max_limit, ...
  plant_network_min_limit, plant_network_max_limit, ...
  change_substrate, change_fermenter, estimator_method, fcn, ...
  use_history, soft_feed, nObjectives)  % Timer function
%% Release: 1.0

%%

error( nargchk(30, 30, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check arguments

is_plant_id(plant_id, '3rd');
checkArgument(method, 'method', 'char', 4);
validatestring(change_type, {'percentual', 'absolute'}, ...
               mfilename, 'change_type', 5);
isN(N, 'N', 6);
checkArgument(timespan, 'timespan', 'double', 7);
isN(control_horizon, 'control_horizon', 8);
isN0(id_write, 'id_write', 9);
validatestring(parallel, {'none', 'multicore', 'cluster'}, mfilename, 'parallel', 10);
isN(nWorker, 'nWorker', 11);
isN(pop_size, 'pop_size', 12);
isN(nGenerations, 'nGenerations', 13);
checkArgument(OutputFcn, 'OutputFcn', 'function_handle', 14, 'on');
is0or1(useInitPop, 'useInitPop', 15);
validatestring(trg, {'on', 'off'}, mfilename, 'trg', 16);
checkArgument(trg_opt, 'trg_opt', 'double', 17);
checkArgument(email, 'email', 'char', 18, 'on');
isR(delta, 'delta', 19, '+');

checkArgument(change_substrate, 'change_substrate', 'double', 24);
checkArgument(change_fermenter, 'change_fermenter', 'double', 25);
checkArgument(estimator_method, 'estimator_method', 'char', 26, 'on');
checkArgument(fcn, 'fcn', 'char', 27);
is0or1(use_history, 'use_history', 28);
is0or1(soft_feed, 'soft_feed', 29);
isN(nObjectives, 'nObjectives', 30);

%%
% load changed variables from latest file, among them current
% equilibriumInit

load('NMPC_TmrFcn_vars.mat');

%% TODO
% hier aufpassen, nicht einfach end nutzen, vor allem nicht bei
% substrate_stock, sondern aktuelle iteration nehmen, falls nicht von timer
% gestartet, dazu entweder src oder event nutzen
% ich kann auch ictrl_start nutzen, wird am ende dieser funktion um 1
% erhöht und ist am anfang 1, ist auch in NMPC_TmrFcn_vars gespeichert

% these iter vars are saved in NMPC_TmrFcn_vars.mat
substrate_network_min= substrate_network_min_iter{ictrl_start};
substrate_network_max= substrate_network_max_iter{ictrl_start};
substrate_stock= substrate_stock_iter{ictrl_start};

%% 
% Sim Time Start
tStart= tic; % simulation time

useStateEstimator= ~isempty(estimator_method);

%%

[substrate, plant, substrate_network, plant_network]= ...
    load_biogas_mat_files(plant_id);
  
fitness_params= load_biogas_mat_files(plant_id, [], 'fitness_params');

%%

is_substrate_network(substrate_network_min_limit, 20, substrate, plant);
is_substrate_network(substrate_network_max_limit, 21, substrate, plant);
is_plant_network(plant_network_min_limit, 22, plant);
is_plant_network(plant_network_max_limit, 23, plant);

%%

if isempty(event)
  use_real_plant= 0;
else
  use_real_plant= 1;
end

%%

num_steps= getNumSteps_Tc(control_horizon, delta);

%%
% 4a) warte auf trigger, in der praxis würde die funktion erst abends
% aufgerufen - das ist ok, schon in startNMPC implementiert
% 4. getEquilibriumEstimateOfBiogasPlant,
% getFeedAndRecycleEstimateOfBiogasPlant 

if ~isempty(estimator_method)
  % gilt für use_real_plant and simulation model
  
  cd('..')      % gehe in Überordner dort liegen alle dateeien für zustandsschätzung
  
  %% TODO
  % sensor_data darf hier eigentlich nicht leer sein, aber wird eh nicht
  % genutzt
  % diese datei sensor_data_estim wird unten nach simulation geschrieben (Z. 280)
  if ~exist('sensor_data_estim.mat', 'file')
    sensor_data= [];
  else
    sensor_data= load_file('sensor_data_estim.mat');
  end
  
  
  %% TODO - implement
  % so soll es nicht implementiert werden, ist aus nonlinearMPC.m kopiert
  % jetzt soll zustand aus daten in postgresql datenbank geschätzt werden
  
  %% TODO - equilibrium existiert hier nicht mehr (anders als wie in nonlinearMPC). 
  % setze zu equilibriumInit
  % diese zeile ergänzt
  equilibrium= equilibriumInit;
  
  %%
  % hole const columeflow aus equilibrium und schreibe in volumeflow const
  % files. wird benötigt in findMinDXNorm bzw. in fitness_DXNorm um dx an
  % aktuellem zustand zu bestimmen.
  
  get_init_feed_oo_equilibrium_and_save_to(equilibrium, ...
    substrate, plant, control_horizon, delta, 1);
  
  %%
  
  equilibriumInit.fitness= equilibrium.fitness;
  
  %%
  % if we have a real plant, we have to get the new measurement data now,
  % directly before estimating the new state
  % with a simulation model, the new "measurement" data is gotten after the
  % simulation was run, see below. 
  if use_real_plant    

    %% TODO
    % you can call the function with only onw argument, thats ok for now
    new_sensor_data= get4MeasurementsfromDB(plant_id);

    sensor_data= appendSensorData(sensor_data, new_sensor_data);     

    save('sensor_data_estim.mat', 'sensor_data');
    
  end
  
  %%
  
  % get state estimate. this should work with a real plant and also with a
  % simulated one. not yet tested for a real plant
  x_hat= getStateEstimateOfBiogasPlant(plant, ...
                                       sensor_data, estimator_method, 1);

  for idigester= 1:plant.getNumDigestersD()
    fermenter_id= char( plant.getDigesterID(idigester) );

    equilibriumInit.fermenter.(fermenter_id).x0= x_hat(:,idigester);    
  end

  est_error= 0;

  fermenters= fieldnames(equilibrium.fermenter);

  for idigester= 1:plant.getNumDigestersD()
    est_error= est_error + numerics.math.calcRMSE( ...
                equilibrium.fermenter.(fermenters{idigester}).x0, ...
                equilibriumInit.fermenter.(fermenters{idigester}).x0 );
  end

  if est_error > 5
    warning('NMPC:Estimator', 'RMSE= %.2f', est_error);
  end
  
  %%
  
  cd('mpc')   % gehe zurück in UO mpc

  %%
  
else 
  % equilibriumInit= equilibriumInit;
end


%%
% 2. startNMPCatEquilibrium, in simulationsstudien ausschließlich mit N= 1,
% sonst kommt matlab aus der funktion nicht raus. in realität wird email an
% anlage gesendet und dort angewendet. 

% es ändern sich:
% ictrl_start
% tStart sollte man in jeder schleife neu bestimmen
% min und max für substrate und plant, müssen von der funktion zurück
% gegeben werden


%% TODO
% werden von dieser funktion die initstate und volumeflow_const files
% richtig geschrieben? das ist hier meine ich nicht weiter wichtig

%% TODO
% das zurück gegebene equilibriumInit ist meine ich nicht mehr das eqinit,
% dann auch nicht mehr so nennen. auch schauen was ich unten benötige.
% richtig so, equilibrium_1st ist das equilibrium nach der ersten iteration

[equilibrium_1st, substrate_network_min, substrate_network_max, ...
  plant_network_min, plant_network_max, substrate_stock, yhat]= ...
  startNMPCatEquilibrium(equilibriumInit, plant_id, method, change_type, N, ...
  timespan, control_horizon, id_write, parallel, nWorker, pop_size, ...
  nGenerations, OutputFcn, useInitPop, trg, trg_opt, email, delta, ...
  ictrl_start, tStart, substrate_network_min_limit, substrate_network_max_limit, ...
  plant_network_min_limit, plant_network_max_limit, ...
  substrate_network_min, substrate_network_max, ...
  plant_network_min, plant_network_max, change_substrate, change_fermenter, ...
  fcn, use_history, soft_feed, substrate_stock, nObjectives);


%%
% 3a) warte auf mail bzw. trigger von einem timer oder ähnliches
% 3. simRealBiogasPlant oder wende Substrat auf richtige anlage an

if ~use_real_plant

  %%

  dispMessage('Apply optimal feed to controlled simulation model for sampling time.', ...
    mfilename);

  
  %%
  % this is new, we have two different plants, the one in the upper folder
  % is the real one to be controlled
  cd('..');
  
  %% 
  % do a simulation
  
  %% 
  % sets where the simulations start
  Ndelta= (ictrl_start - 1) * delta;
  
  %%
  % hier bekomme feed aus vorherigem equilibrium, richtig so
  init_substrate_feed= get_init_feed_oo_equilibrium(equilibriumInit, ...
                                substrate, plant, control_horizon, delta);
                              
  %%
  % because I have to start simulation below from initial state, but with
  % optimal feed I copy the optimal feed into the init equilibrium
  
  equilibriumInit.network_flux= equilibrium_1st.network_flux;
  equilibriumInit.network_flux_string= equilibrium_1st.network_flux_string;

  
  %% 
  % save volumeflows in equilibriumInit in a user file or workspace variable. if
  % workspace, then they must be saved in the mat file below
  % nutze NMPC_save_ctrl_strgy_SubstrateFlow als ausgangsbasis
  % NMPC_append2volumeflow_user
  
  % load volumeflow files from file if existent
  
  % call NMPC_append2volumeflow_user
  
  % save volumeflow variable to file again
  % both for substrates and recycles
  
  % could use equilibriumInit here as well
  
  NMPC_append2volumeflow_user_substratefile(equilibrium_1st, substrate, ...
  plant, delta, num_steps);

  NMPC_append2volumeflow_user_sludgefile(equilibrium_1st, substrate, ...
  plant, delta, num_steps, plant_network, plant_network_max);
  
  %%
  % if file adm1_param_vec mat file exist, then it was saved in previous
  % call of this function (below this function). contains the adm1 params
  % after plant was stopped the last time
  
  %plant= load_ADMparam_vec_from_file(plant);
  % this is now called in simBiogasPlant
  
  samp_time= numerics.math.round_float(min(1/(24*12), delta / 20), 4);
  
  %%
  % 24 h == 1 day, sampling time in days, 0.25-0.5 days, for simulation
  % over sampling time delta, minimum: 5 min, needed because of slave
  % control loop. a even smaller sampling time (3 - 6 min) would be better
  set_sensors_sampling_time(plant_id, samp_time);
  
  %%
  
  if useStateEstimator
    %% TODO
    % hier einen anderen Aufruf nutzen, Simulation aufrufen, welche in
    % postgresql datenbank schreibt
    [fit, equilibriumNew, plant, new_sensor_data]= ...
      NMPC_simBiogasPlantExtended(fcn, equilibriumInit, plant, substrate, ...
                             plant_network, substrate_network, ...
                             fitness_params, [Ndelta, delta + Ndelta], ...
                         control_horizon, num_steps, ...
                         num_steps, use_history, init_substrate_feed);
                           
    sensor_data= appendSensorData(sensor_data, new_sensor_data);     
    
    save('sensor_data_estim.mat', 'sensor_data');
  else
    % this equilibriumINit is the new state. it contains the new state and
    % the optimal feed which was just supplied to the plant
    
    %% TODO
    % wenn Ndelta > 0 ist und volumeflow in equilibriumInit dynamisch ist,
    % dann wird das nicht funktionieren, da volumelflow user ab zeitpunkt 0
    % ist und bei Ndelta > 0 dann vielleicht schon constant ist. deshalb
    % muss bei Ndelta > 0 user für Ndelta nach hinten geschoben werden.
    [fit, equilibriumNew, plant, ~, sensors]= ...
      NMPC_simBiogasPlantExtended(fcn, equilibriumInit, plant, substrate, ...
                             plant_network, substrate_network, ...
                             fitness_params, [Ndelta, delta + Ndelta], ...
                         control_horizon, num_steps, ...
                         num_steps, use_history, init_substrate_feed);
    
    %% TODO
    % save ADM1 params as stream into a ts object and to a file
    % this is used as a test
    save_sensorsData2ts(sensors, plant, 'ts_ADM1params_real.mat', ...
                        'ts_ADM1state_real.mat');
    
    %% TODO
    % only for debugging
    % do not do this anymore, because the file is overwritten by all
    % experiments
    %NMPC_create_ref_biogas_1_slave(sensors, plant, 0, 'ref_biogas_1_master');
    
    %% TODO - test
    
    if isnan(fit)
      save('workspace_err.mat');
      
      error('Simulation of model of real plant failed!');
    end
    
  end
  
  %%
  % save new adm params in file
  
  save_ADMparams_to_mat_file(plant);
  
  %%
  % save ADM1 param vector to file, is load again above (in simBiogasPlant)
  
  save_ADMparam_vec_to_file(plant);
  
  %% 
  % we have to copy this file in subfolder mpc because there a file exist,
  % which contains the params of the future
  
  %% TODO
  % why is the other params not copied as well
  
  %% TODO
  % man muss ein bisschen auf params_min/max.mat im UO mpc aufpassen. beide
  % dateien wurden etwas ausgehölt, viele parameter welche in den dateien
  % stehen, haben keine wirkung mehr. wenn sich allerdings hier parameter
  % ändern, welche auch einen einfluss in params_min/max haben, dann müssen
  % beide dateien im UO mpc in jeder iteration geändert werden.
  
  %% TODO
  % when controlled model and prediction model should have different
  % parameter values, then we cannot simply copy the file here
  
  % NEVER COPY this file here! because when we have a real plant then we do
  % not get the new ADM1 params as well. Maybe someday we will estimate the
  % ADM1 params, then we could copy the file here
%   copyfile(sprintf('adm1_param_vec_%s.mat', plant_id), ...
%            sprintf('mpc/adm1_param_vec_%s.mat', plant_id));
  
  %%
  
  if useStateEstimator
    
    %%
    % get 4 measurements assumed to be measurable in practice as well out of
    % sensors. same as used for state estimation. needed to compare estimated
    % y with really measured y (ymeas), for offset-free NMPC
    [ymeas.pH, ymeas.ch4, ymeas.co2, ymeas.ch4p]= get4MeasurementsfromSensors(new_sensor_data, plant);

  else
  
    %%
    % get 4 measurements assumed to be measurable in practice as well out of
    % sensors. same as used for state estimation. needed to compare estimated
    % y with really measured y (ymeas), for offset-free NMPC
    [ymeas.pH, ymeas.ch4, ymeas.co2, ymeas.ch4p]= get4MeasurementsfromSensors(sensors, plant);
    
  end
  
  %%
  % calc difference between measured and predicted measurements
  
  yerr.pH= median(sqrt((ymeas.pH - yhat.pH).^2));
  yerr.ch4= median(sqrt((ymeas.ch4 - yhat.ch4).^2));
  yerr.co2= median(sqrt((ymeas.co2 - yhat.co2).^2));
  yerr.ch4p= median(sqrt((ymeas.ch4p - yhat.ch4p).^2));
  
  
  %% TODO
  % teste ob equilibriumINit == equilibrium_1st
  
  %%
  
  save(sprintf('equilibria_iter_%i', ictrl_start), ...
    'equilibrium_1st', 'equilibriumInit', 'equilibriumNew');
  
  %%
  % hier wird der neu bestimmte zustand als zustandsschätzung für die
  % nächste iteration übernommen
  
  equilibriumInit= equilibriumNew;
  
  %%
  % go back into subfolder, which must be named mpc
  
  cd('mpc');

  %%

  dispMessage('Successfully applied optimal feed to controlled simulation model for sampling time.', ...
    mfilename);

else % ~use_real_plant
  
  % use real plant
  
  %% TODO
  % send optimal feed as mail?
  
  
  
  %% TODO
  % do I wait for time delta here? delta usually is 1 day!
  
  % no I don't have to wait here
  
  %% TODO
  % after time delta we have to get new data from database and store them
  % in new_sensor_data
  
  % I do this in the beginning of the script
  
end


%%
% such that next iteration is shifted one time step further (sampletime)

ictrl_start= ictrl_start + 1;

%%

substrate_network_max_iter{ictrl_start}= substrate_network_max;
substrate_network_min_iter{ictrl_start}= substrate_network_min;

% wenn neues substrate_stock hinten an iter angehängt wird, oder das zu
% füllende element in iter leer ist, dann füge aktuellen substrate_stock
% ein. wenn das allerdings nicht gilt, dann steht in iter an dieser stelle
% ein feed_stock, welchen ich am start von experiment angegeben habe und
% welcher bspw. ein auffüllen von substraten bedeutet. dann hier nicht
% überschreiben
if numel(substrate_stock_iter) < ictrl_start || isempty(substrate_stock_iter{ictrl_start})
  substrate_stock_iter{ictrl_start}= substrate_stock;
else
  % if an element in substrate_stock_iter is negative this symbolizes that
  % we want to take the current value in substrate_stock. this always
  % happens when we get a new amount for one or more substrate but the
  % other substrates are not changed. then the unchanged substrates are
  % symbolized with -1. or just a negative number
  is_smaller_0= (substrate_stock_iter{ictrl_start} < 0);
  substrate_stock_iter{ictrl_start}(is_smaller_0)= substrate_stock(is_smaller_0);
end

%% TODO
% this means that at least one substrate is refilled. then allow a big step of
% substrate feed to go to previous optimal feed
%% TODO
% das man nur für eine iteration die werte ändert, ist vielleicht zu wenig.
% bei kleinen sampling zeiten (bspw. 1 tag) bedeutet das, dass nur für 1
% tag eine hohe substratänderung erlaubt ist, das reicht nicht!!!
%% TODO
% was man als alternative auch machen könnte:
% in den iterationen wo substrate noch nicht eingeschränkt sind die
% optimale paretoset bzw. das optimale feed speichern. wenn substratlager
% wieder aufgefüllt wird, versuchen dieses als startwert/startpopulation zu
% nutzen. ist auch nicht ganz richtig, da wir ja nicht in einem schritt auf
% die ursprüngliche substratzufuhr wollen, sondern nur einen schritt in
% diese richtung machen möchten. bei multi-objective könnte man evtl. einen
% teil der paretoset als startwerte nehmen, bzw. bei populationsbasierten
% methoden auch. bei MO sollte ich das machen um mehr variabilität hinein
% zu bekommen
%% TODO
% ich könnte w_udot auch abhängig vom setpoint error machen. ich muss nur
% aufpassen, dass ich w_udot nicht verkleinere wenn der regler gerade
% schwingt bzw. dadurch ins schwingen kommt
% gleich gilt auch für scalefac. das könnte auch von setpoint error
% abhängig gemacht werden. wenn error groß ist, dann scalefac klein machen,
% damit der einzugsbereich zum setpoint größer wird (führt allerdings auch
% dazu, dass wenn fehler groß ist, setpoint immer unwichtiger wird, das
% kann nicht sinnvoll sein). wenn error klein ist, 
% dann scalefac vergrößern um immer genauer auf den richtigen setpoint zu
% kommen. eine obere schranke für scalefac sollte aber nicht überschritten
% werden. evtl. scalefac_max/min als parameter in fitness_params vorgeben
if ictrl_start > 1 && ... % könnte bei abfrage unten auch > 0 machen, zur sicherheit > 1 m³
   any(substrate_stock_iter{ictrl_start} - substrate_stock_iter{ictrl_start - 1} > 1) && ...
   0      % momentan braucht man das hier nicht
 
  %%
  
  fitness_params.set_params_of('w_udot', 0.005);
  
  %% TODO
  % this only holds for the biogas_1 (methane) setpoint
  % do this to allow for a higher deviation from the setpoint in this
  % iteration. when feed is changed the setpoint is lost for one iteration.
  % in next iteration (below) factor is reset to default to get a good
  % setpoint tracking
  % ich gehe davon aus, dass wenn ich setpoint weg nehme der ganz
  % automatisch zurück zu optimal feed geht wie es vor der
  % substratbegrenzung war. 
  % er darf allerdings auch nicht sprunghaft zurück zur optimalen
  % substratzufuhr, leider macht er das und verlässt damit ganz deutlich
  % den sollwert. deshalb scalefac hier um faktor 10 vergrößert
  if fitness_params.mySetpoints.Count > 0
    %fitness_params.mySetpoints.get(0).set_params_of('scalefac', 0.000001);
    fitness_params.mySetpoints.get(0).set_params_of('scalefac', 0.00001);
  end
  
  %% TODO
  % just save, such that I can check whether this has worked
  % delete in the future
  % this is ok we are currently in mpc subfolder
  fitness_params.saveAsXML(sprintf('fitness_params_%s_new.xml', plant_id));

else
  %% TODO - könnte hier auch fitness_params aus parent ordner laden
  
  if 0 % für meine expIII für epex= 0 habe ich hier für w_udot= 0.005
    % deshalb if 0 davor gesetzt. andere tests wurden bisher nicht davon
    % verändert, da diese ohnehin mit w_udot= 0.05 arbeiten
    %% TODO
    % set back to previous value - I do not know what the previous value was?
    fitness_params.set_params_of('w_udot', 0.05);   % this is the original value in expI,II
    % der erste Aufruf setzt gewicht auf 0.048 und nicht 0.05, alle anderen
    % gewichte werden auch beim ersten aufruf wieder auf den ursprünglichen
    % wert zurück gesetzt. 
    fitness_params.set_params_of('w_udot', 0.05);
  end
  
  if fitness_params.mySetpoints.Count > 0
    myscale= fitness_params.mySetpoints.get(0).get_params_of('scalefac').Value;
    
    % schrittweise wieder das setpoint tracking wichtig machen
    if myscale * 100 < 0.001
      fitness_params.mySetpoints.get(0).set_params_of('scalefac', myscale * 100);
    else
      %% TODO
      % this only holds for the biogas_1 (methane) setpoint
      fitness_params.mySetpoints.get(0).set_params_of('scalefac', 0.001);
    end
  end
  
end

% this is ok we are currently in mpc subfolder
fitness_params.saveAsXML(sprintf('fitness_params_%s.xml', plant_id));

% this is ok we are currently in mpc subfolder
%% TODO - delete in the future, just to test
fitness_params.saveAsXML(sprintf('fitness_params_%s_%i.xml', plant_id, ictrl_start));

%%

save('NMPC_TmrFcn_vars.mat', 'equilibriumInit', 'ictrl_start', ...
     'substrate_network_min_iter', 'substrate_network_max_iter', ...
     'plant_network_min', 'plant_network_max', 'substrate_stock_iter', 'yerr');

%%


