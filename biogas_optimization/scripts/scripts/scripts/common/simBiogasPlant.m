%% simBiogasPlant
% Simulate a biogas plant created with the library of the _Biogas
% Plant Modeling_ Toolbox. 
%
function [fitness, equilibrium, fcn, sensors]= ...
                     simBiogasPlant(equilibrium, plant, substrate, ...
                                    plant_network, substrate_network, ...
                                    varargin)
%% Release: 1.3

%%

error( nargchk(5, 19, nargin, 'struct') );
error( nargoutchk(0, 4, nargout, 'struct') );

%% 
% read out varargin

if nargin >= 6 && ~isempty(varargin{1})
  timespan= varargin{1};
  
  if ~isa(timespan, 'double') || numel(timespan) ~= 2
    error('The 6th parameter timespan is not a 2-dim double vector, but %s!', ...
          class(timespan));
  end
else
  timespan= [0, 100];
end

if nargin >= 7 && ~isempty(varargin{2})
  initstate_type_hydraulic_delay= varargin{2};
  
  validatestring(initstate_type_hydraulic_delay, {'default', 'user'}, ...
                 mfilename, 'initstate_type_hydraulic_delay', 7);
else
  initstate_type_hydraulic_delay= 'default';
end

if nargin >= 8 && ~isempty(varargin{3})
  saveInEquilibrium= varargin{3}; 
  
  is0or1(saveInEquilibrium, 'saveInEquilibrium', 8);
else
  saveInEquilibrium= 0; 
end

if nargin >= 9 && ~isempty(varargin{4})
  nWorker= varargin{4}; 
  
  isN(nWorker, 'nWorker', 9);
else
  nWorker= 1; 
end

if nargin >= 10 && ~isempty(varargin{5})
  setNetworkFluxInModelWorkspace= varargin{5}; 
  
  is0or1(setNetworkFluxInModelWorkspace, 'setNetworkFluxInModelWorkspace', 10);
else
  setNetworkFluxInModelWorkspace= 1;
end

if nargin >= 11 && ~isempty(varargin{6})
  setStateInModelWorkspace= varargin{6}; 
  
  is0or1(setStateInModelWorkspace, 'setStateInModelWorkspace', 11);
else
  setStateInModelWorkspace= 1;
end

if nargin >= 12 && ~isempty(varargin{7})
  %% TODO
  % closeModel wirkt sich nur aus, wenn nWorker > 1. Muss für nWorker > 1
  % closeModel nicht immer 1 sein? dann wäre closeModel überflüssig!
  closeModel= varargin{7}; 
  
  is0or1(closeModel, 'closeModel', 12);
else
  closeModel= 1;
end

if nargin >= 13 && ~isempty(varargin{8})
  %% TODO
  % wird nicht mehr genutzt
  model_suffix= varargin{8};
else
  model_suffix= [];
end

if nargin >= 14 && ~isempty(varargin{9})
  control_horizon= varargin{9};
  
  isR(control_horizon, 'control_horizon', 14);
else
  control_horizon= timespan(end);
end

if nargin >= 15 && ~isempty(varargin{10})
  lenGenomSubstrate= varargin{10};
  
  isN(lenGenomSubstrate, 'lenGenomSubstrate', 15);
else
  lenGenomSubstrate= 1;
end

if nargin >= 16 && ~isempty(varargin{11})
  lenGenomPump= varargin{11};
  
  isN(lenGenomPump, 'lenGenomPump', 16);
else
  lenGenomPump= 1;
end

if nargin >= 17 && ~isempty(varargin{12})
  use_history= varargin{12};
  
  is0or1(use_history, 'use_history', 17);
else
  use_history= 0; % default 0
end

if nargin >= 18 && ~isempty(varargin{13})
  init_substrate_feed= varargin{13};
  %% TODO
  % check argument n_substrate x n_digester
else
  init_substrate_feed= [];
end

if nargin >= 19 && ~isempty(varargin{14})
  fitness_params= varargin{14};
  
  is_fitness_params(fitness_params, 19);
else
  fitness_params= [];
end


%%
% check input parameters

is_equilibrium(equilibrium, '1st');
is_plant(plant, '2nd');
is_substrate(substrate, '3rd');
is_plant_network(plant_network, 4, plant);
is_substrate_network(substrate_network, 5, substrate, plant);


%%

plant_id= char(plant.id);

fcn= ['plant_', plant_id];


%%
% take a plant model which isn't simulating at the moment

[fcn]= get_available_model_parallel(nWorker, fcn);


%% 
% set the substrate flow and pump flow arrays in the workspace

if setNetworkFluxInModelWorkspace == 1

  %% 
  % set network flux in model workspace (-1)
  % if lenGenomSubstrate > 1, then in the volumeflow_..._user variable is
  % written, else in a volumeflow_..._const variable. 
  [substrate_network]= ...
      setNetworkFluxInWorkspace(equilibrium, ...
                          lenGenomSubstrate, lenGenomPump, ...
                          substrate, plant, substrate_network, ...
                          -1, control_horizon);

end


%% 
% set Initial States of fermenter and hydraulic delays In model Workspace
% (-1)

if setStateInModelWorkspace == 1

  setInitStateInWorkspace(equilibrium, plant, plant_network, ...
                          initstate_type_hydraulic_delay, -1);

end


%%

if getMATLABVersion() <= 708
  disp('Suppressing warning LibraryVersion!');
  % warning OFF LibraryVersion
  warning('off', 'Simulink:SL_RefBlockUnknownParameter');
end

%%
% if model is only opened once, then we should delete data out of sensors,
% from the last simulation
  
if (nWorker == 1)
  
  sensors= evalinMWS('sensors');

  sensors.deleteDataFromAllSensors();
  
end

%%

%%
% if file adm1_param_vec mat file exist, then it was saved in previous
% call of this function (below this function). contains the adm1 params
% after plant was stopped the last time

plant= load_ADMparam_vec_from_file(plant);

assigninMWS('plant', plant);


%%
% proove if we should simulate from the actual state (if the velocity
% is too high, then simulating would lead to convergence errors)
% nur für Daniel
if ( saveInEquilibrium == 1 )

  [dxMaxNorm, y]= calcDXNorm(fcn, 'infinity', []);

  threshold_maxnorm= 32500*1e4;

  threshold_fitness= 25000;

  if ( dxMaxNorm < threshold_maxnorm ) && ( y(1) < threshold_fitness )

    %% 
    % simulate system

    try
      [t,x,y]= sim(fcn, timespan);
    catch ME
      warning('sim:error', 'sim failed!');
      disp(ME.message);

      for imessage= 1:size(ME.cause,1)
        disp(ME.cause{imessage,1}.message);
      end

      disp(get_stack_trace(ME));
      
      y= [];
    end

  else

    disp(sprintf('equilibrium not simulated: dx: %.3f, fitness: %.3f', ...
         dxMaxNorm / threshold_maxnorm, y / threshold_fitness));

  end

else

  %% 
  % simulate system (Christian)

  try
    [t,x,y]= sim(fcn, timespan);
  catch ME
    warning('sim:error', 'sim failed!');
    disp(ME.message);

    for imessage= 1:size(ME.cause,1)
      disp(ME.cause{imessage,1}.message);
    end

    disp(get_stack_trace(ME));
    
    y= [];
  end

end

%%

sensors= evalinMWS('sensors');

%%

if getMATLABVersion() <= 708
  % warning On LibraryVersion
  warning('on', 'Simulink:SL_RefBlockUnknownParameter');
end

%%

if ~isempty(y)
  %% 
  % 
  fitness= getRecordedFitnessExtended(sensors, substrate, plant, y, t, ...
                                      fitness_params, use_history, init_substrate_feed);

else
  %% TODO
  % why -Inf, and not +Inf
  %fitness= Inf .* ones(1, lenGenomSubstrate);
  % wichtig, dass ich hier auf NaN setze, da SMSEGO hier NaNs erwartet,
  % dieser kann nicht mit Infs arbeiten, da ref Punkt in SMS-EGO Inf wird
  % und damit infeasible
  fitness= NaN .* ones(1, lenGenomSubstrate);
end


%% 
% save the new state in the equilibrium struct

if ( saveInEquilibrium == 1 )

  equilibrium= saveStateInEquilibriumStruct(equilibrium, plant, ...
                                          plant_network, fitness);

else

  equilibrium.fitness= fitness;

end



%%
% save the system

isdirty= get_param(fcn, 'Dirty');

%disp(['dirty ', fcn]);

% 
if strcmp( isdirty, 'on' )
  save_system(fcn);

  % wenn nWorker == 1 ist, dann wird das Modell nur einmal ganz zu
  % Beginn in load_system geladen und darf deshlab nicht geschlossen
  % werden, bei mehreren workern werden die Systeme immer wieder neue
  % geladen und müssen deshalb geschlossen werden
  if closeModel && (nWorker > 1)
    close_system(fcn);
  end
end



%% 
% create the file, which signalizes that the simulation model is
% free again

if closeModel && (nWorker > 1)

  save([fcn, '.mat'], 'fcn');

  %disp(['save ', fcn]);

end

%%


