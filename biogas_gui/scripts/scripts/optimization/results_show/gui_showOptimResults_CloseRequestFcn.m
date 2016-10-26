%% gui_showOptimResults_CloseRequestFcn
% Executes when user attempts to close gui_showOptimResults.
%
function gui_showOptimResults_CloseRequestFcn(hObject, eventdata, handles)
%% Release: 1.4

% hObject    handle to gui_showOptimResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%
%delete(hObject);

%return;

%saveDataToFile(handles);

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

if isfield(handles, 'axes2')
    delete(handles.axes2);
end
    
if isfield(handles, 'axes3')
    delete(handles.axes3);
end

% Hint: delete(hObject) closes the figure
delete(hObject);

%%


