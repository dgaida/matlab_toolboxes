%% sn_cmdLoadSubstrate_Callback
% Executes on button press in cmdLoadSubstrate.
%
function sn_cmdLoadSubstrate_Callback(hObject, eventdata, handles)
%% Release: 1.6

% hObject    handle to cmdLoadSubstrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

[FileName, PathName]= uigetfile('*.xml', [], ...
                      fullfile( getConfigPath(), ...
                      ['substrate_', char(handles.plant.id), '.xml'] ));

%%

if ~isempty(FileName) && ~isa(FileName, 'double')
  
  %%

  handles= sn_clear_gui(handles);

  %%
  
  substrate= biogas.substrates( fullfile(PathName, FileName) );

  %%
  
  if substrate.getNumSubstratesD() > 0

    %substrate= substrate.substrate;

    handles.substrate= substrate;

    set(handles.lblSubstrateFilename, 'String', FileName);

    %%

    set(handles.lblPath,     'String', '');
    set(handles.lblFilename, 'String', '');

    %%

    set(handles.cmdLoad, 'enable', 'on');
    set(handles.cmdNew,  'enable', 'on');
    set(handles.cmdSave, 'enable', 'off');

    %%

    %set(handles.panNetwork, 'Title', char(plant.name));

    %%

    set(handles.cmdLoad, 'ToolTipString', ...
        sprintf('Load substrate_network_%s.mat belonging to plant %s!', ...
        char(handles.plant.id), char(handles.plant.name)));

    set(handles.cmdNew, 'ToolTipString', ...
        sprintf('Create new substrate_network belonging to plant %s!', ...
        char(handles.plant.name)));

    set(handles.cmdSave, 'ToolTipString', ...
        sprintf('Save the substrate_network belonging to plant %s!', ...
        char(handles.plant.name)));

    %%

    try

      substrate_network_file= ...
                  sprintf('substrate_network_%s.mat', char(handles.plant.id));

      substrate_network= load_file( fullfile(PathName, substrate_network_file) );

      set(handles.lblPath,     'String', PathName);
      set(handles.lblFilename, 'String', substrate_network_file);

      handles.substrate_network= substrate_network;

      %%

      handles= sn_createNetworkPanel(handles);

    catch ME

    end

  else

    errordlg('It seems to be that you have not load a valid substrate file!');

  end

  %%

end

%%

guidata(hObject, handles);

%%


