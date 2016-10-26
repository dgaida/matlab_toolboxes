%% set_volumeflow_type
% Set volumeflow of substrate feed block either to user, random or const
%
function set_volumeflow_type(fcn, type)
%% Release: 1.3

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check arguments

checkArgument(fcn, 'fcn', 'char', '1st');

is_volumeflow_type(type, 2);

%%

dispMessage(sprintf('Setting the volumeflow type of substrates to %s.', type), mfilename);

%%

blocks= char(find_system(fcn, 'FollowLinks', 'on', 'LookUnderMasks', 'all', ...
             'Name', 'Substrate Mixer (Digester)'));
  
%%

values_sys_adm1xp= get_param_error('MaskValues', blocks);

values_sys_adm1xp{1,1}= type;

%%

set_param_tc('MaskValues', values_sys_adm1xp, blocks);

%%


