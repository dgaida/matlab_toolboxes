%% pn_togConnectCallback
% Callback of connect toggle buttons of <gui_plant_network.html
% gui_plant_network> 
%
function pn_togConnectCallback(hObject, eventdata, handles)
%% Release: 1.7

%%

error( nargchk(1, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

tooltip= get(hObject, 'ToolTipString');

if get(hObject, 'Value')
  set(hObject, 'String', 'Connected');

  tooltip= strrep(tooltip, 'connect', 'disconnect');
  tooltip= strrep(tooltip, 'with', 'from');
else
  set(hObject, 'String', 'Disconnected');

  tooltip= strrep(tooltip, 'disconnect', 'connect');
  tooltip= strrep(tooltip, 'from', 'with');
end

%%

set(hObject, 'ToolTipString', tooltip);

%%


