%% radPanel_SelectionChangeFcn
% Executes when selected object is changed in radPanel.
%
function radPanel_SelectionChangeFcn(hObject, eventdata, handles)
%% Release: 1.5

% hObject    handle to the selected object in radPanel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

radTag= get(eventdata.NewValue, 'Tag');

%%

if strcmp(radTag, 'radSubstrate')
    
  %%
  
  set(handles.panSubstrate,  'Visible', 'on');
  set(handles.panPumpFlux,   'Visible', 'off');
  set(handles.panOptOptions, 'Visible', 'off');

  set(handles.btnChangeFlux_optima, 'Visible', 'on');

elseif strcmp(radTag, 'radPumpFlux')

  %%
  
  set(handles.panSubstrate,  'Visible', 'off');
  set(handles.panPumpFlux,   'Visible', 'on');
  set(handles.panOptOptions, 'Visible', 'off');

  set(handles.btnChangeFlux_optima, 'Visible', 'on');

else

  %%
  
  set(handles.panSubstrate,  'Visible', 'off');
  set(handles.panPumpFlux,   'Visible', 'off');
  set(handles.panOptOptions, 'Visible', 'on');

  set(handles.btnChangeFlux_optima, 'Visible', 'off');

end

%%


