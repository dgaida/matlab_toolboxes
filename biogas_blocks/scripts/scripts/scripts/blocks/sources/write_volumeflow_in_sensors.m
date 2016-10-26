%% write_volumeflow_in_sensors
% Write (substrate) volumeflow in sensors object
%
function sensors= write_volumeflow_in_sensors(sensors, time, volumeflow, substrate_id)
%% Release: 1.0

%%

error( nargchk(4, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

is_sensors(sensors, '1st');
isRn(time, 'time', 2, '+');
isRn(volumeflow, 'volumeflow', 3, '+');
checkArgument(substrate_id, 'substrate_id', 'char', 4);

%%

volumeflow= volumeflow(:)';   % must be a row vector for creating q_state

%%

q_state= [zeros(33, numel(volumeflow)); volumeflow];

%%

try                        
  sensors.measureVecStream( ...
      NET.convertArray(time, 'System.Double', numel(time)), ...
      'Q', NET.convertArray(q_state, 'System.Double', size(q_state)), ...
      ['Q_', substrate_id]);
catch ME
  disp(ME.message)
  rethrow(ME);
end


%%


