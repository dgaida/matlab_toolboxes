%% btnChangeFlux_optima_Callback
% Executes on button press on btnChangeFlux_optima.
%
function btnChangeFlux_optima_Callback(hObject, eventdata, handles)
%% Release: 1.5

% hObject    handle to btnChangeFlux_optima (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

set_input_stream_min_max({handles.model_path}, 'WindowStyle', 'modal');

%%

handles= optima_callActualizeGUI(handles);

%%

guidata(hObject, handles);

%%


