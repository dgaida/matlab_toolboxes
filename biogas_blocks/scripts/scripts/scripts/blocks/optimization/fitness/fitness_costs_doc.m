%% Preliminaries
% # You need a Simulink simulation model of a biogas plant created with
% this toolbox with the *.mat files used for simulation. See the
% documentation of this toolbox.
% # Insert the fitness block in the simulation model outside the plant and
% write this function's name into the parameters field of the fitness block.
%
%% Syntax
%       fitness= fitness_costs(plant, substrate, fitness_params)
%       [fitness, data, data_string]= fitness_costs(...)
%
%% Remark
% each fitness function must have this Syntax.
%
%% Description
% |fitness_costs(plant, substrate, fitness_params)| calculates the fitness of the
% models actual state during or after a simulation. 
% The code is implemented inspired by a fitness function of C. Wolf, but is
% slightly adapted. 
%
%% <<plant/>>
%% <<substrate/>>
%% <<fitness_params/>>
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
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/getcurrentsensormeasurements')">
% biogas_scripts/getCurrentSensorMeasurements</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant')">
% biogas_scripts/is_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_substrate')">
% biogas_scripts/is_substrate</a>
% </html>
%
% and is called by:
%
% fitness sensor block
%
%% See Also
% 
% <html>
% <a href="fitness_calibration.html">
% fitness_calibration</a>
% </html>
% ,
% <html>
% <a href="fitness_RL_costs.html">
% fitness_RL_costs</a>
% </html>
%
%% TODOs
% # Gemessene Faulraumbelastung abfragen und in Fitnessfunktion integrieren
% (für gesamte Anlage)
% # Gemessene Hydraulische Verweildauer abfragen und in Fitnessfunktion
% integrieren (für gesamte Anlage)
% # inhibition Terme in fitness Funktion integrieren und über
% simulationszeitraum beobachten, um zu sehen, ob sich biogasanlage von
% selbst aus inhibition zuständen befreien kann ohne änderung der
% substratzufuhr
%
%% <<AuthorTag_DG/>>
%% References
% s. Kosten-Nutzen-Analyse in:
% 07 Energie aus organischen Abfällen und nachwachsenden Rohstoffen.pdf
%
% 


