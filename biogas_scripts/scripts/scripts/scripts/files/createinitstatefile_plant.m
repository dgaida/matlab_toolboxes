%% createinitstatefile_plant
% Create initstate.mat file for a plant with user defined digester states
%
function [initstate]= createinitstatefile_plant(type, plant_id, varargin)
%% Release: 1.4

%%

error( nargchk(2, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check input parameters

if nargin >= 3 && ~isempty(varargin{1}), 
  user_state= varargin{1}; 
else
  user_state= []; 
end

if nargin >= 4 && ~isempty(varargin{2}), 
  accesstofile= varargin{2}; 
  isZ(accesstofile, 'accesstofile', 4, -1, 1);
else
  accesstofile= -1; 
end

%%

validatestring(type, {'random', 'default', 'user'}, mfilename, 'type', 1);
is_plant_id(plant_id, '2nd');

%%

if strcmp(type, 'user')
  checkArgument(user_state, 'user_state', 'double', '3rd');
  
  if isempty(user_state)
    error('The 3rd argument user_state is empty! May not be empty if type is user!');
  end
end

%%

plant= load_biogas_mat_files(plant_id, [], {'plant'});

%%

n_digester= plant.getNumDigestersD();

if ~isempty(user_state) && ( size(user_state, 2) ~= n_digester )
  error('size(user_state, 2) ~= n_digester: %i ~= %i', size(user_state, 2), n_digester);
end

for idigester= 1:n_digester

  digester_id= char(plant.getDigesterID(idigester));
  
  if ~isempty(user_state)
    [initstate]= createinitstatefile(type, plant_id, 'fermenter', ...
                    digester_id, user_state(:, idigester), accesstofile);
  else
    [initstate]= createinitstatefile(type, plant_id, 'fermenter', ...
                    digester_id, [], accesstofile);              
  end
  
end

%%



%%


