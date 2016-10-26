%% is_initstate
% Check if argument is an initstate struct
%
function is_initstate(argument, argument_number)
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

checkArgument(argument, 'initstate', 'struct', argument_number);

%%
% do further checks 

fields= {'fermenter', 'hydraulic_delay'};    % weitere Felder ergänzen

if any(~(isfield(argument, fields)))
  
  disp('The given argument: ')
  disp(argument)
  error('The given argument is not an initstate struct!');
  
end

%%


