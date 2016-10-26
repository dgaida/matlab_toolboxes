%% Syntax
%       x_hat= getStateEstimateOfDigester(plant, sensors, fermenter_id)
%       x_hat= getStateEstimateOfDigester(plant, sensors, fermenter_id,
%       method) 
%       x_hat= getStateEstimateOfDigester(plant, sensors, fermenter_id,
%       method, dataset_flag_vec) 
%       [...]= getStateEstimateOfDigester(plant, sensors, fermenter_id,
%       method, dataset_flag_vec, goal_variables) 
%       [...]= getStateEstimateOfDigester(plant, sensors, fermenter_id,
%       method, dataset_flag_vec, goal_variables,
%       digester_state_dataset_min) 
%       [...]= getStateEstimateOfDigester(plant, sensors, fermenter_id,
%       method, dataset_flag_vec, goal_variables,
%       digester_state_dataset_min, digester_state_dataset_max) 
%
%% Description
% |x_hat= getStateEstimateOfDigester(plant, sensors, fermenter_id)|
% returns the current state estimate |x_hat| for the given digester
% specified by |fermenter_id|. It estimates the current state using the
% measurement data collected in |sensors| (substrate feed, pH, CO2, CH4 and
% biogas stream). 
%
% If you call the function like this, the following files must exist:
%
% * |dataset_flag_vec.mat| which is created in <startstateestimation.html
% startStateEstimation> (see also the parameter |dataset_flag_vec| below)
% * |digester_state_dataset_min.mat| and |digester_state_dataset_max.mat|
% 
% If you use the method Random Forest for prediction, which is the default,
% then also the following files must exist, which contain the trained
% Random Forest model. They must be in a subfolder called |RF|: 
%
% * |rf_model_classify__fermenter_id__v%02i.mat| with |%02i| being a
% running number from 1 to 37, always displaying 2 digits (01, 02, ...)
%
% If you use the method LDA, then in a subfolder |LDA| the following files
% must exist:
%
% * |TransMatnorms.mat|
% * |alphas.mat|
% * |ClassMeanMs.mat|
%
%% <<plant/>>
%%
% @param |sensors| : object of the C# class |biogas.sensors| or a structure
% created by <getdataofsensor.html getDataOfSensor>. 
%
%%
% @param |fermenter_id| : char with the ID of the digester
%
%%
% @param |method| : method used for prediction, char:
%
% # 'LDA' : Linear Discriminant Analysis
% # 'RF'  : Random Forest (default)
%
%%
% @return |x_hat| : double column vector, estimate of state vector of given
% digester. 
%
%%
% @param |dataset_flag_vec| : file created in <startstateestimation.html
% startStateEstimation> 
%
%%
% @param |goal_variables| : variables of state vector, which are defined in
% the file |adm1_state_abbrv.mat|. 37 dimensional column vector of
% cellstrings. 
%
%%
% @param |digester_state_dataset_min| : lower boundary defined in
% |digester_state_dataset_min.mat| 
%
%%
% @param |digester_state_dataset_max| : upper boundary defined in
% |digester_state_dataset_max.mat| 
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="createdatasetforpredictor.html">
% createDataSetForPredictor</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/lda_lin_classifier')">
% ml_tool/LDA_lin_classifier</a>
% </html>
% ,
% <html>
% <a href="get_real_value_from_class.html">
% get_real_value_from_class</a>
% </html>
% ,
% <html>
% <a href="matlab:doc load_file">
% load_file</a>
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
% <a href="getstateestimateofbiogasplant.html">
% getStateEstimateOfBiogasPlant</a>
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
%
%% <<AuthorTag_DG/>>


