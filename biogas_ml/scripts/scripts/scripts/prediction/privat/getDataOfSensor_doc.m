%% Syntax
%       sensor_data= getDataOfSensor(sensors, fermenter_id)
%       sensor_data= getDataOfSensor(sensors, fermenter_id, noisy)
%
%% Description
% |sensor_data= getDataOfSensor(sensors, fermenter_id)| returns a structure
% |sensor_data| containing measurement streams taken from |sensors| for the
% specfied digester |fermenter_id| used for State Estimation. Here the
% complete measurement streams from the start to the end of the simulation
% is returned. 
%
%%
% @param |sensors| : object of the C# class |biogas.sensors|
%
%%
% @param |fermenter_id| : char defining the ID of the digester
%
%%
% @return |sensor_data| : structure with the following fields:
%
% * |time| : time vector with the time instances where a measurement value
% was collected
% * |stream| : stream of 37dim state vector of the digester
% * |pH| : measurement stream of pH values
% * |ch4| : measurement stream of CH4 values measured in [%]
% * |co2| : measurement stream of CO2 values measured in [%]
% * |biogas| : biogas stream measured in [m³/d]
% * |Q| : structure containing substrate feed and recirculation flow into the
% given digester
% * |t_q| : structure containing the time stamp corresponding to the
% structure |Q|
%
%%
% @param |noisy| : true or false, a logical. If true, then noisy (may
% include drift) measurements are read out of the |sensors| object. Else
% ideal measurements are read. See also the |sensors_...xml| file. 
%
%% Example
% 
%

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

%%

fcn= 'plant_gummersbach';

%%

try
  load_biogas_system(fcn);

  open_system(fcn);
catch ME
  
end

%%

fermenter_id= char(plant.getDigesterID(1));

try
  sim(fcn, [0, 20]);
catch ME
  
end

%%

try
  sensors= evalinMWS('sensors');
  
  sensor_data= getDataOfSensor(sensors, fermenter_id);
  
  disp('sensor_data: ')
  disp(sensor_data)
  disp('sensor_data.Q: ')
  disp(sensor_data.Q)
  disp('sensor_data.t_q: ')
  disp(sensor_data.t_q)
  
catch ME
  
end

%%

close_biogas_system(fcn);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('ex_model_predict_sh')">
% ex_model_predict_sh</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="createstateestimator.html">
% createStateEstimator</a>
% </html>
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


