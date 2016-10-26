%% simRealBiogasPlant
% After simulation input and measurement data is saved inside a postgreSQL
% database
%
function data= simRealBiogasPlant(equilibrium, plant_id, varargin)
%% Release: 0.7

%%

error( nargchk(2, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check input params

is_equilibrium(equilibrium, 1);
checkArgument(plant_id, 'plant_id', 'char', '2nd');

%%
% read out varargin

if nargin >= 3 && ~isempty(varargin{1})
  postgreSQL= varargin{1};
  checkArgument(postgreSQL, 'postgreSQL', 'char', '3rd');
else
  postgreSQL= sprintf('simdata_%s', plant_id);
end

if nargin >= 4 && ~isempty(varargin{2})
  timespan= varargin{2};
  checkArgument(timespan, 'timespan', 'double', 4);
else
  timespan= [0 500];
end

%%

[substrate, plant, substrate_network, plant_network]= ...
  load_biogas_mat_files(plant_id);

%%
% OPEN BIOGAS MODEL

fcn= sprintf('plant_%s', plant_id);

load_biogas_system(fcn);

%%

simBiogasPlant(equilibrium, plant, substrate, plant_network, substrate_network, ...
               timespan, 'default', 0, 1, 1, 1);

%%

sensors= evalinMWS('sensors');
  
for idigester= 1:plant.getNumDigestersD()
  fermenter_id= char(plant.getDigesterID(idigester));

  data.(fermenter_id)= getDataOfSensor(sensors, fermenter_id);
end

%%
% save data in postgreSQL database

%% TODO

% save the following:

% data.(fermenter_id).Q.substrates and recirculations, resample using
% data.(fermenter_id).t_q 
%
% data.(fermenter_id).pH, ch4, co2, biogas, resample using
% data.(fermenter_id).time 

% see writetodatabase.m

%%
% CLOSE BIOGAS MODEL
close_biogas_system(fcn);  

%%


