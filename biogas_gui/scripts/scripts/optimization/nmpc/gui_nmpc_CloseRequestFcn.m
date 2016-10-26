%% gui_nmpc_CloseRequestFcn
% Executes when user attempts to close gui_nmpc.
%
function gui_nmpc_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to gui_nmpc (see GCBO)
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


