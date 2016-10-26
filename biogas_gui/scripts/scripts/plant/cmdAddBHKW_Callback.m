%% cmdAddBHKW_Callback
% Executes on button press in cmdAddBHKW of <gui_plant.html gui_plant>.
%
function cmdAddBHKW_Callback(hObject, eventdata, handles)
%% Release: 1.8

% hObject    handle to cmdAddBHKW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

bhkw_id_name= inputdlg({'Insert the ID of the new chp:', ...
                        'Insert the name of the new chp:'}, ...
                        'Add a new chp');

%%

if ~isempty(bhkw_id_name) && ~isa(bhkw_id_name, 'double')
    
  bhkw_id= char(bhkw_id_name{1});                   

  if handles.workspace.plant.containsCHP(bhkw_id)

    errordlg('This CHP id already exists! Try another one!', ...
             'CHP ID conflict!');
    return;

  end
  
  %%
  % check for special characters
  
  str = regexprep(bhkw_id, '[^a-z0-9_]', '');

  if ~strcmp(bhkw_id, str)
    errordlg(['A CHP id may only contain lowercase alphanumerical ', ...
             'elements and ''_''! Please try another one!'], ...
             'CHP ID not valid!');
    return;
  end
  
  %% 
  % add new bhkw
  handles= newbhkw(handles, bhkw_id_name);

end

guidata(hObject, handles);

%%


