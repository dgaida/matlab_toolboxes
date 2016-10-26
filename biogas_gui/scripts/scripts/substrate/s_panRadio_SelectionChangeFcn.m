%% s_panRadio_SelectionChangeFcn
% Executes when selected object is changed in panRadio of <gui_substrate.html
% gui_substrate>. 
%
function s_panRadio_SelectionChangeFcn(hObject, eventdata, handles)
%% Release: 1.8

% hObject    handle to the selected object in panRadio 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

radTag= get(eventdata.NewValue, 'Tag');

%%

if strcmp(radTag, 'radRohParams')
    
  set(handles.panCSBfracts, 'Visible', 'off');
  set(handles.panRohParams, 'Visible', 'on');

elseif strcmp(radTag, 'radCSBfracts')

  set(handles.panCSBfracts, 'Visible', 'on');
  set(handles.panRohParams, 'Visible', 'off');

  index= get(handles.listSubstrate, 'Value');

  liststring= get(handles.listSubstrate, 'String');

  %%

  if ~isempty(liststring) && isfield(handles, 'substrate')

    mySubstrate= handles.substrate.get(index);

    Rohprotein= str2double(get(handles.txtRohprotein, 'String'));
    Rohfaser=   str2double(get(handles.txtRohfaser,   'String'));
    Rohfett=    str2double(get(handles.txtRohfett,    'String'));
    NDF=        str2double(get(handles.txtNDF,        'String'));
    ADF=        str2double(get(handles.txtADF,        'String'));
    ADL=        str2double(get(handles.txtADL,        'String'));

    mySubstrate.set_params_of( 'RP',  Rohprotein );
    mySubstrate.set_params_of( 'RF',  Rohfaser );
    mySubstrate.set_params_of( 'RL',  Rohfett );
    mySubstrate.set_params_of( 'NDF', NDF );
    mySubstrate.set_params_of( 'ADF', ADF );
    mySubstrate.set_params_of( 'ADL', ADL );

    set(handles.txtfCH_XC, 'String', ...
        numerics.math.round_float( mySubstrate.get_param_of_d('fCh_Xc'), 3));
    set(handles.txtfPR_XC, 'String', ...
        numerics.math.round_float( mySubstrate.get_param_of_d('fPr_Xc'), 3));
    set(handles.txtfLI_XC, 'String', ...
        numerics.math.round_float( mySubstrate.get_param_of_d('fLi_Xc'), 3));  
    set(handles.txtfSI_XC, 'String', ...
        numerics.math.round_float( mySubstrate.get_param_of_d('fSI_Xc'), 3));
    set(handles.txtfXI_XC, 'String', ...
        numerics.math.round_float( mySubstrate.get_param_of_d('fXI_Xc'), 3));
    set(handles.txtfXP_XC, 'String', ...
        numerics.math.round_float( mySubstrate.get_param_of_d('fXp_Xc'), 3));        

  end

  guidata(hObject, handles);

end

%%


