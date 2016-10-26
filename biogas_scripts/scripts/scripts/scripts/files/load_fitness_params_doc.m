%% Syntax
%       fitness_params= load_fitness_params(plant_id)
%
%% Description
% |fitness_params= load_fitness_params(plant_id)| loads the file
% fitness_params_....xml for given |plant_id|. It is just the short version
% of |load_biogas_mat_files(plant_id, [], 'fitness_params')|
%
%% <<plant_id/>>
%%
% @return |fitness_params| : fitness_params C# object of class
% |biooptim.fitness_params|. 
%
%% Example
% 
%

load_fitness_params('gummersbach')


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant_id')">
% biogas_scripts/is_plant_id</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_mat_files')">
% biogas_scripts/load_biogas_mat_files</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
%
% <html>
% <a href="matlab:doc('biogas_scripts/load_plant')">
% biogas_scripts/load_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_file')">
% biogas_scripts/load_file</a>
% </html>
%
%% TODOs
% # do documentation for script file
%
%% <<AuthorTag_DG/>>


