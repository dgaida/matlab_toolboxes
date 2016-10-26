%% Syntax
%       [sensorsData, sensorsSymbolsUnits]= getCurrentSensorMeasurements()
%       [...]= getCurrentSensorMeasurements(sensors)
%       [...]= getCurrentSensorMeasurements(sensors, noisy)
%        
%% Description
% |[sensorsData, sensorsSymbolsUnits]= getCurrentSensorMeasurements()|
% evaluates |sensors| in the <matlab:doc('simulink.modelworkspace')
% modelworkspace> of a Simulink biogas plant model (therefore the model
% still must be load (see example below)) and reads the current
% measurements out of the evaluated |sensors| object. 
%
%%
% @return |sensorsData| : double data vector of the measurements inside the
% sensors object, last measurement.
%
%%
% @param |sensorsSymbolsUnits| : <matlab:doc('matlab/cellstr') cell array of
% strings> describing the measurements. 
%
%%
% |[...]= getCurrentSensorMeasurements(sensors)| reads the measurements out
% of the given |sensors| object.
%
%%
% @param |sensors| : object of the C# class |biogas.sensors|
%
%%
% @param |noisy| : logical
%
% * true : then noisy measurements are returned. They are only noisy for
% those sensors that are run as real sensors. See |sensors_....xml| of the
% plant. 
% * false : ideal measurements are returned. Default. 
%
%% Example
%

%clear;

%%

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

fcn= 'plant_gummersbach';

%%

try
  load_biogas_system(fcn);
catch ME
  disp(ME.message)
end

open_system(fcn);

try
  % assuring that const volumeflow is used
  set_volumeflow_type(fcn, 'const');
  
  sim(fcn, [0, 50]);
catch ME
  disp(ME.message)
end

%%

try
  [sensorsData, sensorsSymbolsUnits]= getCurrentSensorMeasurements();

  disp(sensorsData)

  disp(sensorsSymbolsUnits)
catch ME
  disp(ME.message)
end

%%

close_biogas_system(fcn);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('cell')">
% matlab/cell</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/evalinmws')">
% script_collection/evalinMWS</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_sensors')">
% biogas_scripts/is_sensors</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('fitness_costs')">
% fitness_costs</a>
% </html>
%
%% See also
% 
% <html>
% <a href="matlab:doc('getbiogaslibpath')">
% getBiogasLibPath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('simulink/sim')">
% simulink/sim</a>
% </html>
% ,
% <html>
% <a href="load_biogas_system.html">
% load_biogas_system</a>
% </html>
% ,
% <html>
% <a href="close_biogas_system.html">
% close_biogas_system</a>
% </html>
%
%% TODOs
% # create documentation for script file
% # the example seems not to be ok at the moment
%
%% <<AuthorTag_DG/>>


