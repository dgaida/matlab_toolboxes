%% chk3D4Dplot_Callback
% Executes on button press in chk3D4Dplot.
%
function chk3D4Dplot_Callback(hObject, eventdata, handles)
%% Release: 1.2

% hObject    handle to chk3D4Dplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chk3D4Dplot

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

if (get(handles.chk3D4Dplot, 'Value'))
  set(handles.lst4Daxis, 'Visible', 'on');
  set(handles.lbl4Daxis, 'Visible', 'on');
else
  set(handles.lst4Daxis, 'Visible', 'off');
  set(handles.lbl4Daxis, 'Visible', 'off');
end

%%

handles= plot_xyz(handles);

%%

guidata(hObject, handles);

%%


