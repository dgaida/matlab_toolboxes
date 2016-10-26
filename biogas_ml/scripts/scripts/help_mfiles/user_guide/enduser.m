%% Introduction
% This toolbox contains biogas applications using Machine Learning methods.
% At the moment only one application is available:
%
%% Prediction
% This part of the toolbox lets you create a State Estimator for biogas
% plants. This state estimator is created as a mapping function using
% pattern recognition methods, which learn a mapping between input and
% output values of the biogas plant and the state of the biogas plant. 
%
% As input and output values are used:
%
% * input: substrate feeds
% * outputs: pH value, biogas production, CH4 and CO2 content in the biogas
%
%%
% To create such a state estimator you have to call
% <matlab:doc('biogas_ml/createstateestimator') createStateEstimator>. This
% function does two things:
%
% # It calls <matlab:doc('biogas_ml/simbiogasplantforprediction')
% simBiogasPlantForPrediction> which runs a lot of simulations with the
% biogas plant model of your plant (the plant you want the state estimator
% created for) to generate a huge dataset containing the state vector of
% the biogas plant as well as the corresponding in- and output values of
% the biogas plant. 
% # Using this dataset the function
% <matlab:doc('biogas_ml/startstateestimation') startStateEstimation> is
% called which uses pattern recognition methods to find a pattern between
% the state vector and the corresponding in- and output values of the
% biogas plant. As a result a trained and validated model of a pattern
% recognition method is returned, which can be used as state estimator for
% the biogas plant at hand. 
% 
% Note:
%
% The created state estimator is only valid for the biogas plant used for
% generating the state estimator. And only valid for the current
% configuration of the plant. In case one or more of the examples listed
% below happen, the state estimator and the dataset have to be generated
% again:
%
% * substrate feed changes, substrate characteristics change
% * biology of the fermenter changes, ADM1 model parameter change
% 
%%
%
%


