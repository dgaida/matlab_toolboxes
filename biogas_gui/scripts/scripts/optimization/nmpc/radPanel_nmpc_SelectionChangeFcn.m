%% radPanel_nmpc_SelectionChangeFcn
% Executes when selected object is changed in radPanel_nmpc.
%
function radPanel_nmpc_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in radPanel_nmpc 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
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

radTag= get(eventdata.NewValue, 'Tag');

%%

if strcmp(radTag, 'radSubstrate')
    
  %%
  
  set(handles.panSubstrate,    'Visible', 'on');
  set(handles.panPumpFlux,     'Visible', 'off');
  set(handles.panOptOptions,   'Visible', 'off');

  set(handles.btnChangeFlux_nmpc, 'Visible', 'on');

  set(handles.sliderSubstrate, 'Enable',  'off');

elseif strcmp(radTag, 'radPumpFlux')

  %%
  
  set(handles.panSubstrate,    'Visible', 'off');
  set(handles.panPumpFlux,     'Visible', 'on');
  set(handles.panOptOptions,   'Visible', 'off');

  set(handles.btnChangeFlux_nmpc, 'Visible', 'on');

  set(handles.sliderSubstrate, 'Enable',  'off');
  
else

  %%
  
  set(handles.panSubstrate,    'Visible', 'off');
  set(handles.panPumpFlux,     'Visible', 'off');
  set(handles.panOptOptions,   'Visible', 'on');

  set(handles.btnChangeFlux_nmpc, 'Visible', 'off');

  set(handles.sliderSubstrate, 'Enable',  'off');
  
end

%%


