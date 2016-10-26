%% cmdAddSubstrate_Callback
% Executes on button press in cmdAddSubstrate of <gui_substrate.html
% gui_substrate>. 
%
function cmdAddSubstrate_Callback(hObject, eventdata, handles)
%% Release: 1.5

% hObject    handle to cmdAddSubstrate (see GCBO)
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
  
  if handles.substrate.getNumSubstratesD() == 0
        
    %%
    % create a new substrate structure
    
    handles= newsubstrate(handles, substrate_id_name);
    
  else
   
    %%
    %
    
    substrate_id= char(substrate_id_name{1}); 
    
    %%
    
    if biogas.substrates.contains(handles.substrate, substrate_id)

      errordlg('This substrate id already exists! Try another one!', ...
               'Substrate ID conflict!');
      return;

    end

    %%
    % check for special characters

    str = regexprep(substrate_id, '[^a-z0-9_]', '');

    if ~strcmp(substrate_id, str)
      errordlg(['A substrate id may only contain lowercase alphanumerical ', ...
               'elements and ''_''! Please try another one!'], ...
               'Substrate ID not valid!');
      return;
    end
  
    %%
    
    handles.substrate.addSubstrate( biogas.substrate(substrate_id, ...
                                                     char(substrate_id_name{2})) );

    n_substrate= handles.substrate.getNumSubstratesD();

    %%
    
    substratelist= get( handles.listSubstrate, 'String' );

    substratelist= [substratelist; ...
      {char(handles.substrate.get(substrate_id).get_param_of_s('name'))}];

    set( handles.listSubstrate, 'String', substratelist );

    %%
    
    set( handles.listSubstrate, 'Value', n_substrate );
    
    %%
    
    handles= call_listSubstrate(handles);
    
  end

end

guidata(hObject, handles);

%%


