%% cmdOpenSubstrateStructure_Callback
% Executes on button press in cmdOpenSubstrateStructure of
% <gui_substrate.html |gui_substrate|>.
%
function cmdOpenSubstrateStructure_Callback(hObject, eventdata, handles)
%% Release: 1.5

% hObject    handle to cmdOpenSubstrateStructure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

[FileName, PathName]= uigetfile('*.xml', [], ...
                      fullfile( getConfigPath(), 'substrate_plantID.xml' ) );

%%

if ~isempty(FileName) && ~isa(FileName, 'double')
  
  %%
  
  substrate= biogas.substrates( fullfile(PathName, FileName) );

  set(handles.lblPath, 'String', fullfile(PathName, FileName));

  handles.substrate= substrate;

  %%

  handles= after_substrate_loaded(handles);

  %%

  guidata(hObject, handles);

end

%%


