%% popOptMethod_nmpc_Callback
% Executes on selection change in popOptMethod_nmpc.
%
function popOptMethod_nmpc_Callback(hObject, eventdata, handles)
% hObject    handle to popOptMethod_nmpc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popOptMethod_nmpc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popOptMethod_nmpc

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if ~isstruct(handles)
  error(['The 3rd parameter handles must be of type struct, ', ...
         'but is of type ', class(handles), '!']);
end

%%

handles.optParams= [];

switch ( get(handles.popOptMethod_nmpc, 'Value') )
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
end


%%

no_generations= str2double( get(handles.txtNoGenerationen_nmpc, 'String') );
popSize=        str2double( get(handles.txtPopSize_nmpc,        'String') );

%%

if strcmp(method, 'PS')
   
  set(handles.txtPopSize_nmpc, 'Visible', 'off');
  set(handles.lblPopGroesse, 'Visible', 'off');

  set(handles.txtNoGenerationen_nmpc, 'String', no_generations * popSize / 2);

else

  % macht PS Einstellung rückgängig
  if strcmp( get(handles.txtPopSize_nmpc, 'Visible'), 'off' )
      set(handles.txtNoGenerationen_nmpc, 'String', ...
          no_generations / popSize * 2);
  end

  set(handles.txtPopSize_nmpc, 'Visible', 'on');
  set(handles.lblPopGroesse, 'Visible', 'on');
    
end

%%

guidata(hObject, handles);

%%


