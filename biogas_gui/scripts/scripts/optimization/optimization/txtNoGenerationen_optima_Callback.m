%% txtNoGenerationen_optima_Callback
% Callback of text field txtNoGenerationen_optima
%
function txtNoGenerationen_optima_Callback(hObject, eventdata, handles)
%% Release: 1.3

% hObject    handle to txtNoGenerationen_optima (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtNoGenerationen_optima as text
%        str2double(get(hObject,'String')) returns contents of txtNoGenerationen_optima as a double

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

estimatedtime= str2double( get(handles.txtNoGenerationen_optima,'String') ) * ...
               str2double( get(handles.txtPopSize_optima,'String') ) * 0.5;

estimatedtime_h= fix(estimatedtime / 60);
estimatedtime_min= round(estimatedtime - estimatedtime_h * 60);
           
set(handles.lblRestTime, 'String', sprintf('%i h : %i min', ...
                         estimatedtime_h, estimatedtime_min));

%%


