%% is_datasource_type
% Check if argument is a datasource type, defined by datasourcetypes.mat
%
function is_datasource_type(argument, argument_number)
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

datasourcetypes= load_file('datasourcetypes.mat'); % contains extern, file, workspace, modelworkspace

validatestring(argument, datasourcetypes, mfilename, 'datasource_type', argument_number);

%%


