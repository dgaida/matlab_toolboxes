%% txtNoGenerationen_nmpc_Callback
% Callback of text field txtNoGenerationen_nmpc
%
function txtNoGenerationen_nmpc_Callback(hObject, eventdata, handles)
% hObject    handle to txtNoGenerationen_nmpc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtNoGenerationen_nmpc as text
%        str2double(get(hObject,'String')) returns contents of txtNoGenerationen_nmpc as a double
          
%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if ~isstruct(handles)
  error(['The 3rd parameter handles must be of type struct, ', ...
         'but is of type ', class(handles), '!']);
end

%%

estimatedtime= ( 125 + str2double( get(handles.txtPopSize_nmpc, 'String') )* ...
                   str2double( get(handles.txtNoGenerationen_nmpc, 'String') ) * 30 * ...
                   str2double( get(handles.N_edit, 'String') ) )/60; % minutes

estimatedtime_h= fix( estimatedtime / 60 ); % hours
estimatedtime_min= round( estimatedtime - estimatedtime_h * 60); % minutes
           
set(handles.lblRestTime, 'String', sprintf('%i h : %i min', ...
                         estimatedtime_h, estimatedtime_min));

%%

set( handles.text22, 'ForegroundColor', [1, 0, 0]);

%%


