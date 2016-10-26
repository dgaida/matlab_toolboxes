%% Syntax
%       x_hat_new= convertStateEstimateToDefaultUnits(x_hat)
%       x_hat_new= convertStateEstimateToDefaultUnits(x_hat, goal_variables)
%
%% Description
% |x_hat_new= convertStateEstimateToDefaultUnits(x_hat)|
%
%%
% @param |x_hat| : double array with 37 rows and number of digesters
% columns. Contains the estimate of the states of the digesters, measured
% in default measurement units, such as g/l, ...
%
%%
% @return |x_hat_new| : double array with 37 rows and number of digesters
% columns. Contains the estimate of the states of the digesters (same
% values as in |x_hat|), but measured in units of ADM1 model, such as
% kgCOD/m^3, ... 
%
%%
% |x_hat_new= convertStateEstimateToDefaultUnits(x_hat, goal_variables)|
%
%%
% @param |goal_variables| : variables of state vector, which are defined in
% the file |adm1_state_abbrv.mat|. 37 dimensional column vector of
% cellstrings. 
%
%% Example
% 
%



%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="getvectoroutofstream.html">
% getVectorOutOfStream</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc ex_model_predict_sh">
% ex_model_predict_sh</a>
% </html>
% ,
% <html>
% <a href="getstateestimateofbiogasplant.html">
% getStateEstimateOfBiogasPlant</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="getstateestimateofdigester.html">
% getStateEstimateOfDigester</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/fitness_dxnorm')">
% biogas_optimization/fitness_DXNorm</a>
% </html>
%
%% TODOs
% # improve documentation
% # make an example
%
%% <<AuthorTag_DG/>>


