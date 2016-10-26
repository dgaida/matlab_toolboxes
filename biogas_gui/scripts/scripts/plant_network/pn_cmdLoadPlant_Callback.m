%% pn_cmdLoadPlant_Callback
% Executes on button press in cmdLoadPlant of <gui_plant_network.html
% gui_plant_network>
%
function pn_cmdLoadPlant_Callback(hObject, eventdata, handles)
%% Release: 1.6

% hObject    handle to cmdLoadPlant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

[FileName, PathName]= uigetfile('*.xml', [], ...
                       fullfile( getConfigPath(), 'plant_plantID.xml' ) );

%%

if ~isempty(FileName) && ~isa(FileName, 'double')
  
  %%

  handles= pn_clear_gui(handles);

  %%

  plant= biogas.plant( fullfile(PathName, FileName) );

  %%
  
  if ~strcmp(char(plant.id), '')

    %%
    
    handles.plant= plant;

    set(handles.lblPlantFilename, 'String', FileName);

    %%

    set(handles.lblPath,     'String', '');
    set(handles.lblFilename, 'String', '');

    %%

    set(handles.cmdLoad, 'enable', 'on');
    set(handles.cmdNew,  'enable', 'on');
    set(handles.cmdSave, 'enable', 'off');

    %%

    set(handles.panNetwork, 'Title', char(plant.name));

    %%

    set(handles.cmdLoad, 'ToolTipString', ...
        sprintf('Load plant_network_....mat belonging to plant %s!', ...
        char(plant.name)));

    set(handles.cmdNew, 'ToolTipString', ...
        sprintf('Create new plant_network belonging to plant %s!', ...
        char(plant.name)));

    set(handles.cmdSave, 'ToolTipString', ...
        sprintf('Save the plant_network belonging to plant %s!', ...
        char(plant.name)));

    %%
    
    try

      plant_network_file= ...
                  sprintf('plant_network_%s.mat', char(plant.id));

      %%
      
      if exist(fullfile(PathName, plant_network_file), 'file')    
        
        %%
        
        plant_network= load_file( fullfile(PathName, plant_network_file) );

        set(handles.lblPath,     'String', PathName);
        set(handles.lblFilename, 'String', plant_network_file);

        handles.plant_network= plant_network;

        %%

        handles= pn_createNetworkPanel(handles);

      end

    catch ME
      %rethrow(ME);
    end

  else

    errordlg('It seems to be that you have not load a valid plant file!');

  end

  %%

  guidata(hObject, handles);

end

%%


