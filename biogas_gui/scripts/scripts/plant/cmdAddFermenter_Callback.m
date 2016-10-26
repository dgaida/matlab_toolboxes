%% cmdAddFermenter_Callback
% Executes on button press in cmdAddFermenter of <gui_plant.html gui_plant>
%
function cmdAddFermenter_Callback(hObject, eventdata, handles)
%% Release: 1.8

% hObject    handle to cmdAddFermenter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

fermenter_id_name= inputdlg({'Insert the ID of the new fermenter:', ...
                             'Insert the name of the new fermenter:'}, ...
                             'Add a new fermenter');

%%

if ~isempty(fermenter_id_name) && ~isa(fermenter_id_name, 'double')
    
  fermenter_id= char(fermenter_id_name{1});                   

  if handles.workspace.plant.containsDigester(fermenter_id)

    errordlg('This fermenter id already exists! Try another one!', ...
             'Fermenter ID conflict!');
    return;

  end
  
  %%
  % check for special characters
  
  str = regexprep(fermenter_id, '[^a-z0-9_]', '');

  if ~strcmp(fermenter_id, str)
    errordlg(['A fermenter id may only contain lowercase alphanumerical ', ...
             'elements and ''_''! Please try another one!'], ...
             'Fermenter ID not valid!');
    return;
  end
  
  %% 
  % add new fermenter
  handles= newfermenter(handles, fermenter_id_name);

end

guidata(hObject, handles);

%%


