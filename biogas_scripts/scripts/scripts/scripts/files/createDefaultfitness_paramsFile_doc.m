%% Syntax
%       fitness_params= createDefaultfitness_paramsFile(plant_id)
%
%% Description
% |fitness_params= createDefaultfitness_paramsFile(plant_id)| creates the
% |xml| file |fitness_params__plant_id_.xml| with default params.
% These params are used inside fitness functions and define lower and upper
% boundaries of process values as well as weighting factors used inside the
% fitness function. The used fitness function is defined here as well. 
%
%% <<plant_id/>>
%%
% @return |fitness_params| : C# object of class |biooptim.fitness_params|
% containing the params needed in fitness functions. For more information
% see <matlab:docsearch('Definition,of,fitness_params') here>. 
%
%% Example
%
%

createDefaultfitness_paramsFile('gummersbach')

delete('fitness_params_gummersbach.xml');

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
% <a href="matlab:doc('biogas_scripts/is_fitness_params')">
% biogas_scripts/is_fitness_params</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/fitness_costs')">
% biogas_blocks/fitness_costs</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/fitness_sensor')">
% biogas_blocks/fitness_sensor</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/findoptimalequilibrium')">
% biogas_optimization/findOptimalEquilibrium</a>
% </html>
% ,
% <html>
% <a href="createvolumeflowfile.html">
% createvolumeflowfile</a>
% </html>
% ,
% <html>
% <a href="createinitstatefile.html">
% createinitstatefile</a>
% </html>
%
%% TODOs
% # check documentation
%
%% <<AuthorTag_DG/>>


