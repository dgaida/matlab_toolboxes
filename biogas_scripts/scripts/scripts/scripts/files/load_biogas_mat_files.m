%% load_biogas_mat_files
% Load all |*.mat| and |*.xml| files used for simulating a biogas plant
% created with the _Biogas Plant Modeling_ Toolbox.
%
function varargout= load_biogas_mat_files(plant_id, varargin)
%% Release: 1.4

%%

error( nargchk(1, 3, nargin, 'struct') );
error( nargoutchk(0, nargout, nargout, 'struct') );

%%
% readout varargin

if nargin >= 2 && ~isempty(varargin{1})
  setting= varargin{1};
  
  checkArgument(setting, 'setting', 'char', '2nd');
else
  %setting = [];
  setting= [plant_id, '/'];
end

if nargin >= 3 && ~isempty(varargin{2})
  file_names= varargin{2};
  
  if ischar(file_names)
    file_names= {file_names};
  end
  
  checkArgument(file_names, 'file_names', 'cell', '3rd');
else
  file_names= {'substrate', 'plant', ...
               'substrate_network', 'plant_network', ...
               'substrate_network_min', 'substrate_network_max', ...
               'plant_network_min', 'plant_network_max', ...
               'digester_state_min', 'digester_state_max', ...
               'params_min', 'params_max', ...
               'substrate_eq', 'substrate_ineq', ...
               'fitness_params', 'equilibria'};
end

%%
% check argument

is_plant_id(plant_id, '1st');

%%

find_entry= @(entry) any(strcmp(entry, file_names));
myentry_pos= @(entry) entry_pos(entry, file_names);

%%
% load substrate

if nargout >= myentry_pos('substrate') && find_entry('substrate')
  
  %% TODO
  % why do we only search in config path???
  % jetzt sollte es stimmen
  
  searchfile= get_path2xml_configfile(plant_id, 'substrate_%s.xml', setting);
  
  try                   
    substrate= biogas.substrates(searchfile);
  catch ME
    warning('MATLAB:load:couldNotReadFile', ...
           ['The file %s', ...
            ' does not exist. ', 'This file is mandatory, because it ', ...
            'describes the substrate properties used on the plant. ', ...
            'Create the file using the gui gui_substrate.'], searchfile);
          
    rethrow(ME);      
  end
  
  varargout{myentry_pos('substrate')}= substrate;
  
  n_substrate= substrate.getNumSubstratesD();
    
else
  %return;
end


%%
% load plant

if nargout >= myentry_pos('plant') && find_entry('plant')
  
  searchfile= get_path2xml_configfile(plant_id, 'plant_%s.xml', setting);
  
  try                   
    plant= biogas.plant(searchfile);
  catch ME
    warning('MATLAB:load:couldNotReadFile', ...
           ['The file %s', ...
            ' does not exist. ', 'This file is mandatory, because it ', ...
            'describes the properties of the plant. ', ...
            'Create the file using the gui gui_plant.'], searchfile);
          
    rethrow(ME);      
  end
  
  %%
  % if ADM param vec file exist, then load ADM params into plant object
  
  plant= load_ADMparam_vec_from_file(plant, 1);
  
  %%
  
  varargout{myentry_pos('plant')}= plant;
    
  n_fermenter= plant.getNumDigestersD();

else
  %return;
end


%%
% load substrate_network

if nargout >= myentry_pos('substrate_network') && find_entry('substrate_network')
    
  substrate_network= load_file(['substrate_network_', plant_id], ...
         ['This file is mandatory, because it ', ...
          'describes the substrate mix for each digester on the plant. ', ...
          'Create the file by hand. See the documentation.'], setting);

  if exist('n_substrate', 'var') && exist('n_fermenter', 'var')
    checkDimensionOfVariable( substrate_network, [n_substrate, n_fermenter], ...
                              ['substrate_network_', plant_id] );
  end

  %%
  % normalize substrate_network
  
  sum_net= sum(substrate_network, 2);
  idx= sum_net > 0;
  
  sum_net= repmat(sum_net, 1, size(substrate_network, 2));
  
  substrate_network(idx, :)= substrate_network(idx, :) ./ sum_net(idx, :);
  
  %%
  
  varargout{myentry_pos('substrate_network')}= substrate_network;

else
  %return;
end


%%
% load plant_network

if nargout >= myentry_pos('plant_network') && find_entry('plant_network')
    
  plant_network= load_file(['plant_network_', plant_id], ...
         ['This file is mandatory, because it ', ...
          'describes the connections between the digesters of the plant. ', ...
          'Create the file by hand. See the documentation.'], setting);

  varargout{myentry_pos('plant_network')}= plant_network;

  if exist('n_fermenter', 'var')
    checkDimensionOfVariable( plant_network, [n_fermenter, n_fermenter + 1], ...
                              ['plant_network_', plant_id] );
  end
  
else
  %return;
end


%%
% load substrate_network_min

if nargout >= myentry_pos('substrate_network_min') && find_entry('substrate_network_min')

  substrate_network_min= load_file(['substrate_network_min_', plant_id], ...
             ['This file is mandatory for optimization purposes, ', ...
              'because it describes the minimal values of ', ...
              'the substrate mix for each digester on the plant. ', ...
              'Create the file by hand. See the documentation.'], setting);

  varargout{myentry_pos('substrate_network_min')}= substrate_network_min;

  if exist('n_substrate', 'var') && exist('n_fermenter', 'var')
    checkDimensionOfVariable( substrate_network_min, ...
                              [n_substrate, n_fermenter], ...
                              ['substrate_network_min_', plant_id] );
  end
  
else
  %return;
end


%%
% load substrate_network_max

if nargout >= myentry_pos('substrate_network_max') && find_entry('substrate_network_max')

  substrate_network_max= load_file(['substrate_network_max_', plant_id], ...
             ['This file is mandatory for optimization purposes, ', ...
              'because it describes the maximal values of ', ...
              'the substrate mix for each digester on the plant. ', ...
              'Create the file by hand. See the documentation.'], setting);

  varargout{myentry_pos('substrate_network_max')}= substrate_network_max;

  if exist('n_substrate', 'var') && exist('n_fermenter', 'var')
    checkDimensionOfVariable( substrate_network_max, ...
                              [n_substrate, n_fermenter], ...
                              ['substrate_network_max_', plant_id] );
  end
  
else
  %return;
end


%%
% load plant_network_min

if nargout >= myentry_pos('plant_network_min') && find_entry('plant_network_min')

  plant_network_min= load_file(['plant_network_min_', plant_id], ...
             ['This file is mandatory for optimization purposes, ', ...
              'because it describes the minimal values of ', ...
              'the pumped stream on the plant. ', ...
              'Create the file by hand. See the documentation.'], setting);

  varargout{myentry_pos('plant_network_min')}= plant_network_min;

  if exist('n_fermenter', 'var')
    checkDimensionOfVariable( plant_network_min, ...
                              [n_fermenter, n_fermenter + 1], ...
                              ['plant_network_min_', plant_id] );
  end
  
else
  %return;
end


%%
% load plant_network_max

if nargout >= myentry_pos('plant_network_max') && find_entry('plant_network_max')

  plant_network_max= load_file(['plant_network_max_', plant_id], ...
             ['This file is mandatory for optimization purposes, ', ...
              'because it describes the ', ...
              'maximal values of the pumped stream on the plant. ', ...
              'Create the file by hand. See the documentation.'], setting);

  varargout{myentry_pos('plant_network_max')}= plant_network_max;

  if exist('n_fermenter', 'var')
    checkDimensionOfVariable( plant_network_max, ...
                              [n_fermenter, n_fermenter + 1], ...
                              ['plant_network_max_', plant_id] );
  end
  
else
  %return;
end


%%
% load digester_state_min

if nargout >= myentry_pos('digester_state_min') && find_entry('digester_state_min')

  % if you don't want to optimize the initial state of the digesters, then
  % set digester_state_min= digester_state_max= your optimal initial state, 
  % using the two files. 
  digester_state_min= load_file(['digester_state_min_', plant_id], ...
             ['This file is mandatory for optimization purposes, ', ...
              'because it describes the minimal values of ', ...
              'the digesters initial state on the plant. ', ...
              'Create the file by hand. See the documentation.'], setting);

  varargout{myentry_pos('digester_state_min')}= digester_state_min;

  if exist('n_fermenter', 'var')
    checkDimensionOfVariable( digester_state_min, ...
                              [biogas.ADMstate.dim_state, n_fermenter], ...
                              ['digester_state_min_', plant_id] );
  end
  
else
  %return;
end


%%
% load digester_state_max

if nargout >= myentry_pos('digester_state_max') && find_entry('digester_state_max')

  digester_state_max= load_file(['digester_state_max_', plant_id], ...
             ['This file is mandatory for optimization purposes, ', ...
              'because it describes the maximal values of ', ...
              'the digesters initial state on the plant. ', ...
              'Create the file by hand. See the documentation.'], setting);

  varargout{myentry_pos('digester_state_max')}= digester_state_max;

  if exist('n_fermenter', 'var')
    checkDimensionOfVariable( digester_state_max, ...
                              [biogas.ADMstate.dim_state, n_fermenter], ...
                              ['digester_state_max_', plant_id] );
  end
  
else
  %return;
end


%%
% load params_min

if nargout >= myentry_pos('params_min') && find_entry('params_min')

  % if you don't want to optimize the parameter of the digesters, then
  % set params_min= params_max= your optimal parameter set, 
  % using the two files. 
  params_min= load_file(['params_min_', plant_id], ...
             ['This file is mandatory for optimization purposes, ', ...
              'because it describes the minimal values of ', ...
              'the digesters ADM1 parameters on the plant. ', ...
              'Create the file by hand. See the documentation.'], setting);

  varargout{myentry_pos('params_min')}= params_min;

  %% TODO
  %checkDimensionOfVariable( params_min, [37, n_fermenter] );

else
  %return;
end


%%
% load digester_state_max

if nargout >= myentry_pos('params_max') && find_entry('params_max')

  params_max= load_file(['params_max_', plant_id], ...
             ['This file is mandatory for optimization purposes, ', ...
              'because it describes the maximal values of ', ...
              'the digesters ADM1 parameters on the plant. ', ...
              'Create the file by hand. See the documentation.'], setting);

  varargout{myentry_pos('params_max')}= params_max;

  %% TODO
  %checkDimensionOfVariable( params_max, [37, n_fermenter] );

else
  %return;
end


%%
% load substrate_eq

if nargout >= myentry_pos('substrate_eq') && find_entry('substrate_eq')

  % linear equality constraints for the substrate flow 
  try

      substrate_eq= load_file(['substrate_eq_', plant_id, '.mat'], ...
                              [], plant_id);

  catch ME
  
      disp('No equality constraints for substrates found.');
      disp(ME.message);
      substrate_eq= [];

  end

  varargout{myentry_pos('substrate_eq')}= substrate_eq;

  if ~isempty(substrate_eq) && exist('n_substrate', 'var') && exist('n_fermenter', 'var')
      checkDimensionOfVariable( substrate_eq, [size(substrate_eq, 1), ...
                                n_fermenter*n_substrate + 1], ...
                                ['substrate_eq_', plant_id, '.mat'] );
  end

else
  %return;
end


%%
% load substrate_ineq

if nargout >= myentry_pos('substrate_ineq') && find_entry('substrate_ineq')
    
  % linear inequality constraints for the substrate flow 
  % Gülle Bonus
  %
  % Erklärung zum Gülle Bonus:
  %
  % Gülle >= 0,3 * ( Summe aller Substrate )
  %
  % -0.7 Gülle + 0.3 ( Summe restlicher Substrate ) <= 0
  %
  % In der Form Ax <= b
  %
  % b= 0;
  %
  % A= -0.7 für Gülle und 0.3 für den Rest, hier ein liegender Vektor 
  %
  try

      substrate_ineq= load_file(['substrate_ineq_', plant_id, '.mat'], ...
                                [], plant_id);

  catch ME

      disp('No inequality constraints for substrates found.');
      disp(ME.message);
      substrate_ineq= [];

  end

  varargout{myentry_pos('substrate_ineq')}= substrate_ineq;

  if ~isempty(substrate_ineq) && exist('n_substrate', 'var') && exist('n_fermenter', 'var')
      checkDimensionOfVariable( substrate_ineq, [size(substrate_ineq, 1), ...
                                n_fermenter*n_substrate + 1], ...
                                ['substrate_ineq_', plant_id, '.mat'] );
  end

else
  %return;
end


%%
% load fitness_params

if nargout >= myentry_pos('fitness_params') && find_entry('fitness_params')

  %% TODO - hier muss bald fitness_params_...xml geladen werden
  
  searchfile= get_path2xml_configfile(plant_id, 'fitness_params_%s.xml', setting);
  
  try                   
    fitness_params= biooptim.fitness_params(searchfile);
  catch ME
    warning('MATLAB:load:couldNotReadFile', ...
           ['The file %s', ...
            ' does not exist. ', 'This file is mandatory for optimization purposes, ', ...
             'because it contains some parameters needed inside ', ...
             'the fitness function to evaluate the individual. ', ...
             'Create the file by hand. See the documentation'], searchfile);
          
    rethrow(ME);      
  end
  
%   fitness_params= load_file(['fitness_params_', plant_id], ...
%              ['This file is mandatory for optimization purposes, ', ...
%               'because it contains some parameters needed inside ', ...
%               'the fitness function to evaluate the individual. ', ...
%               'Create the file by hand. See the documentation.'], ...
%               setting);

  varargout{myentry_pos('fitness_params')}= fitness_params;

  checkDimensionOfVariable( fitness_params, [1, 1], ...
                            ['fitness_params_', plant_id] );

else
  %return;
end


%%
% load equilibria

if nargout >= myentry_pos('equilibria') && find_entry('equilibria')

  equilibria= load_file(['equilibriaInitPop_', plant_id], ...
         ['This file is mandatory for optimization purposes when you ', ...
          'want to specify an initial population, because it ', ...
          'contains the initial population. You can create this ', ...
          'file using the function getInitPopOfEquilibria. When you ', ... 
          'do not want to specify an initial population, then set the ', ...
          'corresponding parameter to 0 or []. See the documentation.'], ...
          setting);

  if ~isempty(equilibria)
      assignin('base', 'equilibria', equilibria);
  end

  varargout{myentry_pos('equilibria')}= equilibria;

  checkDimensionOfVariable( equilibria, [1, size(equilibria, 2)], ...
                            ['equilibriaInitPop_', plant_id] );

else
  %return;
end

%%



%%
%
function pos= entry_pos(entry, file_names)

[maxi, pos]= max(strcmp(entry, file_names));

%%


