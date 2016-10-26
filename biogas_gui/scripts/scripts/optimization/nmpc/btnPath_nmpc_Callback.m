%% btnPath_nmpc_Callback
% Executes on button press in btnPath_nmpc.
%
function btnPath_nmpc_Callback(hObject, eventdata, handles)
% hObject    handle to btnPath_nmpc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if ~isstruct(handles)
  error(['The 3rd parameter handles must be of type struct, ', ...
         'but is of type ', class(handles), '!']);
end

%%
% search and default Selection of "plant" file to edit
if isempty(handles.model_path) || handles.model_path == 0
  handles.model_path= uigetdir(pwd);
else
  handles.model_path= uigetdir(handles.model_path);
end

%%

if ~isa(handles.model_path, 'double')

  set(handles.lblPath, 'String', handles.model_path);

  s_files= what(handles.model_path);

  mdl_files= s_files.mdl;

  plant_id= [];

  %%
  
  for ifile= 1:size(mdl_files, 1)

    if regexpi(char(mdl_files(ifile,1)), 'plant_\w*.mdl', 'once')

      [t m]= regexpi(char(mdl_files(ifile,1)), 'plant_(\w+).*?.mdl', ...
                     'once', 'tokens', 'match');

      plant_id= char(t);

      break;

    end

  end

  %%
  
  if isempty( plant_id )

    errordlg('Konnte kein Simulationsmodell einer Anlage finden');

  else

    handles.plantID= plant_id;
    handles.plantName= [];

    cd(handles.model_path);

    %%
    
    handles= nmpc_callActualizeGUI(handles);

  end

else % no folder selected

  set(handles.lblPath, 'String', '');

end

%%

guidata(hObject, handles);

%%


