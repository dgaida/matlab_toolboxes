%% popPlants_Callback
% Executes on selection change in popPlants of <gui_plant.html gui_plant>
%
function popPlants_Callback(hObject, eventdata, handles)
%% Release: 1.6

% hObject    handle to popPlants (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popPlants
% contents as cell array 
%        contents{get(hObject,'Value')} returns selected item from popPlants

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

% Construct a questdlg with three options
choice= questdlg('If you proceed, all unsaved changes will get lost! Proceed?', ...
                 'Load a plant file', 'Yes','No','No');

if isempty(choice)
  return;
end

% Handle response
switch choice
  case 'No'
    return;
end

%%

if get(handles.popPlants, 'Value') == 1
  uicontrol(hObject)
  return
end

%%

[plant_ids, plant_names, path_config_mat, path_to_file]= ...
    findExistingPlants([], [], get(handles.popPlants, 'Value') - 1 );

% erste zeile enthält: "choose plant"
plant_id= deblank( char( plant_ids{ ...
                            get(handles.popPlants,'Value') - 1 ...
                                       } ) );

handles.p_path= path_to_file;
handles.p_file= sprintf('plant_%s.xml', plant_id );

%%

handles= gui_plant_delete_fnc(handles);

%%

handles= gui_plant_init_gui(handles, 1, plant_id);

%%

uicontrol(hObject);

% Update handles structure
guidata(hObject, handles);

%%


