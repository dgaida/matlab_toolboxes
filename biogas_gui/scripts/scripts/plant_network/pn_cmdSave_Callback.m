%% pn_cmdSave_Callback
% Executes on button press in cmdSave of <gui_plant_network.html
% gui_plant_network>. 
%
function pn_cmdSave_Callback(hObject, eventdata, handles)
%% Release: 1.8

% hObject    handle to cmdSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%
%

[FileName, PathName]= uiputfile('*.mat', [], ...
                      fullfile( getConfigPath(), char(handles.plant.id), ...
                      sprintf('plant_network_%s.mat', char(handles.plant.id)) ));

%%
%

if ~isempty(FileName) && ~isa(FileName, 'double')

  %%

  n_fermenter= handles.plant.getNumDigestersD();

  for ifermenter= 1:n_fermenter

    for ifermenterIn= 1:n_fermenter + 1

      value= get(handles.togConnect(ifermenter, ifermenterIn), 'value');

      handles.plant_network(ifermenter, ifermenterIn)= value;

    end

  end

  %%

  plant_network= handles.plant_network;

  save(fullfile(PathName, FileName), 'plant_network');

  set(handles.lblPath,     'String', PathName);
  set(handles.lblFilename, 'String', FileName);
    
end

%%

guidata(hObject, handles);

%%


