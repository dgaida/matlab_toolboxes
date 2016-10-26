%% is_plant_id
% Check if argument is a plant_id. Id of a biogas plant. 
%
function is_plant_id(argument, argument_number)
%% Release: 1.5

%%

global IS_DEBUG;

if isempty(IS_DEBUG) || ~IS_DEBUG
  return;
end

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(argument, 'plant_id', 'char', argument_number);

%%


