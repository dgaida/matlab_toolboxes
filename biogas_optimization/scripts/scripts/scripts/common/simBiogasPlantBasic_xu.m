%% simBiogasPlantBasic_xu
% Simulate biogas plant with given initial state x and input u
%
function [t, x, y, fitness, sensors, sensors_data]= simBiogasPlantBasic_xu(plant_id, x, u, varargin)
%% Release: 0.7

%%

error( nargchk(3, 5, nargin, 'struct') );
error( nargoutchk(0, 6, nargout, 'struct') );

%% 
% read out varargin

if nargin >= 4 && ~isempty(varargin{1})
  u_sample= varargin{1};
  isR(u_sample, 'u_sample', 4, '+');
else
  u_sample= 1;
end

if nargin >= 5 && ~isempty(varargin{2})
  timespan= varargin{2};
  isRn(timespan, 'timespan', 5, '+');
else
  timespan= [0, 100];
end

if nargin >= 6 && ~isempty(varargin{3}), 
  savestate= varargin{3}; 
  
  validatestring(savestate, {'on', 'off'}, mfilename, 'savestate', 6);
else
  savestate= 'off'; 
end

if nargin >= 7 && ~isempty(varargin{4})
  use_history= varargin{4};
  
  is0or1(use_history, 'use_history', 7);
else
  use_history= 0; % default 0
end

if nargin >= 8 && ~isempty(varargin{5})
  init_substrate_feed= varargin{5};
  %% TODO
  % check argument n_substrate x n_digester
else
  init_substrate_feed= [];
end

%%
% check input arguments

checkArgument(plant_id, 'plant_id', 'char', '1st');
checkArgument(x, 'x', 'double', '2nd');
checkArgument(u, 'u', 'double', '3rd');

%%
% save initial state in initstate.mat

createinitstatefile_plant('user', plant_id, x, 1);

%%
% save u in volumeflow mat files

create_volumeflow_files(u, plant_id, 1, 'user', u_sample);

%%
% run the simulation

[t, x, y, fitness, sensors, sensors_data]= ...
  simBiogasPlantBasic(plant_id, timespan, savestate, use_history, init_substrate_feed);


%%


