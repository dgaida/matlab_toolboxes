%% get_init_feed_oo_equilibrium_and_save_to
% Get first values of substrate feed out of equilibrium and save it to
% volumeflow file (or workspace) 
%
function [init_substrate_feed]= get_init_feed_oo_equilibrium_and_save_to(equilibrium, ...
  substrate, plant, control_horizon, varargin)
%% Release: 1.0

%%

narginchk(4, 6);
nargoutchk(0, 1);

%%
% read out varargin

if nargin >= 5 && ~isempty(varargin{1}), 
  delta= varargin{1}; 
  
  isR(delta, 'delta', 5, '+');
else
  delta= control_horizon; 
end

if nargin >= 6 && ~isempty(varargin{2}), 
  accesstofile= varargin{2}; 
  
  isZ(accesstofile, 'accesstofile', 6, -1, 1);
else
  accesstofile= 1;    % save to file
end

%%
% check arguments

is_equilibrium(equilibrium, 1);
is_substrate(substrate, '2nd');
is_plant(plant, '3rd');
isN(control_horizon, 'control_horizon', 4);

if delta > control_horizon
  error('delta > control_horizon (%f > %i)!', ...
        delta, control_horizon);
end

%%

init_substrate_feed= get_init_feed_oo_equilibrium(equilibrium, substrate, plant, ...
                                          control_horizon, delta);

% sum over fermenters
init_substrate_feed= sum(init_substrate_feed, 2);

%%

plant_id= char(plant.id);

% save feed to const files
create_volumeflow_files(init_substrate_feed', plant_id, accesstofile, 'const');


%%



%%


