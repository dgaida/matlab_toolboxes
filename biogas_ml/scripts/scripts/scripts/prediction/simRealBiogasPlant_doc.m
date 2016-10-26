%% Syntax
%       simRealBiogasPlant(equilibrium, plant_id)
%       simRealBiogasPlant(equilibrium, plant_id, postgreSQL)
%       simRealBiogasPlant(equilibrium, plant_id, postgreSQL, timespan)
%       
%% Description
% |simRealBiogasPlant(equilibrium, plant_id)| 
%
%% <<equilibrium/>>
%%
% @param |plant_id| : char with the id of the simulation model of the
% biogas plant. The plant's id is defined in the structure |plant| and has
% to be set in the simulation model, which is
% <matlab:doc('develop_model_stepbystep') created> 
% using the toolbox's library. 
%
%%
% @param |postgreSQL| : name of the postgreSQL database where the input and
% output data after the simulation is written
%
%%
% @param |timespan| : the duration of each simulation : e.g. [0 50] for 50
% days. Default: [0 500]. 
%
%% Example
%
%

cd( fullfile( getBiogasLibPath(), 'examples', 'model', 'Koeln') );

%%

equilibrium= getEquilibriumFromFiles('koeln');

data= simRealBiogasPlant(equilibrium, 'koeln');

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc load_biogas_mat_files">
% load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc load_biogas_system">
% load_biogas_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/simbiogasplant')">
% biogas_optimization/simBiogasPlant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc close_biogas_system">
% close_biogas_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_ml/getdataofsensor">
% biogas_ml/getDataOfSensor</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_equilibrium">
% biogas_scripts/is_equilibrium</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_optimization/simbiogasplantextended')">
% biogas_optimization/simBiogasPlantExtended</a>
% </html>
%
%% TODOs
% # improve documentation a little bit
% # make an example
% # make TODO
%
%% <<AuthorTag_DG/>>


