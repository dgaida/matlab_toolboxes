%% po_callActualizeGUI
% Calls the function <po_actualizeGui.html po_actualizeGui> 
%
function handles= po_callActualizeGUI(handles)
%% Release: 1.5

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');

%%

try
  handles= po_actualizeGui(handles);
catch ME
  rethrow(ME);
end

%%


