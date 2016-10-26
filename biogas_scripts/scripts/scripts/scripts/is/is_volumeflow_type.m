%% is_volumeflow_type
% Check if argument is a volumeflow type, defined by volumeflowtypes.mat
%
function is_volumeflow_type(argument, argument_number)
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

volumeflowtypes= load_file('volumeflowtypes.mat'); % contains user, const, random

validatestring(argument, volumeflowtypes, mfilename, 'vol_type', argument_number);

%%


