%% getDataOfSensor
% Get measurement data of sensors used for State Estimation
%
function sensor_data= getDataOfSensor(sensors, fermenter_id, varargin)
%% Release: 1.9

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1})
  noisy= varargin{1};
  checkArgument(noisy, 'noisy', 'logical', 3);
else
  noisy= false;
end

%%

checkArgument(sensors, 'sensors', 'biogas.sensors', '1st');
checkArgument(fermenter_id, 'fermenter_id', 'char', '2nd');

%%

sensor_data.time=   double( sensors.getTimeStream() )';

sensor_data.stream= double( sensors.getMeasurementStreams(['ADMstate_', fermenter_id]) )';

%%

sensor_data.pH=     double( sensors.getMeasurementStream( ...
                            ['pH_', fermenter_id, '_3'], noisy) )';
sensor_data.ch4=    double( sensors.getMeasurementStream( ...
                            ['biogas_', fermenter_id], '', 'CH4_%', noisy) )';
sensor_data.co2=    double( sensors.getMeasurementStream( ...
                            ['biogas_', fermenter_id], '', 'CO2_%', noisy) )';
sensor_data.biogas= double( sensors.getMeasurementStream( ...
                            ['biogas_', fermenter_id], '', 'biogas_m3_d', noisy) )';

%%
% get substrate feeds an recirculation flows

obj_fieldnames_NET= sensors.getIDsOfArray('Q');

% here save the ids of the sensors as cell array of strings
obj_fieldnames= cell(obj_fieldnames_NET.Length, 1);

for iel= 1:numel(obj_fieldnames)
  obj_fieldnames{iel}= char( obj_fieldnames_NET.Get(iel - 1) );
end

n_substrate= numel(obj_fieldnames);

%%
% get the stream and the time

for isubstrate= 1:n_substrate

  substrate_id= char(obj_fieldnames(isubstrate, 1));

  sensor_data.Q.(substrate_id)= ...
      double( sensors.getMeasurementStream('Q', ['Q_', substrate_id], noisy) )';
    
  sensor_data.t_q.(substrate_id)= ...
      double( sensors.getTimeStream(       'Q', ['Q_', substrate_id]) )';

end


%%


