%% cmdEditSubstrate_Callback
% Executes on button press in cmdEditSubstrate of <gui_substrate.html
% gui_substrate>. 
%
function cmdEditSubstrate_Callback(hObject, eventdata, handles)
%% Release: 1.8

% hObject    handle to cmdEditSubstrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

value= get(handles.cmdEditSubstrate, 'Value');

if value == 1.0   % edit modus wird eingeschaltet
  enable= 'on';

  set(hObject, 'String', 'Substrat sperren');
  set(hObject, 'TooltipString', 'Ausgewähltes Substrat sperren');

else              % edit modus wird gerade ausgeschaltet
  enable= 'off';

  set(hObject, 'String', 'Substrat editieren');
  set(hObject, 'TooltipString', 'Ausgewähltes Substrat editieren');
    
end

%%

set(handles.txtpHvalue,    'Enable', enable);
set(handles.txtCSBtotal,   'Enable', enable);
set(handles.txtCSBfilter,  'Enable', enable);
set(handles.txtAlkalinity, 'Enable', enable);
                     
set(handles.txtoTS,        'Enable', enable);
set(handles.txtNH4,        'Enable', enable);                     
set(handles.txtTS,         'Enable', enable);
set(handles.txtT,          'Enable', enable);
set(handles.txtDichte,     'Enable', enable);

set(handles.txtEssig,      'Enable', enable);
set(handles.txtPropion,    'Enable', enable);
set(handles.txtButter,     'Enable', enable);
set(handles.txtValerian,   'Enable', enable);

set(handles.txtRohprotein, 'Enable', enable);
set(handles.txtRohfett,    'Enable', enable);
set(handles.txtRohfaser,   'Enable', enable);
set(handles.txtNDF,        'Enable', enable);
set(handles.txtADF,        'Enable', enable);
set(handles.txtADL,        'Enable', enable);

set(handles.txtCosts,      'Enable', enable);

set(handles.popSubstrateClass, 'Enable', enable);

%%

index= get(handles.listSubstrate, 'Value');
    
if (value == 0) % wird modus gerade ausgeschaltet, dann werden vorher evtl.
  % gemachte änderungen noch eben in dem substrate objekt gespeichert

  handles= saveChangeInSubstrate(handles, index);

end

%%

guidata(hObject, handles);

%%


