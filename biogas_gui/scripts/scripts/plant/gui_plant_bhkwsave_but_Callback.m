%% gui_plant_bhkwsave_but_Callback
% Callback of button bhkwsave, bhkwcancel and bhkwreset on panel for bhkw
% on <gui_plant.html |gui_plant|> 
%
function gui_plant_bhkwsave_but_Callback(hObject, eventdata, handles)
%% Release: 1.5

% hObject    handle to cmdSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

handles= guidata(hObject);

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

userdata= get(hObject, 'userdata');

%%

% dann wurde ok gedrückt, sonst cancel
if userdata == 1
    
  % saving the inputs in the variables
  b_name_new= get(handles.b_edit.b_name, 'String');
  handles.workspace.plant.setCHPParam(handles.b_id_select, 'name', b_name_new);

  b_power_new= str2double(get(handles.b_edit.b_power,'String'));
  handles.workspace.plant.setCHPParam(handles.b_id_select, 'Pel', b_power_new);

  b_eta_new= str2double(get(handles.b_edit.b_eta,'String'));
  handles.workspace.plant.setCHPParam(handles.b_id_select, 'eta_el', b_eta_new);

  b_eta_therm_new= str2double(get(handles.b_edit.b_eta_therm,'String'));
  handles.workspace.plant.setCHPParam(handles.b_id_select, 'eta_therm', b_eta_therm_new);

  % reset
elseif userdata == 2
    
  set(handles.b_edit.b_name, 'String', ...
      char(handles.workspace.plant.getCHPName(handles.b_id_select)));

  set(handles.b_edit.b_power, 'String', ...
      handles.workspace.plant.getCHPParam(handles.b_id_select, 'Pel'));

  set(handles.b_edit.b_eta, 'String', ...
      handles.workspace.plant.getCHPParamD(handles.b_id_select, 'eta_el'));

  set(handles.b_edit.b_eta_therm, 'String', ...
      handles.workspace.plant.getCHPParamD(handles.b_id_select, 'eta_therm'));

end

%%

if userdata ~= 2

  %%
  %delete fields on the right side after saving file
  if isfield (handles, 'btext')

%     if isfield(handles,'frame2')
%         delete(handles.frame2)
%         handles=rmfield(handles,'frame2');
%     end
    
    b_vars= fieldnames(handles.btext);
    b_vars_count= size(b_vars,1);
    
    for i=1:b_vars_count
      b_del= b_vars(i);
      b_del= char(b_del);

      if ishandle(handles.btext.(b_del))
        delete(handles.btext.(b_del));
        handles.btext= rmfield(handles.btext, b_del);
      end
    end
    
    handles= rmfield(handles, 'btext');
    clear b_del
  end

  if isfield (handles, 'b_edit')
    b_vars=fieldnames(handles.b_edit);
    b_vars_count=size(b_vars,1);
    
    for i=1:b_vars_count
      b_del=b_vars(i);
      b_del=char(b_del);

      if ishandle(handles.b_edit.(b_del))
        delete(handles.b_edit.(b_del));
        handles.b_edit= rmfield(handles.b_edit, b_del);
      end
    end
    
    handles= rmfield(handles, 'b_edit');
    clear f_del
  end

  if isfield(handles, 'frame1_bhkw')
     set(handles.frame1_bhkw,'Visible','off');
%         delete(handles.frame1)
%         handles=rmfield(handles,'frame1');
  end
    
  handles= gui_plant_enable_elements(handles, 'on');    


end

try
  guidata(hObject, handles);
catch ME
  rethrow(ME);
end

%%


