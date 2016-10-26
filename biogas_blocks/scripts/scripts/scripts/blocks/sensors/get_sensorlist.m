%% get_sensorlist
% Get list of sensor ids of sensors object
%
function sensorlist= get_sensorlist(varargin)
%% Release: 1.4

%%

error( nargchk(0, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 1 && ~isempty(varargin{1})
  sensors= varargin{1};
  is_sensors(sensors, 1);
else
  %% TODO
  % für gummersbach erstellen ist vielleicht nicht immer toll
  sensors= create_sensor_network('gummersbach');
  dispMessage('Warning: This is the sensors object for plant gummersbach.', mfilename);
end

%%

sensorIDs= sensors.getIDs();

%%

sensorlist= conv_Array2cell(sensorIDs);

%%


