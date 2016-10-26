%% is_sensors
% Check if argument is a biogas.sensors object
%
function is_sensors(argument, argument_number)
%% Release: 1.7

%%

global IS_DEBUG;

if isempty(IS_DEBUG) || ~IS_DEBUG
  return;
end

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% do not check arguments, is already done in checkArgument

%%

checkArgument(argument, 'sensors', 'biogas.sensors', argument_number);

%%


