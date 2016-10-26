%% Syntax
%       sensor_data= appendSensorData(sensor_data, new_sensor_data)
% 
%% Description
% |sensor_data= appendSensorData(sensor_data, new_sensor_data)| appends new
% sensors data |new_sensor_data| at the end of |sensor_data| and returns
% the new data |sensor_data|. 
%
%%
% @param |sensor_data| : current data gotten from object of C# class
% |biogas.sensors| using the function: <getdataofsensor.html
% getDataOfSensor>. Is a struct as returned by the mentioned function. May
% also be a struct, containing structs named as the IDs of the digesters on
% the plant. These structs again have to be as returned by
% <getdataofsensor.html getDataOfSensor>.
%
%%
% @param |new_sensor_data| : current data gotten from object of C# class
% |biogas.sensors| using the method: <getdataofsensor.html
% getDataOfSensor>. Is a struct as returned by the mentioned function. May
% also be a struct, containing structs named as the IDs of the digesters on
% the plant. These structs again have to be as returned by
% <getdataofsensor.html getDataOfSensor>. Must hav the same format as
% |sensor_data|. 
%
%%
% @return |sensor_data| : The data inside |new_sensor_data| is appended
% after the data in |sensor_data| and returned as |sensor_data|. The
% returned |sensor_data| has the same format as the given |sensor_data|,
% just the new data is appended. 
%
%% Example
%
%

clear

%%
%

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

fcn= 'plant_gummersbach';

%%

try
  load_biogas_system(fcn);

  open_system(fcn);
catch ME
  close_biogas_system(fcn);
end

%%

try
  sim(fcn, [0, 10]);
catch ME
  
end

%%

try
  sensors= evalinMWS('sensors');
catch ME
  
end

% You could also use a for loop running over all digesters the plant
% contains, then write: sensor_data.(fermenter_id)
fermenter_id= char(plant.getDigesterID(1));

try
  sensor_data= getDataOfSensor(sensors, fermenter_id);
  
  disp(sensor_data);
catch ME
  
end

%%

try
  sim(fcn, [0, 10]);
catch ME
  
end

%%

try
  sensors= evalinMWS('sensors');
catch ME
  
end

%%

close_biogas_system(fcn);

%%

new_sensor_data= getDataOfSensor(sensors, fermenter_id);

%%

sensor_data= appendSensorData(sensor_data, new_sensor_data);

disp(sensor_data);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('isstruct')">
% matlab/isstruct</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_control/nonlinearmpc')">
% biogas_control/nonlinearMPC</a>
% </html>
% ,
% <html>
% <a href="matlab:doc ex_model_predict_sh">
% ex_model_predict_sh</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="getdataofsensor.html">
% getDataOfSensor</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_save_ctrl_strgy_substrateflow')">
% biogas_control/NMPC_save_ctrl_strgy_SubstrateFlow</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_save_ctrl_strgy_fermenterflow')">
% biogas_control/NMPC_save_ctrl_strgy_FermenterFlow</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_load_substrateflow')">
% biogas_control/NMPC_load_SubstrateFlow</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


