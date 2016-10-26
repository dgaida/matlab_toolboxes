%% newsubstrate
% Creates a new substrate structure containing one substrate with the given
% id and name and updates the gui. 
%
function handles= newsubstrate(handles, substrate_id_name)
%% Release: 1.6

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%
% check input params

checkArgument(handles, 'handles', 'struct', '1st');

if ~iscellstr(substrate_id_name) || numel(substrate_id_name) ~= 2
  error(['The 2nd parameter substrate_id_name must be a 2dim cell of strings, ', ...
         'but is of type ', class(substrate_id_name), '!']);
end

%%

handles.substrate= biogas.substrates( ...
                       biogas.substrate( char(substrate_id_name{1}), ...
                                         char(substrate_id_name{2}) ) );

%%
    
handles= after_substrate_loaded(handles);

%%


