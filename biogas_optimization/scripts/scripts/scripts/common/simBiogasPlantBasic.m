%% simBiogasPlantBasic
% Simulate a biogas plant model with in model selected settings
%
function [t, x, y, fitness, sensors, sensors_data]= simBiogasPlantBasic(plant_id, varargin)
%% Release: 1.1

%%

error( nargchk(1, 8, nargin, 'struct') );
error( nargoutchk(0, 6, nargout, 'struct') );

%%

if nargin >= 2 && ~isempty(varargin{1}), 
  timespan= varargin{1}; 
  
  isRn(timespan, 'timespan', 2, '+');
else
  timespan= [0, 100]; 
end

if nargin >= 3 && ~isempty(varargin{2}), 
  savestate= varargin{2}; 
  
  validatestring(savestate, {'on', 'off'}, mfilename, 'savestate', 3);
else
  savestate= 'off'; 
end

if nargin >= 4 && ~isempty(varargin{3})
  use_history= varargin{3};
  
  is0or1(use_history, 'use_history', 4);
else
  use_history= 0; % default 0
end

if nargin >= 5 && ~isempty(varargin{4})
  init_substrate_feed= varargin{4};
  %% TODO
  % check argument n_substrate x n_digester
else
  init_substrate_feed= [];
end

if nargin >= 6 && ~isempty(varargin{5})
  id_write= varargin{5};
else
  id_write= [];
end

if nargin >= 7 && ~isempty(varargin{6})
  doplots= varargin{6};
  is0or1(doplots, 'doplots', 7);
else
  doplots= 0;
end

if nargin >= 8 && ~isempty(varargin{7})
  vol_type= varargin{7};
  is_volumeflow_type(vol_type, 8);
else
  vol_type= [];     % do not change
end

%%
% check input arguments

is_plant_id(plant_id, '1st');

%%

fcn= ['plant_', plant_id];

%%

[substrate, plant]= load_biogas_mat_files(plant_id);
                              
%%

t= [];
x= [];
y= [];
fitness= 0;

sensors= cell(numel(timespan) - 1, 1);

%%

if numel(timespan) > 2    % aufsplitten der Simulation

  %%
  
  substrates= create_substrate_cell(numel(timespan));
  
  %%
  
  if numel(timespan) ~= numel(substrates) + 1
    error('numel(timespan)');
  end

  %%
  
  if strcmp(savestate, 'off')
    copyfile(sprintf('initstate_%s.mat', plant_id), ...
             sprintf('initstate_%s_copy.mat', plant_id));
  end
  
  %%
  
end

%%

for it= 1:numel(timespan) - 1

  %%

  if numel(timespan) > 2    % aufsplitten der Simulation
    substrates{it}.saveAsXML( fullfile(pwd, sprintf('substrate_%s.xml', plant_id)) );
  end
  
  %%
  % load the biogas plant model
  load_biogas_system(fcn, 'none', 1);

  %%
  
  if numel(timespan) > 2    % aufsplitten der Simulation

    %%
    % save the final state or not of the ADM1
    setSaveStateofADM1Blocks(fcn, 'on');

  else
    
    %%
    % save the final state or not of the ADM1
    setSaveStateofADM1Blocks(fcn, savestate);

  end
  
  %%
  
  %% TODO
  % das wird in simBiogasPlant so gemacht - bisher fehlte das hier im
  % skript (Z. 146 bis Z. 157) sollte aber denke ich auch hier drin sein. besser
  % wäre aber vielleicht noch in init_biogas_plant_mdl.m, damit auch bei
  % einer manuellen simulation das gleiche gemacht wird so wie hier
  %
  % if file adm1_param_vec mat file exist, then it was saved in previous
  % call of this function (below this function). contains the adm1 params
  % after plant was stopped the last time

  plant= load_ADMparam_vec_from_file(plant);

  assigninMWS('plant', plant);

  
  %%
  % set volumeflow type
  
  if ~isempty(vol_type)
    set_volumeflow_type(fcn, vol_type);    % set to const, user
  end
  
  %%
  % simulate the biogas plant for the given timespan
  try
    [tt, xt, yt]= sim(fcn, [timespan(it) timespan(it + 1)]);

    t= [t; tt];
    x= [x; xt];
    y= [y; yt];
  catch ME
    warning('sim:error', 'sim failed!');
    disp(ME.message);
    
    disp(get_stack_trace(ME));
    
    yt= [];
  end

  
  %%
  % get the sensors object out of the model workspace
  if numel(timespan) > 2
    sensors{it}= evalinMWS('sensors');
    sensors_l= sensors{it};
  else
    sensors= evalinMWS('sensors');
    sensors_l= sensors;
  end
  
  %%
  % get fitness value
  if ~isempty(yt)
    % 
    if ~use_history       % use_history == 0
      fitness= 0;
    end
    
    fitness= fitness + getRecordedFitnessExtended(sensors_l, substrate, plant, yt, tt, ...
                                        [], use_history, init_substrate_feed);

  else
    %% 
    fitness= Inf;% .* ones(1, lenGenomSubstrate);
  end

  %%
  % default set to off, no matter what
  setSaveStateofADM1Blocks(fcn, 'off');

  %%
  % close biogas plant model
  close_biogas_system(fcn);

  %%
  % signalizes a simulation error in the previous simulation
  if isempty(yt)
    break;
  end
  
end

%%

if (numel(timespan) > 2) && strcmp(savestate, 'off')
  copyfile(sprintf('initstate_%s_copy.mat', plant_id), ...
           sprintf('initstate_%s.mat', plant_id));
         
  delete(sprintf('initstate_%s_copy.mat', plant_id));
end

%%
% call getDataOutOfSensors
%% TODO, 3. parameter variabel machen

if ~isempty(yt)
  sensors_data= getDataOutOfSensors(plant_id, sensors, doplots, id_write);
else
  sensors_data= [];
end

%%


