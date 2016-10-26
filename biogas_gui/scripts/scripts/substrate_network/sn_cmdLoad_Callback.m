%% sn_cmdLoad_Callback
% Executes on button press in cmdLoad.
%
function sn_cmdLoad_Callback(hObject, eventdata, handles)
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
                      fullfile( getConfigPath(), 'substrate_network_plantID.mat') );

%%

if ~isempty(FileName) && ~isa(FileName, 'double')
  
  %%

  handles= sn_clear_gui(handles);

  %%

  substrate_network= load( fullfile(PathName, FileName) );

  %%
  
  if isfield(substrate_network, 'substrate_network')

    %%
    
    set(handles.lblPath,     'String', PathName);
    set(handles.lblFilename, 'String', FileName);

    substrate_network= substrate_network.substrate_network;

    handles.substrate_network= substrate_network;

    %%
    
    handles= sn_createNetworkPanel(handles);

  else

    errordlg('It seems to be that you have not load a valid substrate_network file!');

  end

  %%

  guidata(hObject, handles);

  %%
  
end

%%


