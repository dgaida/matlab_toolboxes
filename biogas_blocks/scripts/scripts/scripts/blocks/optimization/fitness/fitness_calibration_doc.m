%% Preliminaries
% # You need a Simulink simulation model of a biogas plant created with
% this toolbox with the *.mat files used for simulation. See the
% documentation of this toolbox.
% # Insert the fitness block in the simulation model outside the plant and
% write this function's name into the parameters field of the fitness block.
%
%% Syntax
%       fitness= fitness_calibration(plant, substrate)
%       [fitness, data, data_string]= fitness_calibration(...)
%
%% Remark
% each fitness function must have this Syntax.
%
%% Description
% |fitness_calibration(plant, substrate)| calculates the fitness of the
% models actual state during or after a simulation. 
% The code is implemented inspired by a fitness function of C. Wolf, but is
% slightly adapted. 
%
%% <<plant/>>
%% <<substrate/>>
%%
% @return fitness : fitness of the actual state of the biogas plant model
%
%%
% @return data : array of the values used in the fitness function
%
% |[SS_degradationRate, XS_degradationRate, TS_concentration, ...]|
%
%%
% @return data_string : array of cellstrings describing the arrayelements
% of the array data
%
% |[{'SS_degradation', 'XS_degradation', 'TS_concentration', ...}]|
%
%% Example
%
%
%% See Also
% 
% <html>
% <a href="fitness_costs.html">
% fitness_costs</a>
% </html>
% ,
% <html>
% <a href="fitness_RL_costs.html">
% fitness_RL_costs</a>
% </html>
%
%% TODOs
% # Gemessene Faulraumbelastung abfragen und in Fitnessfunktion integrieren
% # Gemessene Hydraulische Verweildauer abfragen und in Fitnessfunktion
% integrieren 
%
%% <<AuthorTag_DG/>>

    
    