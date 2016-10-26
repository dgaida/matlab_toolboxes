%% get_feed_oo_equilibrium_and_save_to
% Get substrate feed out of equilibrium and save it to volumeflow file (or workspace)
%
function [substrate_feed, u_vflw]= get_feed_oo_equilibrium_and_save_to(equilibrium, ...
  substrate, plant, varargin)
%% Release: 1.4

%%

error( nargchk(3, 6, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%
% read out varargin

if nargin >= 4 && ~isempty(varargin{1}), 
  accesstofile= varargin{1}; 
  
  isZ(accesstofile, 'accesstofile', 4, -1, 1);
else
  accesstofile= 1; 
end

if nargin >= 5 && ~isempty(varargin{2}), 
  control_horizon= varargin{2}; 
  
  isN(control_horizon, 'control_horizon', 5);
else
  control_horizon= []; 
end

if nargin >= 6 && ~isempty(varargin{3}), 
  lenGenomSubstrate= varargin{3}; 
  
  isN(lenGenomSubstrate, 'lenGenomSubstrate', 6);
else
  lenGenomSubstrate= 1; 
end

%%
% check arguments

is_equilibrium(equilibrium, 1);
is_substrate(substrate, '2nd');
is_plant(plant, '3rd');

if lenGenomSubstrate > 1 && isempty(control_horizon)
  error('If lenGenomSubstrate > 1 (it is %i) control_horizon may not be empty!', ...
        lenGenomSubstrate);
end

%%

[substrate_feed, u_vflw]= get_feed_oo_equilibrium(equilibrium, substrate, plant, ...
                                          'user', lenGenomSubstrate);

%%

plant_id= char(plant.id);

if lenGenomSubstrate == 1
  create_volumeflow_files(substrate_feed', plant_id, accesstofile, 'const');
else
  create_volumeflow_files(substrate_feed', plant_id, accesstofile, 'user', ...
                          control_horizon/lenGenomSubstrate);  
end

%%



%%


