%% gui_plant_pumpsave_but_Callback
% Callback of button pumpsave, pumpcancel and pumpreset on panel for pump
% on <gui_plant.html |gui_plant|> 
%
function gui_plant_pumpsave_but_Callback(hObject, eventdata, handles)
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
%   p_id_new= get(handles.p_edit.pid, 'String');
%   handles.workspace.plant.setPumpParam(handles.p_id_select, 'id', p_id_new);

  p_h_lift_new= str2double(get(handles.p_edit.phlift,'String'));
  handles.workspace.plant.setPumpParam(handles.p_id_select, 'h_lift', p_h_lift_new);

  p_d_horz_new= str2double(get(handles.p_edit.pdhorz,'String'));
  handles.workspace.plant.setPumpParam(handles.p_id_select, 'd_horizontal', p_d_horz_new);

  p_eta_new= str2double(get(handles.p_edit.peta,'String'));
  handles.workspace.plant.setPumpParam(handles.p_id_select, 'eta', p_eta_new);

  % reset
elseif userdata == 2
    
%   set(handles.p_edit.pid, 'String', ...
%       char(handles.workspace.plant.getPumpParamS(handles.p_id_select, 'id')));

  set(handles.p_edit.phlift, 'String', ...
      handles.workspace.plant.getPumpParam(handles.p_id_select, 'h_lift'));

  set(handles.p_edit.pdhorz, 'String', ...
      handles.workspace.plant.getPumpParam(handles.p_id_select, 'd_horizontal'));

  set(handles.p_edit.peta, 'String', ...
      handles.workspace.plant.getPumpParamD(handles.p_id_select, 'eta'));

end

%%

if userdata ~= 2

  %%
  %delete fields on the right side after saving file
  if isfield (handles, 'ptext')

%     if isfield(handles,'frame2')
%         delete(handles.frame2)
%         handles=rmfield(handles,'frame2');
%     end
    
    p_vars= fieldnames(handles.ptext);
    p_vars_count= size(p_vars,1);
    
    for i=1:p_vars_count
      p_del= p_vars(i);
      p_del= char(p_del);

      if ishandle(handles.ptext.(p_del))
        delete(handles.ptext.(p_del));
        handles.ptext= rmfield(handles.ptext, p_del);
      end
    end
    
    handles= rmfield(handles, 'ptext');
    clear p_del
  end

  if isfield (handles, 'p_edit')
    p_vars=fieldnames(handles.p_edit);
    p_vars_count=size(p_vars,1);
    
    for i=1:p_vars_count
      p_del=p_vars(i);
      p_del=char(p_del);

      if ishandle(handles.p_edit.(p_del))
        delete(handles.p_edit.(p_del));
        handles.p_edit= rmfield(handles.p_edit, p_del);
      end
    end
    
    handles= rmfield(handles, 'p_edit');
    clear p_del
  end

  if isfield(handles, 'frame1_pump')
     set(handles.frame1_pump,'Visible','off');
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


