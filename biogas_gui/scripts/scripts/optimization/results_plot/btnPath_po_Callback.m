%% btnPath_po_Callback
% Executes on button press in btnPath_po.
%
function btnPath_po_Callback(hObject, eventdata, handles)
%% Release: 1.5

% hObject    handle to btnPath_po (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%
% search and default Selection of "plant" file to edit
if isempty(handles.model_path) || isnumeric(handles.model_path) %|| ...
           %handles.model_path == 0
  [filename, handles.model_path]= uigetfile(pwd, '*.mat');
else
  [filename, handles.model_path]= uigetfile(handles.model_path, '*.mat');
end

%%

if ~isa(handles.model_path, 'double')

  %%
  
  set(handles.lblPath, 'String', handles.model_path);

  handles.plantName= [];
  handles.fileName= filename;

  %%
  
  cd(handles.model_path);

  %%
  
  handles= po_callActualizeGUI(handles);

else
    
  set(handles.lblPath, 'String', '');
    
end

%%

guidata(hObject, handles);


%%


