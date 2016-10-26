%% Syntax
%       [ys]= getVectorOutOfStream(stream, goal_variable)
%       [ys]= getVectorOutOfStream(stream, goal_variable, bins)
%       [ys]= getVectorOutOfStream(stream, goal_variable, bins, min_y)
%       [ys]= getVectorOutOfStream(stream, goal_variable, bins, min_y,
%       max_y) 
%       [...]= getVectorOutOfStream(stream, goal_variable, bins, min_y,
%       max_y, fromUnit) 
%       [...]= getVectorOutOfStream(stream, goal_variable, bins, min_y,
%       max_y, fromUnit, toUnit) 
%       [ys, yclass]= getVectorOutOfStream(stream, goal_variable, ...)
%       [ys, yclass, unit]= getVectorOutOfStream(stream, goal_variable,
%       ...) 
%       [ys, yclass, unit, mini]= getVectorOutOfStream(stream,
%       goal_variable, ...) 
%       [ys, yclass, unit, mini, maxi]= getVectorOutOfStream(stream,
%       goal_variable, ...) 
%
%% Description
% |[ys]= getVectorOutOfStream(stream, goal_variable)| returns the by
% |goal_variable| specified column of the matrix |stream|. For most state
% vector components the returned data is given in a different unit, such
% that not only the data is returned, but a transformed data. The unit in
% which is converted is determined calling <getdefaultmeasurementunit.html
% getDefaultMeasurementUnit>, see also the parameter |toUnit|. 
%
%%
% @param |stream| : double matrix. It has 37 columns, one for each state
% vector component of the ADM1. It has as many rows as you want, in each
% row could be a value of the state vector measured at a different time.
%
%%
% @param |goal_variable| : char containing the shortcut of the ADM1 state
% vector component which values shall be returned. E.g.: 'Ssu', 'Saa',
% 'Xsu', ... 
%
%%
% @return |ys| : a double vector containing the data for the given state
% vector component, read out of the matrix |stream| and transformed. It has
% the unit given by the parameter |toUnit| or if the parameter is not
% given, then it has the unit gotten by <getdefaultmeasurementunit.html
% getDefaultMeasurementUnit>.
%
%%
% |[ys]= getVectorOutOfStream(stream, goal_variable, bins)| classifies the
% returned vector |ys| into |bins| classes. The classified data is returned
% as a second output argument (|yclass|), |ys| is returned untouched.
%
%%
% @param |bins| : number of bins used for clustering, double integer
% scalar. 
%
%%
% |[ys]= getVectorOutOfStream(stream, goal_variable, bins, min_y, max_y)| 
%
%%
% @param |min_y| : double scalar, which sets the minimal physical value of
% the given state vector component, which should be used for clustering.
% the minimal value gets class 0. Useful if training data and afterwards
% following validation data is passed through this function. Then the min
% and max gotten for the training data (returned as fourth and fifth
% argument |mini| and |maxi|) should be passed with the validation data.
%
%%
% @param |max_y| : double scalar, which sets the maximal physical value of
% the given state vector component, which should be used for clustering.
% the minimal value gets class 0. Useful if training data and afterwards
% following validation data is passed through this function. Then the min
% and max gotten for the training data (returned as fourth and fifth
% argument |mini| and |maxi|) should be passed with the validation data. If
% |min_y| is empty, but |max_y| not, or the other way round, then none of
% them is used (a warning is thrown).
%
%%
% |[ys]= getVectorOutOfStream(stream, goal_variable, bins, min_y, max_y,
% fromUnit)| 
%
%%
% @param |fromUnit| : defines the unit in which the given |goal_variable|
% inside |stream| is assumed to be measured. If you do not pass this
% argument to the function, then it is assumed, that the given
% |goal_variable| inside |stream| is measured in the unit given by the C#
% method |physValue.getDefaultUnit(symbol)|.
%
% WARNING!!!
%
% It is not recommended to not pass |fromUnit| to this function, because it
% could be that the |stream| values are measured in a different unit, maybe
% when using a different ADM model. A warning is thrown.
%
%%
% |[ys]= getVectorOutOfStream(stream, goal_variable, bins, min_y, max_y,
% fromUnit, toUnit)| 
%
%%
% @param |toUnit| : The returned values inside |ys| are measured in the
% given unit |toUnit|. If the parameter is not given, then the values have
% the unit gotten from <getdefaultmeasurementunit.html
% getDefaultMeasurementUnit>. If you set this parameter to [], then the
% units out of the C# method |physValue.getDefaultUnit(goal_variable)| are
% used, which are basically the default ADM1 units. 
%
%%
% |[ys, yclass]= getVectorOutOfStream(stream, goal_variable, ...)|
%
%%
% @return |yclass| : double vector, same as |ys| clustered in |bins|
% classes. If |bins| is not given, then |yclass= []|. The classes run from
% 0 to |bins - 1|. 
%
%%
% |[ys, yclass, unit]= getVectorOutOfStream(stream, goal_variable, ...)|
%
%%
% @return |unit| : char containing the unit in which the returned data |ys|
% is measured.
%
%% 
% |[ys, yclass, unit, mini]= getVectorOutOfStream(stream, goal_variable,
% ...)|
%
%%
% @return |mini| : double scalar with the minimal value of |ys|.
%
%%
% |[ys, yclass, unit, mini, maxi]= getVectorOutOfStream(stream,
% goal_variable, ...)|
%
%%
% @return |maxi| : double scalar with the maximal value of |ys|.
%
%% Example
% 
%

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

try
  load_biogas_system('plant_gummersbach');

  open_system('plant_gummersbach');
catch ME
  close_biogas_system('plant_gummersbach');
end

try
%   sim('plant_gummersbach', [0, 100]);
catch ME
  disp(ME.message);
end

try
  sensors= evalinMWS('sensors');
catch ME
  disp(ME.message);
end

close_biogas_system('plant_gummersbach');

%%

stream= sensors.getMeasurementStreams(['ADMstate_', char(plant.getDigesterID(1))]);
stream= double(stream)';
  
time= double( sensors.getTimeStream() )';

%%

[ys, dummy, unit]= getVectorOutOfStream(stream, 'Sac');

plot(time, ys);
ylabel(sprintf('Sac [%s]', unit))
xlabel('time [d]')


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc scale_data">
% scale_Data</a>
% </html>
% ,
% <html>
% <a href="getdefaultmeasurementunit.html">
% getDefaultMeasurementUnit</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="startmethodforstateestimation.html">
% startMethodforStateEstimation</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="createdatasetforpredictor.html">
% createDataSetForPredictor</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/katz_lda')">
% ml_tool/katz_lda</a>
% </html>
% ,
% <html>
% <a href="simbiogasplantforprediction.html">
% simBiogasPlantForPrediction</a>
% </html>
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


