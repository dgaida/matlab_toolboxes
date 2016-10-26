%% btnNewPlant_Callback
% Executes on button press in btnNewPlant of <gui_plant.html gui_plant>.
%
function btnNewPlant_Callback(hObject, eventdata, handles)
%% Release: 1.4

% hObject    handle to btnNewPlant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

plant_id_name= inputdlg({'Insert the ID of the new plant:', ...
                        'Insert the name of the new plant:'}, ...
                        'Create a new plant structure');

%%
%

if ~isempty(plant_id_name) && ~isa(plant_id_name, 'double')

  %%
  % check th id first
  
  plant_id= char(plant_id_name{1});
  
  str = regexprep(plant_id, '[^a-z]', '');

  if ~strcmp(plant_id, str)
    errordlg(['A plant id may only contain lowercase alphabetic elements! ', ...
             'Please try another one!'], ...
             'Plant ID not valid!');
    return;
  end
  
  %% 
  % a new plant with no digesters and no bhkws
  handles.workspace.plant= biogas.plant();

  handles.workspace.plant.set_params_of('id',   char(plant_id_name{1}));
  handles.workspace.plant.set_params_of('name', char(plant_id_name{2}));

  handles.p_path= [];
  handles.p_file= [];

  %%

  handles= gui_plant_delete_fnc(handles);

  %%

  handles= gui_plant_init_gui(handles, 0);

  %%

  handles= gui_plant_enable_elements(handles, 'on');

end

guidata(hObject, handles);

%%


