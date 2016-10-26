%% Syntax
%       [dataset, stream]= createDataSetForPredictor(sensors, plant,
%       fermenter_id) 
%       [...]= createDataSetForPredictor(sensors, plant, fermenter_id, 
%       sample_time) 
%       [...]= createDataSetForPredictor(sensors, plant, fermenter_id, 
%       sample_time, noise_in) 
%       [...]= createDataSetForPredictor(sensors, plant, fermenter_id, 
%       sample_time, noise_in, noise_out) 
%       [...]= createDataSetForPredictor(sensors, plant, fermenter_id, 
%       sample_time, noise_in, noise_out, filter_num_out)  
%       [...]= createDataSetForPredictor(sensors, plant, fermenter_id, 
%       sample_time, noise_in, noise_out, filter_num_out, filter_num_in)  
%       [...]= createDataSetForPredictor(sensors, plant, fermenter_id, 
%       sample_time, noise_in, noise_out, filter_num_out, filter_num_in,
%       noisy) 
%
%% Description
% |[dataset, stream]= createDataSetForPredictor(sensors, plant, 
% fermenter_id)| creates a dataset |dataset| used to predict the
% internal states |stream| of a biogas plant. Thus the predictor is working
% as a state estimator. Therefore the simulation data, which after a
% simulation is saved in the object |sensors|, is used to learn a
% pattern between basic plant measurements and the internal states of biogas
% plants. Therefore out of the object |sensors| the stream of the
% state vectors are read, resampled to the given |sample_time| and returned
% as |stream|. As measurements out of |sensors| the following are
% read:
%
% * pH value in each fermenter on the plant
% * CO2 content of the produced biogas for each fermenter on the plant
% * CH4 content of the produced biogas for each fermenter on the plant
% * total biogas produced by each fermenter on the plant
% * total substrate feed amount for each substrate seperately, which is fed
% to the plant
%
% These values are returned in |dataset|, resampled by |sample_time|.
% Furthermore their moving averages using window sizes defined by
% |filter_num_out| for the output measurements and 
% |filter_num_in| for the substrate feed measurements.
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
% @param |fermenter_id| : id of the fermenter, whose state vector shall be
% predicted. The fermenter id is defined in |plant|.
%
%%
% @return |dataset| : resampled measurement data with added moving average
% filtered data 
%
% |dataset| = [X, U]
%
% with
%
% X = [pH value, different moving averages of pH values, 
%      total amount of produced biogas, mean values of total amount of produced biogas, 
%      ch4 content, different moving averages of ch4 content, 
%      co2 content, different moving averages of co2 content]
%
% U = [substrate feed, mean values of substrate feed]
%
%%
% @return |stream| : stream of the to be predicted state vector of the by
% |fermenter_id| specified biogas plant. This is resampled using
% |sample_time|. The units are the default units of the ADM, thus mostly
% kgCOD/m^3. 
%
%%
% |[...]= createDataSetForPredictor(sensors, plant, fermenter_id,
% sample_time)| 
%
%%
% @param |sample_time| : sample time used to resample the measurement data
% read out of |sensors|. The sample time is given in hours. As a 
% default the sample time is set to 1 hour. double scalar. 
%
%%
% |[...]= createDataSetForPredictor(sensors, plant, fermenter_id,
% sample_time, noise_in)| 
%
%%
% @param |noise_in| : double scalar value defining the relative noise added
% to the substrate feed values. To each substrate the same defined
% error/noise is added. Default 0. TODO: has no effect anymore, replaced by
% parameter |noisy|.
%
%%
% |[...]= createDataSetForPredictor(sensors, plant, fermenter_id,
% sample_time, noise_in, noise_out)| 
%
%%
% @param |noise_out| : double 4d-array defining the noise added to the
% measurements of
% 
% * pH value
% * ch4 content in biogas
% * co2 content in biogas
% * total biogas production
%
% Default zero vector. TODO: has no effect anymore, replaced by
% parameter |noisy|.
%
%%
% |[...]= createDataSetForPredictor(sensors, plant, fermenter_id,
% sample_time, noise_in, noise_out, filter_num_out)| 
%
%%
% @param |filter_num_out| : double array defining the time slots of the
% moving average filters used for the output measurements, the values are
% measured in hours.  
% default: [12, 24, 3*24, 7*24, 14*24, 21*24, 31*24].
%
%%
% |[...]= createDataSetForPredictor(sensors, plant, fermenter_id,
% sample_time, noise_in, noise_out, filter_num_out, filter_num_in)| 
%
%%
% @param |filter_num_in| : double array defining the time slots of the
% moving average filters used for the substrate feed measurements, the
% values are measured in hours.  
% default: [12, 24, 3*24, 7*24, 14*24]
%
%%
% @param |noisy| : true or false, a logical. If true, then noisy (may
% include drift) measurements are read out of the |sensors| object. Else
% ideal measurements are read. See also the |sensors_...xml| file. 
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

[dataset, stream]= createDataSetForPredictor(...
                  	sensors, plant, char(plant.getDigesterID(1)), 12);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="create_filter_char.html">
% create_filter_char</a>
% </html>
% ,
% <html>
% <a href= matlab:doc('filter')>
% matlab/filter</a>
% </html>
% ,
% <html>
% <a href="get4measurementsfromsensors.html">
% get4MeasurementsfromSensors</a>
% </html>
% ,
% <html>
% <a href= matlab:doc('interp1')>
% matlab/interp1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/resampledata')">
% data_tool/resampleData</a>
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
% <a href="matlab:doc ldastateestimator">
% LDAStateEstimator</a>
% </html>
% ,
% <html>
% <a href="matlab:doc rfstateestimator">
% RFStateEstimator</a>
% </html>
% ,
% <html>
% <a href="simbiogasplantforprediction.html">
% simBiogasPlantForPrediction</a>
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
% # make TODOs, especially randn/rand
%
%% <<AuthorTag_DG/>>


