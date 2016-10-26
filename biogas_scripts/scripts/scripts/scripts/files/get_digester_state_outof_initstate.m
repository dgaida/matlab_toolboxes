%% get_digester_state_outof_initstate
% Get digester state out of initstate.mat as double matrix
%
function x= get_digester_state_outof_initstate(initstate)
%% Release: 1.4

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

is_initstate(initstate, '1st');

%%

fields= fieldnames(initstate.fermenter);

%%
% 

x= zeros(biogas.ADMstate.dim_state, numel(fields));

%%

for ifield= 1:numel(fields)

  x(:, ifield)= initstate.fermenter.(fields{ifield}).user;
  
end

%%


