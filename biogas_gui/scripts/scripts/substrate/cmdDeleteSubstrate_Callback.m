%% cmdDeleteSubstrate_Callback
% Executes on button press in cmdDeleteSubstrate.
%
function cmdDeleteSubstrate_Callback(hObject, eventdata, handles)
%% Release: 1.6

% hObject    handle to cmdDeleteSubstrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

index= get(handles.listSubstrate, 'Value');

n_substrate= handles.substrate.getNumSubstratesD();

% handles.substrate wird direkt überschrieben
handles.substrate.deleteSubstrate(index);

%%
% update list

liststring= get(handles.listSubstrate, 'String');

index_list= true(1, n_substrate);

index_list(1,index)= 0;

liststring= liststring(index_list);

set(handles.listSubstrate, 'String', liststring);

%%

if index < n_substrate
  set(handles.listSubstrate, 'Value', index);
else
  set(handles.listSubstrate, 'Value', index - 1);
end

%%

handles= call_listSubstrate(handles);

%%

handles.lastIndex= -1;

if n_substrate <= 1

  set(handles.cmdDeleteSubstrate, 'Enable', 'off');
  set(handles.cmdEditSubstrate,   'Enable', 'off');
  
else

  set(handles.cmdDeleteSubstrate, 'Enable', 'on');
  set(handles.cmdEditSubstrate,   'Enable', 'on');

end

%%

guidata(hObject, handles);

%%


