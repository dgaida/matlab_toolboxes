%% popOptMethod_Callback
% Executes on selection change in popOptMethod.
%
function popOptMethod_Callback(hObject, eventdata, handles)
%% Release: 1.5

% hObject    handle to popOptMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popOptMethod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popOptMethod

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

handles.optParams= [];

switch ( get(handles.popOptMethod, 'Value') )
  case 1
    method= 'GA';

    handles.optParams.p1= 1;
    handles.optParams.p2= 1;

  case 2
    method= 'PSO';

    handles.optParams.p1= 1;
    handles.optParams.p2= 1;

  case 3
    method= 'ISRES';
  case 4
    method= 'DE';
  case 5
    method= 'CMAES';
  case 6
    method= 'PS';
  case 7
    method= 'SMS-EMOA';
end


%%

no_generations= str2double( get(handles.txtNoGenerationen_optima, 'String') );
popSize=        str2double( get(handles.txtPopSize_optima,        'String') );

%%

if strcmp(method, 'PS')
   
  set(handles.txtPopSize_optima, 'Visible', 'off');
  set(handles.lblPopGroesse, 'Visible', 'off');

  set(handles.txtNoGenerationen_optima, 'String', no_generations * popSize / 2);

else

  % macht PS Einstellung rückgängig
  if strcmp( get(handles.txtPopSize_optima, 'Visible'), 'off' )
      set(handles.txtNoGenerationen_optima, 'String', ...
          no_generations / popSize * 2);
  end

  set(handles.txtPopSize_optima, 'Visible', 'on');
  set(handles.lblPopGroesse, 'Visible', 'on');

end

%%

guidata(hObject, handles);

%%


