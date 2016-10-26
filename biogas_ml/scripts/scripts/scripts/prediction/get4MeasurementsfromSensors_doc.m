%% Syntax
%       [pH, ch4, co2, ch4p]= get4MeasurementsfromSensors(sensors, plant)
%       [...]= get4MeasurementsfromSensors(sensors, plant, sample_time)
%       [...]= get4MeasurementsfromSensors(sensors, plant, sample_time,
%       noisy) 
%
%% Description
% |[pH, ch4, co2, ch4p]= get4MeasurementsfromSensors(sensors, plant)| get
% measurement streams for pH, CH4 and CO2 concentration and CH4 
% production out of sensors. 
% 
%%
% As measurements out of |sensors| the following are
% read:
%
% * pH value in each fermenter on the plant
% * CO2 content of the produced biogas for each fermenter on the plant
% * CH4 content of the produced biogas for each fermenter on the plant
% * total biogas produced by each fermenter on the plant
% 
%%
% @param |sensors| : |biogas.sensors| object, which is created by the simulation 
% model in the model workspace during a simulation. After a simulation, plant
% measurements are saved in this object which are used in this function.
%
% May also be a |sensor_data| struct as it is returned by
% <getdataofsensor.html getDataOfSensor>. 
%
%% <<plant/>>
%%
% @return |pH| : 
%
%%
% |[...]= get4MeasurementsfromSensors(sensors, plant, sample_time)| 
%
%%
% @param |sample_time| : sample time used to resample the measurement data
% read out of |sensors|. The sample time is given in hours. As a 
% default the sample time is set to 1 hour. double scalar. 
%
%%
% |[...]= get4MeasurementsfromSensors(sensors, plant, sample_time, noisy)| 
%
%%
% @param |noisy| : true or false, a logical. If true, then noisy (may
% include drift) measurements are read out of the |sensors| object. Else
% ideal measurements are read. See also the |sensors_...xml| file. Default:
% false. 
%
%% Example
% 
%

clear;

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

%%

try
  load_biogas_system('plant_gummersbach');

  open_system('plant_gummersbach');
catch ME
  close_biogas_system('plant_gummersbach');
end

%%

try
%   sim('plant_gummersbach', [0, 100]);
catch ME
  disp(ME.message)
end

try
  sensors= evalinMWS('sensors');
catch ME
  disp(ME.message)
end

%%

close_biogas_system('plant_gummersbach');

%%

[pH, ch4, co2, ch4p]= get4MeasurementsfromSensors(sensors, plant);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href= matlab:doc('interp1')>
% matlab/interp1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc createdatasetforpredictor">
% createDataSetForPredictor</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="startstateestimation.html">
% startStateEstimation</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/katz_lda')">
% ml_tool/katz_lda</a>
% </html>
% ,
% <html>
% <a href="matlab:doc scale_data">
% scale_Data</a>
% </html>
%
%% TODOs
% # make example run
% # check code a little bit
% # improve documentation
%
%% <<AuthorTag_DG/>>


