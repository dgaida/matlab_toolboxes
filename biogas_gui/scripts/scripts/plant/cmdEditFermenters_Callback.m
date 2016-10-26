%% cmdEditFermenters_Callback
% Callback of button cmdEditFermenters of <gui_plant.html |gui_plant|>
%
function cmdEditFermenters_Callback(hObject, eventdata, handles)
%% Release: 1.4

% hObject    handle to cmdEditFermenters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% neues Panel mit den Werten aus "Fermenter" erstellen

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%
%prevent change of bhkw or fermenter during editing
handles= gui_plant_enable_elements(handles, 'off');    


handles= gui_plant_createFermenterPanel(handles);

% Update handles structure
guidata(hObject, handles);

%%


