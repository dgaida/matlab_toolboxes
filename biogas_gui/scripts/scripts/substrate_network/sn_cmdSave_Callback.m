%% sn_cmdSave_Callback
% Executes on button press in cmdSave of <gui_substrate_network.html
% gui_substrate_network>. 
%
function sn_cmdSave_Callback(hObject, eventdata, handles)
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
                      sprintf('substrate_network_%s.mat', char(handles.plant.id)) ));

%%
%

if ~isempty(FileName) && ~isa(FileName, 'double')

  %%

  n_fermenter= handles.plant.getNumDigestersD();
  n_substrate= handles.substrate.getNumSubstratesD();

  for ifermenter= 1:n_fermenter

    for isubstrate= 1:n_substrate

      value= get(handles.txtDistribution(isubstrate, ifermenter), 'String');

      handles.substrate_network(isubstrate, ifermenter)= str2double(value);

    end

  end

  %%

  substrate_network= handles.substrate_network;

  save(fullfile(PathName, FileName), 'substrate_network');

  set(handles.lblPath, 'String', PathName);%fullfile(PathName, FileName));
  set(handles.lblFilename, 'String', FileName);

end

%%

guidata(hObject, handles);

%%


