%% pn_cmdNew_Callback
% Executes on button press in cmdNew of <gui_plant_network.html
% gui_plant_network>. 
%
function pn_cmdNew_Callback(hObject, eventdata, handles)
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
%

handles= pn_clear_gui(handles);

%%

if isfield(handles, 'plant')
    
  %%
  
  n_fermenter= handles.plant.getNumDigestersD();

  handles.plant_network= zeros(n_fermenter, n_fermenter + 1);

  set(handles.lblPath,     'String', '');
  set(handles.lblFilename, 'String', '');

  %%
  
  handles= pn_createNetworkPanel(handles);

  %%

  guidata(hObject, handles);

  %%
  
end

%%


