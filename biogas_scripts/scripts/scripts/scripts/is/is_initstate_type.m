%% is_initstate_type
% Check if argument is a initstate type, defined by initstatetypes.mat
%
function is_initstate_type(argument, argument_number)
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

isN(argument_number, 'argument_number', 2);

%%

initstatetypes= load_file('initstatetypes.mat'); % contains user, default, random

validatestring(argument, initstatetypes, mfilename, 'initstate_type', argument_number);

%%


