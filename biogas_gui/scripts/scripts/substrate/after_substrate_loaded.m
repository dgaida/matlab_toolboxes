%% after_substrate_loaded
% Updates the list for the substrates and calls <call_listSubstrate.html
% call_listSubstrate>. 
%
function handles= after_substrate_loaded(handles)
%% Release: 1.6

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%
% check input params

checkArgument(handles, 'handles', 'struct', '1st');

%%

substrate= handles.substrate;

n_substrate= substrate.getNumSubstratesD();

substratelist= cell(n_substrate, 1);

for isubstrate= 1:n_substrate

  substratelist{isubstrate}= ...
                char(substrate.get(isubstrate).get_param_of_s('name'));

end

%%

set( handles.listSubstrate, 'String', substratelist);

%%

handles= call_listSubstrate(handles);

%%

set(handles.cmdAddSubstrate,           'Enable', 'on');
set(handles.cmdDeleteSubstrate,        'Enable', 'on');
set(handles.cmdEditSubstrate,          'Enable', 'on');
set(handles.cmdSaveSubstrateStructure, 'Enable', 'on');

%%

handles.lastIndex= -1;

%%


