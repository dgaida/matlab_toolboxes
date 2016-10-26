%% Syntax
%       [plant]= loadPlantStructure(plant_id)
%       [plant]= loadPlantStructure(plant_name)
%       [plant, path_to_file]= loadPlantStructure(...)
%       [plant, path_to_file, path_config_mat]= loadPlantStructure(...)
%
%% Description
% |[plant]= loadPlantStructure(plant_id)| loads the file
% |plant__plant_id_.xml|.
%
%%
% @param |plant_id| : char or cell containing the ID of the plant
%
%%
% |[plant]= loadPlantStructure(plant_name)| loads the plant structure
% belonging to the plant's name.
%
%%
% @param |plant_name| : char or cell with the name of the plant
%
%%
% |[plant, path_to_file]= loadPlantStructure(...)|
%
%%
% @return |path_to_file| : 
%
%%
% |[plant, path_to_file, path_config_mat]= loadPlantStructure(...)|
%
%%
% @return |path_config_mat| : returns the path to the <../../../../config_mat
% |config_mat|> folder. 
%
%% Example
% 

[plant, path_config_mat]= loadPlantStructure('gummersbach');

loadPlantStructure('Gummersbach');
 
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('getconfigpath')">
% getConfigPath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('dir')">
% matlab/dir</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ls')">
% matlab/ls</a>
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
% <a href="matlab:doc('biogas_gui/gui_nmpc')">
% biogas_gui/gui_nmpc</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_gui/gui_optimization')">
% biogas_gui/gui_optimization</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_gui/gui_showoptimresults')">
% gui_showOptimResults</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_gui/set_input_stream')">
% biogas_gui/set_input_stream</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_gui/set_input_stream_min_max')">
% biogas_gui/set_input_stream_min_max</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="findexistingplants.html">
% findExistingPlants</a>
% </html>
%
%% TODOs
% # improve documentation
% # go through code
%
%% <<AuthorTag_DG/>>


