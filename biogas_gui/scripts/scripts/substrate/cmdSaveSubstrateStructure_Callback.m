%% cmdSaveSubstrateStructure_Callback
% Executes on button press in cmdSaveSubstrateStructure of <gui_substrate.html
% gui_substrate>. 
%
function cmdSaveSubstrateStructure_Callback(hObject, eventdata, handles)
%% Release: 1.8

% hObject    handle to cmdSaveSubstrateStructure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

%% 
% falls plantId in handles rein geschrieben würde, dann könnte man hier den
% dateinamen generieren, so ist auch gut
% wenn datei existiert, da von ihr geladen wurde
if exist(get(handles.lblPath, 'String'), 'file') 
  [FileName, PathName]= uiputfile('*.xml', [], ...
                      fullfile( get(handles.lblPath, 'String') ) );
else
  [FileName, PathName]= uiputfile('*.xml', [], ...
                      fullfile( getConfigPath(), 'substrate_plantID.xml' ) );
end

%%

if ~isempty(FileName) && ~isa(FileName, 'double')

  %%
  % wenn wir gerade im editiermodus waren, dann eben noch evtl. änderungen
  % in substratstruktur speichern
  if (get(handles.cmdEditSubstrate, 'Value') == 1)
    
    index= get(handles.listSubstrate, 'Value');

    handles= saveChangeInSubstrate(handles, index);

  end

  handles.substrate.saveAsXML( fullfile(PathName, FileName) );

  set(handles.lblPath, 'String', fullfile(PathName, FileName));
    
end

%%

guidata(hObject, handles);

%%


