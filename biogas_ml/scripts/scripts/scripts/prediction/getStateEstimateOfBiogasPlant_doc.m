%% Syntax
%       x_hat= getStateEstimateOfBiogasPlant(plant, sensors)
%       getStateEstimateOfBiogasPlant(plant, sensors, method)
%       getStateEstimateOfBiogasPlant(plant, sensors, method,
%       convertUnitToDefault) 
%       getStateEstimateOfBiogasPlant(plant, sensors, method,
%       convertUnitToDefault, minimize_dx) 
%
%% Description
% |x_hat= getStateEstimateOfBiogasPlant(plant, sensors)|
% returns the current state estimate |x_hat| for the given |plant|. 
%
%% <<plant/>>
%%
% @param |sensors| : object of the C# class |biogas.sensors| or a structure
% created by <matlab:doc('biogas_control/nmpc_simbiogasplantextended')
% biogas_control/NMPC_simBiogasPlantExtended> using <getdataofsensor.html
% getDataOfSensor>. 
%
%%
% @param |method| : method used for prediction, char:
%
% # 'LDA' : Linear Discriminant Analysis
% # 'RF'  : Random Forest
%
%%
% @param |convertUnitToDefault| : 0 or 1
%
% * 0 : (default)
% * 1 : converts values to units defined by ADM1 for state vector
%
%%
% @param |minimize_dx| : 0 or 1, Default: 1. 
%
% * 0 : return estimated x as it is
% * 1 : choose estimated x between boundaries that has minimal velocity:
% dx/dt 
%
%%
% @return |x_hat| : double matrix, estimates of state vector for each
% digester. [col.vector1, col.vector2, ...].
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="getstateestimateofdigester.html">
% getStateEstimateOfDigester</a>
% </html>
% ,
% <html>
% <a href="matlab:doc findmindxnorm">
% findMinDXNorm</a>
% </html>
% ,
% <html>
% <a href="getvectoroutofstream.html">
% getVectorOutOfStream</a>
% </html>
% ,
% <html>
% <a href="matlab:doc load_file">
% load_file</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_control/nmpc_tmrfcn')">
% biogas_control/NMPC_TmrFcn</a>
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
% # improve documentation
% # make an example
%
%% <<AuthorTag_DG/>>


