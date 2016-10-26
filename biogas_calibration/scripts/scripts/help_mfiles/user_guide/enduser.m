%% Introduction
% # With this toolbox you can calibrate the ADM1 parameters of your model,
% such that your model is able to model a real biogas plant realistically. 
% # To start the parameter calibration process have a look at the function
% <matlab:doc('biogas_calibration/startadmparamscalibration')
% biogas_calibration/startADMparamsCalibration>. After you have read the
% documentation and have done the preliminaries of the function, call the
% function. Be aware of that the calibration process may take several days,
% depending on the number of parameters you want to optimize. The long
% duration of the procedure comes due to the fact, that the plant is
% operated with real data from the plant, which can be quite dynamic. 
%
%% Meaning of ADM1 parameter files
%
% # adm1_param_vec: Werte in adm1_param_vec sollten nur AUswirkungen haben,
% wenn Simulation bei t > 0 gestartet wird.
% # adm1_param_opt: die Datei hat keine Auswirkungen, muss aber immer
% vorhanden sein für konstante optimale Parameter. 
%

