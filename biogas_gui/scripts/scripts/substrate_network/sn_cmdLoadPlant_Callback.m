%% sn_cmdLoadPlant_Callback
% Executes on button press in cmdLoadPlant of <gui_substrate_network.html
% gui_substrate_network>
%
function sn_cmdLoadPlant_Callback(hObject, eventdata, handles)
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
                      fullfile( getConfigPath(), 'plant_plantID.xml' ));

%%

if ~isempty(FileName) && ~isa(FileName, 'double')

  %%

  handles= sn_clear_gui(handles);

  %%
  
  plant= biogas.plant( fullfile(PathName, FileName) );

  %%
  
  if ~strcmp(char(plant.id), '')

    %plant= plant.plant;

    handles.plant= plant;

    set(handles.lblPlantFilename, 'String', FileName);

    %%

    set(handles.lblPath, 'String', '');
    set(handles.lblFilename, 'String', '');

    if isfield(handles, 'substrate');
      handles= rmfield(handles, 'substrate');
    end

    set(handles.lblSubstrateFilename, 'String', '');

    %%

    set(handles.cmdLoadSubstrate, 'enable', 'on');
    set(handles.cmdLoad, 'enable', 'off');
    set(handles.cmdNew, 'enable', 'off');
    set(handles.cmdSave, 'enable', 'off');

    %%

    set(handles.panNetwork, 'Title', char(plant.name));

    %%

    set(handles.cmdLoadSubstrate, 'ToolTipString', ...
        sprintf('Load substrate_%s.mat belonging to plant %s!', ...
        char(plant.id), char(plant.name)));

%         set(handles.cmdNew, 'ToolTipString', ...
%             sprintf('Create new plant_network belonging to plant %s!', ...
%             char(plant.name)));
%         
%         set(handles.cmdSave, 'ToolTipString', ...
%             sprintf('Save the plant_network belonging to plant %s!', ...
%             char(plant.name)));

    %%

    try

      substrate_file= sprintf('substrate_%s.xml', char(plant.id));

      substrate= biogas.substrates( fullfile(PathName, substrate_file) );

      set(handles.lblSubstrateFilename, 'String', substrate_file);

      %%

      set(handles.lblPath, 'String', '');
      set(handles.lblFilename, 'String', '');

      %%

      set(handles.cmdLoad, 'enable', 'on');
      set(handles.cmdNew, 'enable', 'on');
      set(handles.cmdSave, 'enable', 'off');

      %%

      %set(handles.panNetwork, 'Title', char(plant.name));

      %%

      set(handles.cmdLoad, 'ToolTipString', ...
          sprintf('Load substrate_network_....mat belonging to plant %s!', ...
          char(handles.plant.name)));

      set(handles.cmdNew, 'ToolTipString', ...
          sprintf('Create new substrate_network belonging to plant %s!', ...
          char(handles.plant.name)));

      set(handles.cmdSave, 'ToolTipString', ...
          sprintf('Save the substrate_network belonging to plant %s!', ...
          char(handles.plant.name)));

      handles.substrate= substrate;

      %%

      substrate_network_file= ...
                  sprintf('substrate_network_%s.mat', char(plant.id));

      %%
      
      if exist(fullfile(PathName, substrate_network_file), 'file')

        %%

        substrate_network= load_file( fullfile(PathName, substrate_network_file) );

        set(handles.lblPath, 'String', PathName);%fullfile(PathName, FileName));
        set(handles.lblFilename, 'String', substrate_network_file);

        handles.substrate_network= substrate_network;

        %%

        handles= sn_createNetworkPanel(handles);

      end

    catch ME

    end

  else

    errordlg('It seems to be that you have not load a valid plant file!');

  end

  %%

end

%%

guidata(hObject, handles);

%%


