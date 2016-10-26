%% is_substrate
% Check if argument is a biogas.substrates object
%
function is_substrate(argument, argument_number)
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

checkArgument(argument, 'substrate', 'biogas.substrates', argument_number);

%%


