%% btnPath_Callback
% Executes on button press in btnPath.
%
function btnPath_Callback(hObject, eventdata, handles)
%% Release: 1.1

% hObject    handle to btnPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd')

%%
% search and default Selection of "plant" file to edit

if isempty(handles.model_path)
  handles.model_path= uigetdir(pwd);
else
  handles.model_path= uigetdir(handles.model_path);
end


%%

if ~isa(handles.model_path, 'double')

  set(handles.lblPath, 'String', handles.model_path);

  handles= searchForModelFile(handles);

  if isfield(handles, 'plantID') && ~isempty( handles.plantID )
    handles= callActualizeGUI(handles);
  end

else

  set(handles.lblPath, 'String', '');
  handles.model_path= [];

end

%%

guidata(hObject, handles);

%%


