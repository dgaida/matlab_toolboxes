%% Syntax
%       plant= load_plant(plant_id)
%
%% Description
% |plant= load_plant(plant_id)| loads the file
% plant_....xml for given |plant_id|. It is just the short version
% of |load_biogas_mat_files(plant_id, [], 'plant')|
%
%% <<plant_id/>>
%%
% @return |plant| : plant C# object of class |biogas.plant|. 
%
%% Example
% 
%

load_plant('gummersbach')


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
% <a href="matlab:doc('biogas_scripts/load_fitness_params')">
% biogas_scripts/load_fitness_params</a>
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


