%% load_volumeflow_files
% Load volumeflow substrate/digester files from current path
%
function volumeflows= load_volumeflow_files(id, vol_type, varargin)
%% Release: 1.4

%%

error( nargchk(3, 6, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

validatestring(id, {'substrate', 'digester'}, mfilename, 'id', 1);

%%

if nargin >= 3 && ~isempty(varargin{1})
  if strcmp(id, 'substrate')
    substrate= varargin{1};
    is_substrate(substrate, 3);
  elseif strcmp(id, 'digester')
    %% 
    % 
    plant= varargin{1};
    is_plant(plant, 3);
    
    error( nargchk(6, 6, nargin, 'struct') );

    plant_network= varargin{3};
    plant_network_max= varargin{4};
    
    is_plant_network(plant_network, 5, plant);
    is_plant_network(plant_network_max, 6, plant);
    
  else
    error('Unknown id: %s!', id); % cannot happen
  end
end

if nargin >= 4 && ~isempty(varargin{2})
  mypath= varargin{2};
  checkArgument(mypath, 'mypath', 'char', 4);
else
  mypath= pwd;
end

%%
% check arguments

is_volumeflow_type(vol_type, 2);


%%

if strcmp(id, 'substrate')

  volumeflows= get_volumeflows_from(substrate, vol_type, 1, mypath);

else

  volumeflows= get_volumeflows_sludge_from(plant, plant_network, ...
                          plant_network_max, vol_type, 1, mypath);
  
end

%%



%%


