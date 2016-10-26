%% get_path2xml_configfile
% Get path to any xml config file (substrate, plant, fitness_params, sensors, ...)
%
function path2xml= get_path2xml_configfile(plant_id, filename_pattern, varargin)
%% Release: 1.5

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% readout varargin
% das ist bewusst auskommentiert, da auch ein leerer pfad '' übergeben
% werden müssen kann, oder auch []
if nargin >= 3 %&& ~isempty(varargin{1})
  setting= varargin{1};
  
  checkArgument(setting, 'setting', 'char', '3rd', 'on');
else
  %setting = [];
  setting= [plant_id, '/'];
end

%%
% check arguments

is_plant_id(plant_id, '1st');
checkArgument(filename_pattern, 'filename_pattern', 'char', '2nd');

%%
% schaue erst mal im aktuellen ordner

path2xml= fullfile(sprintf(filename_pattern, plant_id));
  
%%

if ~exist(path2xml, 'file')

  %%
  % dann schaue im unterordner namens setting
  
  path2xml= fullfile(setting, sprintf(filename_pattern, plant_id));
  
  %%
  
  if ~exist(path2xml, 'file')

    %%
    % dann schaue im config pfad
    if strcmp(setting, '')        % if setting == '', then set it to plant_id
      setting= [plant_id, '/'];
    end

    path2xml= fullfile(getConfigPath(), setting, sprintf(filename_pattern, plant_id));

    %%

  end
  
  %%
  
end

%%


