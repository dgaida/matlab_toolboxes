%% sn_cmdNew_Callback
% Executes on button press in cmdNew of <gui_substrate_network.html
% gui_substrate_network>. 
%
function sn_cmdNew_Callback(hObject, eventdata, handles)
%% Release: 1.6

% hObject    handle to cmdNew (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

handles= sn_clear_gui(handles);

%%

if isfield(handles, 'plant')
    
  %%
  
  n_fermenter= handles.plant.getNumDigestersD();
  n_substrate= handles.substrate.getNumSubstratesD();

  handles.substrate_network= [ones(n_substrate, 1), ...
                              zeros(n_substrate, n_fermenter - 1)];

  set(handles.lblPath,     'String', '');
  set(handles.lblFilename, 'String', '');

  %%
  
  handles= sn_createNetworkPanel(handles);

  %%

  guidata(hObject, handles);

  %%
  
end

%%


