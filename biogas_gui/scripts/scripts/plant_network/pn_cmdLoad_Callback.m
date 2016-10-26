%% pn_cmdLoad_Callback
% Executes on button press in cmdLoad.
%
function pn_cmdLoad_Callback(hObject, eventdata, handles)
%% Release: 1.6

% hObject    handle to cmdLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

[FileName, PathName]= uigetfile('*.mat', [], ...
                       fullfile( getConfigPath(), ...
                        sprintf('plant_network_%s.mat', char(handles.plant.id)) ) );

%%

if ~isempty(FileName) && ~isa(FileName, 'double')
  
  %%

  handles= pn_clear_gui(handles);

  %%

  plant_network= load( fullfile(PathName, FileName) );

  %%

  if isfield(plant_network, 'plant_network')

    %%

    set(handles.lblPath,     'String', PathName);
    set(handles.lblFilename, 'String', FileName);

    plant_network= plant_network.plant_network;

    handles.plant_network= plant_network;

    %%

    handles= pn_createNetworkPanel(handles);

  else

    errordlg('It seems to be that you have not load a valid plant_network file!');

  end

  %%

  guidata(hObject, handles);

  %%

end

%%


