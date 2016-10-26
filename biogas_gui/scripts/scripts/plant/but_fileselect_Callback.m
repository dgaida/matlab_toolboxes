%% but_fileselect_Callback
% Executes on button press in but_fileselect of <gui_plant.html gui_plant>
%
function but_fileselect_Callback(hObject, eventdata, handles)
%% Release: 1.4

% hObject    handle to but_fileselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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

%load new plant file
[handles.p_file handles.p_path]= uigetfile( '*.xml', [], ...
                       fullfile( getConfigPath(), 'plant_plantID.xml' ) );

if handles.p_file == 0
  errordlg('Please select a valid file!','Bad Input','modal')
  uicontrol(hObject)
  return
end

clear plant;

%delete the GUI fields from the previos files

%%

handles= gui_plant_delete_fnc(handles);

%%

handles= gui_plant_init_gui(handles);

%%

uicontrol(hObject);

% Update handles structure
guidata(hObject, handles);

%%


