%% cmdNewSubstrateStructure_Callback
% Executes on button press in cmdNewSubstrateStructure.
%
function cmdNewSubstrateStructure_Callback(hObject, eventdata, handles)
%% Release: 1.6

% hObject    handle to cmdNewSubstrateStructure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

substrate_id_name= inputdlg({'Insert the ID of the new substrate:', ...
                             'Insert the name of the new substrate:'}, ...
                             'Add a new substrate');

%%

if ~isempty(substrate_id_name) && ~isa(substrate_id_name, 'double')

  %%
  
  handles= newsubstrate(handles, substrate_id_name);

  set(handles.lblPath, 'String', '');

end

%%

guidata(hObject, handles);

%%


