%% init_biogas_plant_mdl
% Initialize the biogas plant model.
%
function init_biogas_plant_mdl(varargin)
%% Release: 0.9

%%

error( nargchk(0, 1, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
%

if nargin >= 1 && ~isempty(varargin{1}),
  isOptimModel= varargin{1};
  is0or1(isOptimModel, 'isOptimModel', 1);
else
  isOptimModel= 0;
end


%%

if ~isempty(bdroot)
  hws= get_param(bdroot, 'modelworkspace');
else
  hws= [];
end

%%

if ~isempty(hws)
    
  %%
  % read out block values

  [plant_id, DEBUG, showGUIs, appendDATA]= get_biogas_block_params();

  %% TODO - delete in the future
  deltatime= 12/24;

  %%
  % load mat files

  try
    [substrate, plant, substrate_network, plant_network]= ...
        load_biogas_mat_files(plant_id);
  catch ME
    disp(ME.message);
    rethrow(ME);
  end

  %%

  if isOptimModel
    fitness_params= load_biogas_mat_files(plant_id, [], 'fitness_params');
  end

  %%

  volumeflowtypes= load_file('volumeflowtypes', ...
      ['This file is mandatory, because it defines the', ...
       ' types of volumeflow of the substrates!']);


  gas2bhkwsplittypes= load_file('gas2bhkwsplittypes', ...
      ['This file is mandatory, because it defines how the gained ', ...
       'biogas in the fermenters is given to the bhkw''s.']);

  initstatetypes= load_file('initstatetypes', ...
      ['This file is mandatory, because it defines from which states ', ...
       'the state dependend blocks may start!']);

  datasourcetypes= load_file('datasourcetypes', ...
      ['This file is mandatory, because it defines from where the ', ...
       'data can be read.']);

  %%
  %
  
  try
    %% 
    
    path2xml= get_path2xml_configfile(plant_id, 'sensors_%s.xml');
    
    sensors= biogas.sensors(path2xml, plant);
  catch ME
    rethrow(ME);
  end

  %% TODO
  % delete
  
%   for iplant= 1:plant.getNumDigestersD()
% 
%     fermenter_id= char( plant.getDigesterID(iplant) );
% 
%     % verbrauchte Energie für den Transport des Eingangs-Substrates in den
%     % spezifizierten Fermenter
%     %energy.(fermenter_id).used.pump(1:1 + 1,1)= 0;
% 
%     intvars.adm1_linearized.(fermenter_id).A= 0;
%     intvars.adm1_linearized.(fermenter_id).B= 0;
%     intvars.adm1_linearized.(fermenter_id).x_prime= 0;
%     intvars.adm1_linearized.(fermenter_id).C= 0;
% 
%     %%
% 
%   end


  %%

  plant= init_ADMparams_from_mat_file(plant);

  
  %%
  % Sprache
  %% TODO
  % muss das eine globale Variable sein, wenn die tr Funktion genutzt wird
  %
  clear global language;

  global language;

  language= 'english';
  %language= 'german';

  %%
  
  substrate_ids= conv_List2cell(substrate.ids)';
  digester_ids= conv_List2cell(plant.myDigesters.ids)';
  
  %%
  % setzen der Variablen in dem Model Workspace

  try
    
    %%
    
    hws.clear();    % clear the model workspace
    
    %%
    
    hws.assignin('plant', plant);
    hws.assignin('substrate', substrate);
    
    hws.assignin('sensors', sensors);
    
    %%
   
    hws.assignin('substrate_ids', substrate_ids);
     
    hws.assignin('digester_ids', digester_ids);
    
    %%
    
    hws.assignin('volumeflowtypes', volumeflowtypes);
    hws.assignin('gas2bhkwsplittypes', gas2bhkwsplittypes);
    hws.assignin('initstatetypes', initstatetypes);
    hws.assignin('datasourcetypes', datasourcetypes);
    
    hws.assignin('substrate_network', substrate_network);
    hws.assignin('plant_network', plant_network);
    
    if isOptimModel
      hws.assignin('fitness_params', fitness_params);
    end
    
    hws.assignin('DEBUG', DEBUG);
    
    hws.assignin('showGUIs', showGUIs);
    hws.assignin('appendDATA', appendDATA);
    
    %% TODO - delete
    hws.assignin('deltatime', deltatime);
    
  catch ME

    disp('init_biogas_plant_mdl: Could not set in modelworkspace!');

    if getMATLABVersion() < 711
      rethrow(ME);
    end

  end

  %end


  %% TODO
  % delete 
  
%   plant_model= biogasM.simulator(...energy, 
%                                  intvars);

  %%

%   try
%     assignin('base', [bdroot, '_data'], plant_model);
%   catch ME
%     disp('Could not set plant_model in workspace!');
%     rethrow(ME);
%   end


  %%

  set_param(gcb, 'LinkStatus', 'none');

  %%

  set_param(gcs, 'CloseFcn', 'biogas_model_closefcn();');

  %%
  % set the solver
  
  set_solver([], [], sensors.sampling_time);%deltatime);

  %%

  % da die Callback Funktionen im Base Workspace ausgeführt werden,
  % müssen die Variablen auch im Base Workspace gesetzt werden.
  % Wichtig, wird die Bibliothek geladen, werden die Variablen nicht in
  % den base Workspace geladen, das verhindert ein Überschreiben von
  % Variablen, wenn zuerst das Modell und dann die Bibliothek geladen
  % wird, was beim laden eines Modells passiert, welches
  % Bibliotheksblöcke beinhaltet

  % Damit beim Öffnen der Bibliothek per Hand nicht lauter
  % Fehlermeldungen erscheinen da Variablen fehlen, wird in der Load
  % Callback Function Variablen in den Workspace gelesen, wenn diese noch
  % nicht existieren.

  %%

  if getMATLABVersion() >= 711

    %%
    assignin('base', 'plant', plant);
    assignin('base', 'substrate', substrate);

    assignin('base', 'sensors', sensors);

    %%

    assignin('base', 'substrate_ids', substrate_ids);
    
    assignin('base', 'digester_ids', digester_ids);

    %%

    assignin('base', 'volumeflowtypes', volumeflowtypes);
    assignin('base', 'gas2bhkwsplittypes', gas2bhkwsplittypes);
    assignin('base', 'initstatetypes', initstatetypes);
    assignin('base', 'datasourcetypes', datasourcetypes);

    if isOptimModel
      assignin('base', 'fitness_params', fitness_params);
    end

    assignin('base', 'substrate_network', substrate_network);
    assignin('base', 'plant_network', plant_network);

    assignin('base', 'DEBUG', DEBUG);

    assignin('base', 'showGUIs', showGUIs);
    assignin('base', 'appendDATA', appendDATA);

  end
    
end

%%


