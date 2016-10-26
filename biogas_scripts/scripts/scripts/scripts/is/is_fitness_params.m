%% is_fitness_params
% Check if argument is an biooptim.fitness_params C# object
%
function is_fitness_params(argument, argument_number)
%% Release: 1.4

%%

global IS_DEBUG;

if isempty(IS_DEBUG) || ~IS_DEBUG
  return;
end

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% do not check argument_number, is already done in checkArgument

%%

checkArgument(argument, 'fitness_params', 'biooptim.fitness_params', argument_number);

%%


