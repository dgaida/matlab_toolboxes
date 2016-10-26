%% cmdSave_Callback
% Executes on button press in cmdSave of <gui_plant.html gui_plant>
%
function cmdSave_Callback(hObject, eventdata, handles)
%% Release: 1.7

% hObject    handle to cmdSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%
%

Tout_new= str2double( get(handles.edit_Tout, 'String') );
name_new=             get(handles.edit_name, 'String');

%%

if isnan(Tout_new)
  
  errordlg('You must enter a numeric value for T', 'Bad Input', 'modal')
  uicontrol(hObject)
  return
  
else
  
  handles.workspace.plant.set_params_of('Tout', Tout_new);
  handles.workspace.plant.set_params_of('name', name_new);

  %%
  
  if isempty(handles.p_path) || isempty(handles.p_file)

    [handles.p_file, handles.p_path]= uiputfile('*.xml', [], ...
                                      sprintf('plant_%s.xml', ...
                                      get(handles.text_pid, 'String')));

    if handles.p_file == 0 % cancel
      uicontrol(hObject)
      return;
    end

    set(handles.lblPath,      'String', handles.p_path);
    set(handles.lblplantfile, 'String', handles.p_file);

  end

  %%
  
  handles.workspace.plant.saveAsXML(fullfile(handles.p_path, handles.p_file));

  msgbox(sprintf('Successfully saved the plant to file %s!', ...
          fullfile(handles.p_path, handles.p_file)), 'Save plant');

  guidata(hObject, handles);

end

%%


