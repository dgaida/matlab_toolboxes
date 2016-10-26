%% gui_plant_init_gui
% Initialize <gui_plant.html |gui_plant|>, load plant structure
%
function handles= gui_plant_init_gui(handles, varargin)
%% Release: 1.4

%%

error( nargchk(1, 3, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

if nargin >= 2 && ~isempty(varargin{1})
  b_load_file= varargin{1};
  is0or1(b_load_file, 'b_load_file', 2);
else
  b_load_file= 1;
end

if nargin >= 3 && ~isempty(varargin{2})
  plant_id= varargin{2};
  checkArgument(plant_id, 'plant_id', 'char', '3rd');
else
  %% TODO
  % plant_id not used!
  plant_id= [];
end

%%

checkArgument(handles, 'handles', 'struct', '1st');

%%

% display path and selected file
set(handles.lblplantfile, 'String', handles.p_file);
set(handles.lblPath,      'String', handles.p_path);

%%

if b_load_file
  % load variables and display values
  %if exist(handles.p_file, 'file') %~size(plantfilesearch,1) == 0

  try

    %[path_config_mat]= fileparts(which('plant_plantname.mat'));

    %% TODO: DEBUG
    handles.workspace.plant= biogas.plant( ...
        fullfile(handles.p_path, handles.p_file) );

%         handles.workspace.plant= load_file( ...
%                                     handles.p_file, [], plant_id );

      %handles.workspace.plant= s_plant;

  catch ME
  %else
    handles.workspace= 0;

    warning('Could not load file!');

  end
  
end

%%
%check if "plant" is available
if ~isfield(handles.workspace, 'plant') || ...
       ~isa(handles.workspace.plant, 'biogas.plant')
    
  %%
  
  errordlg('No plant variable found!', 'Bad Input', 'modal');

  set(handles.text_pid, 'String', 'no data');

  if isfield(handles, 'listDigesters')
    delete(handles.listDigesters);
    handles= rmfield(handles.listDigesters);
  end

  % list for bhkws
  if isfield(handles, 'listPlants')
    delete(handles.listPlants);
    handles= rmfield(handles.listPlants);
  end

  % list for pumps
  if isfield(handles, 'listPumps')
    delete(handles.listPumps);
    handles= rmfield(handles.listPumps);
  end
  
  handles.listDigesters= uicontrol('Style', 'listbox', ...'String','no data',...
      'Units', 'characters', 'Position', [15.8 26.0 20.2 5.3], ...
      'Parent', handles.uipanel2);
  handles.listPlants= uicontrol('Style', 'listbox', ...'String','no data',...
      'Units', 'characters', 'Position', [15.8 18.43 20.2 5.3], ...
      'Parent', handles.uipanel2);
  handles.listPumps= uicontrol('Style', 'listbox', ...'String','no data',...
      'Units', 'characters', 'Position', [15.8  10.67 20.2 5.3], ...
      'Parent', handles.uipanel2);

  set(handles.edit_Tout,'String','no data','enable','off')
  %set(handles.edit_Hch4,'String','no data','enable','off')
  set(handles.edit_name,'String','no data','enable','off')
  set(handles.cmdEditFermenters, 'enable', 'off');
  set(handles.cmdEditBHKWs,      'enable', 'off');
  set(handles.cmdEditPump,       'enable', 'off');
  set(handles.cmdSave,           'enable', 'off');

  %%

  handles= gui_plant_delete_fnc(handles);

  %%

  %uicontrol(hObject)

  %return
  
else % plant is inside workspace
  
  set(handles.cmdEditFermenters, 'enable', 'on');
  set(handles.cmdEditBHKWs,      'enable', 'on');
  set(handles.cmdEditPump,       'enable', 'on');
  set(handles.cmdSave,           'enable', 'on');

  %display plant ID
  set(handles.text_pid, 'String', char(handles.workspace.plant.id));

  %Listbox with Fermenter IDs
  if handles.workspace.plant.getNumDigestersD() > 0

    n_fermenters= handles.workspace.plant.getNumDigestersD();

    fermenterlist= cell(n_fermenters, 1);

    for ifermenter= 1:n_fermenters

      fermenterlist{ifermenter}= ...
              char( handles.workspace.plant.getDigesterName( ifermenter ) );

    end

    handles.listDigesters= uicontrol('Style', 'listbox', 'String', ...
        fermenterlist,...
        'Units', 'characters', 'Position', [15.8 26.0 20.2 5.3], ...
        'Parent', handles.frmPlantControl);
  
  else
    
    handles.listDigesters= uicontrol('Style', 'listbox', ...
        ...'String','No Fermenters!',...
        'Units', 'characters', 'Position', [15.8 26.0 20.2 5.3], ...
        'Parent', handles.frmPlantControl);
      
  end

  %%
  
  if handles.workspace.plant.getNumCHPsD() > 0

    n_bhkws= handles.workspace.plant.getNumCHPsD();

    bhkwlist= cell(n_bhkws, 1);

    for ibhkw= 1:n_bhkws

      bhkwlist{ibhkw}= char( handles.workspace.plant.getCHPName(ibhkw) );

    end

    %Listbox with BHKW IDs
    handles.listPlants= uicontrol('Style', 'listbox', 'String', ...
        bhkwlist,...
        'Units', 'characters', 'Position', [15.8 18.43 20.2 5.3], ...
        'Parent', handles.frmPlantControl);
      
  else
    
      handles.listPlants= uicontrol('Style', 'listbox', ...%'String', ...
          ...%'No BHKWs!',...
          'Units', 'characters', 'Position', [15.8 18.43 20.2 5.3], ...
          'Parent', handles.frmPlantControl);
        
  end

  %% 
  % add pumps to listPumps
  
  if handles.workspace.plant.getNumPumpsD() > 0

    n_pumps= handles.workspace.plant.getNumPumpsD();

    pumplist= cell(n_pumps, 1);

    for ipump= 1:n_pumps

      pumplist{ipump}= char( handles.workspace.plant.getPumpID(ipump) );

    end

    %Listbox with pump IDs
    handles.listPumps= uicontrol('Style', 'listbox', 'String', ...
        pumplist,...
        'Units', 'characters', 'Position', [15.8 10.67 20.2 5.3], ...
        'Parent', handles.frmPlantControl);
      
  else
    
      handles.listPumps= uicontrol('Style', 'listbox', ...%'String', ...
          'Units', 'characters', 'Position', [15.8 10.67 20.2 5.3], ...
          'Parent', handles.frmPlantControl);
        
  end
  
  %%
  % Values for Tout, name and Hch4
  set(handles.edit_Tout,'String',double(handles.workspace.plant.Tout.Value),...
      'enable','on' )
  %set(handles.edit_Hch4,'String',handles.workspace.plant.bhkw.Hch4,...
   %   'enable','off')
  set(handles.edit_name,'String',char(handles.workspace.plant.name),...
      'enable','on')
    
end

%%


