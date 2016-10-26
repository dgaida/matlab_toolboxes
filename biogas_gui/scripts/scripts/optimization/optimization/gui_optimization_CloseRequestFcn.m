%% gui_optimization_CloseRequestFcn
% Executes when user attempts to close gui_optimization.
%
function gui_optimization_CloseRequestFcn(hObject, eventdata, handles)
%% Release: 1.4

% hObject    handle to gui_optimization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

%delete(hObject);

%return;

%saveDataToFile(handles);

%%

if isfield(handles, 'axes2')
  try
    delete(handles.axes2);
  catch ME
    disp(ME.message);
  end
end

if isfield(handles, 'axes3')
  try
    delete(handles.axes3);
  catch ME
    disp(ME.message);
  end
end

% Hint: delete(hObject) closes the figure
delete(hObject);

%%


