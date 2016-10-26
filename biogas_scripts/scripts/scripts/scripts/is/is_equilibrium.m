%% is_equilibrium
% Check if argument is an equilibrium struct
%
function is_equilibrium(argument, argument_number)
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
% do not check argument_number, is already done in checkArgument

%%

checkArgument(argument, 'equilibrium', 'struct', argument_number);

%%
% do further checks 

fields= {'fermenter', 'hydraulic_delay', 'fitness', ...
         'network_flux', 'network_flux_string'};

if any(~(isfield(argument, fields)))
  
  disp('The given argument: ')
  disp(argument)
  error('The given argument is not an equilibrium struct!');
  
end

%%


