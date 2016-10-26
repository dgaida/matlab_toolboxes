%% cmdAddPump_Callback
% Executes on button press in cmdAddPump of <gui_plant.html gui_plant>.
%
function cmdAddPump_Callback(hObject, eventdata, handles)
%% Release: 1.8

% hObject    handle to cmdAddPump (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

pump_start_destiny= inputdlg({'Insert the start unit (substratemix or digester ID) of the new pump:', ...
                        'Insert the destiny unit (storagetank or digester ID) of the new pump:'}, ...
                        'Add a new pump');

%%

if ~isempty(pump_start_destiny) && ~isa(pump_start_destiny, 'double')
    
  pump_id= [char(pump_start_destiny{1}), '_', char(pump_start_destiny{2})];                   

  if handles.workspace.plant.containsPump(pump_id)

    errordlg('This pump id already exists! Try another one!', ...
             'Pump ID conflict!');
    return;

  end
  
  %%
  % check for special characters
  
  str = regexprep(pump_id, '[^a-z0-9_]', '');

  if ~strcmp(pump_id, str)
    errordlg(['A pump id may only contain lowercase alphanumerical ', ...
             'elements and ''_''! Please try another one!'], ...
             'Pump ID not valid!');
    return;
  end
  
  %% 
  % add new pump
  handles= newpump(handles, pump_start_destiny);

end

guidata(hObject, handles);

%%


