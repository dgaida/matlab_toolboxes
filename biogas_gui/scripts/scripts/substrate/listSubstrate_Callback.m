%% listSubstrate_Callback
% Executes on selection change in listSubstrate.
%
function listSubstrate_Callback(hObject, eventdata, handles)
%% Release: 1.6

% hObject    handle to listSubstrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listSubstrate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listSubstrate

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%
%

if isfield(handles, 'lastIndex')
  index= handles.lastIndex;
else
  index= -1;
end

%%
% if a substrate is selected and we are in editing mode then save the last
% selected substrate

if ~isempty(index) && index ~= -1 && (get(handles.cmdEditSubstrate, 'Value') == 1)

  handles= saveChangeInSubstrate(handles, index);

end

%%

handles.lastIndex= get(hObject, 'Value');

%%

handles= call_listSubstrate(handles);

%%

guidata(hObject, handles);

%%


