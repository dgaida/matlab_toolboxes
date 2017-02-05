%% NMPC_simBiogasPlantExtended
% Simulate biogas plant extended with saving state at the end of the
% simulation
%
function [fit, equilibrium, varargout]= ...
         NMPC_simBiogasPlantExtended(fcn, equilibrium, plant, substrate, ...
                                     plant_network, substrate_network, ...
                                     fitness_params, timespan, ...
                                     control_horizon, lenGenomSubstrate, nSteps, ...
                                     varargin)
%% Release: 1.1

%%

error( nargchk(11, 13, nargin, 'struct') );
error( nargoutchk(0, 5, nargout, 'struct') );

%%

if nargin >= 12 && ~isempty(varargin{1})
  use_history= varargin{1};
  
  is0or1(use_history, 'use_history', 12);
else
  use_history= 0; % default 0
end

if nargin >= 13 && ~isempty(varargin{2})
  init_substrate_feed= varargin{2};
  %% TODO
  % check argument n_substrate x n_digester
else
  init_substrate_feed= [];
end

%%

checkArgument(fcn, 'fcn', 'char', '1st');
is_equilibrium(equilibrium, '2nd');
is_plant(plant, '3rd');
is_substrate(substrate, 4);
is_plant_network(plant_network, 5);
is_substrate_network(substrate_network, 6);
is_fitness_params(fitness_params, 7);
checkArgument(timespan, 'timespan', 'double', 8);

%% TODO:
% alle drei parameter müssen nicht übergeben werden. Ich glaube das ist ok
% so, da lenGenomSubstrate und nSteps unterschiedlich hier sind

isN(control_horizon, 'control_horizon', 9);
isN(lenGenomSubstrate, 'lenGenomSubstrate', 10);
isN(nSteps, 'nSteps', 11);

%%
% OPEN BIOGAS MODEL
load_biogas_system(fcn);
    
%%
% SET SAVESTATE OF ADM1 BLOCKS
setSaveStateofADM1Blocks(fcn, 'on');
  
%%

if lenGenomSubstrate == 1
  set_volumeflow_type(fcn, 'const');    % set to const
end

%%
% Simulate plant for Steady State
% anstatt 500 hatte ich mal 18.5, hat aber mit setpoint regelung probleme
% gemacht, dort fitness oft deutlich größer, 5000 heißt, schreibe
% eigentlich alle
% saves new state in equilibrium
[fit, equilibrium]= simBiogasPlantExtended( ...
                              equilibrium, plant, substrate, ...
                              plant_network, substrate_network, ...
                              fitness_params, timespan, ...
                              1, 1, ...
                              str2func(char(fitness_params.fitness_function)), ...
                              5000000, 1, ...
                              [], [], control_horizon, lenGenomSubstrate, ...
                              1, use_history, init_substrate_feed);

%%
% RESET SAVESTATE OF ADM1 BLOCKS
setSaveStateofADM1Blocks(fcn, 'off');

%%

if lenGenomSubstrate == 1 && nSteps > 1
  set_volumeflow_type(fcn, 'user'); % set to user
end

%%

if nargout >= 3,

  plant= evalinMWS('plant');
  
  varargout{1}= plant;
  
end

%%

if nargout >= 4,
  
  sensors= evalinMWS('sensors');
  
  for idigester= 1:plant.getNumDigestersD()
    fermenter_id= char(plant.getDigesterID(idigester));

    data.(fermenter_id)= getDataOfSensor(sensors, fermenter_id);
  end
  
  varargout{2}= data;

  %%
  
  if nargout >= 5
    varargout{3}= sensors;
  end
  
end


%%
% CLOSE BIOGAS MODEL
close_biogas_system(fcn);  


%%


