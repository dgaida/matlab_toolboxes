%% btnChangeFlux_nmpc_Callback
% Executes on button press in btnChangeFlux_nmpc.
%
function btnChangeFlux_nmpc_Callback(hObject, eventdata, handles)
% hObject    handle to btnChangeFlux_nmpc (see GCBO)
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

set_input_stream_min_max({handles.model_path}, 'WindowStyle', 'modal');

%%

handles= nmpc_callActualizeGUI(handles);

%%

guidata(hObject, handles);

%%


