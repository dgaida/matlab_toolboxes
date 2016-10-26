%% set_nObjectives_in_fitness_params
% Sets nObjectives in fitness_params xml file according to given method
%
function set_nObjectives_in_fitness_params(plant_id, method, varargin)
%% Release: 1.3

%%

error( nargchk(2, 4, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1})
  folders= varargin{1};
  checkArgument(folders, 'folders', 'cellstr', '3rd');
else
  %%
  % ich gehe davon aus, dass funktion in Unterordner mpc aufgerufen wird,
  % d.h. ich muss in übergeordneten Ordner und in aktuellen ordner
  % fitness_params ändern
  folders= {'..', []};      % 'mpc'
end

if nargin >= 4 && ~isempty(varargin{2})
  nMObjectives= varargin{2};
  isN(nMObjectives, 'nMObjectives', 4);
  
  %% TODO
  % delete this warning, as soon as toolbox is ready for higher number of
  % objectives
  if nMObjectives > 3
    warning('param:oorange', ...
      'The 4th parameter nMObjectives is > 3, which is not yet supported by the toolbox!');
  end
else
  nMObjectives= 2;
end

%%
% check arguments

is_plant_id(plant_id, '1st');
checkArgument(method, 'method', 'char', '2nd');

%% 
% check whether method is MO or SO

if is_moa(method)
  nObjectives= nMObjectives;   
else
  nObjectives= 1;
end

%%

filename= sprintf('fitness_params_%s', plant_id);

%%
% C# object

for ifolder= 1:numel(folders)

  %%
  
  file_folder= fullfile(folders{ifolder}, [filename, '.xml']);
  
  %%
  
  if ~exist(file_folder, 'file')
    % load file out of config_mat folder
    fitness_params= load_biogas_mat_files(plant_id, [], 'fitness_params');
    
    dispMessage(sprintf('The file %s does not exist! Using file in config_mat folder.', file_folder), ...
      mfilename);
  else
    fitness_params= biooptim.fitness_params(file_folder);
  end
  
  %%
  
  if double(fitness_params.nObjectives) ~= nObjectives
    dispMessage(sprintf('Changing nObjectives in %s from %i to %i.', file_folder, ...
                double(fitness_params.nObjectives), nObjectives), mfilename);

    fitness_params.set_params_of('nObjectives', int32(nObjectives));

    fitness_params.saveAsXML(file_folder);
  end

end

%%


