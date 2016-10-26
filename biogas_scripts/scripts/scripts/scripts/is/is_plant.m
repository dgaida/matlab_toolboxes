%% is_plant
% Check if argument is a biogas.plant object
%
function is_plant(argument, argument_number)
%% Release: 1.9

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

checkArgument(argument, 'plant', 'biogas.plant', argument_number);

%%


