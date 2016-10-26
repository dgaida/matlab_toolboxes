%% Syntax
%       [plant_ids]= findExistingPlants()
%       [plant_ids]= findExistingPlants(plant_ids)
%       [plant_ids]= findExistingPlants(plant_ids, plant_names)
%       [plant_ids]= findExistingPlants(plant_ids, plant_names, p_index)
%       [plant_ids, plant_names]= findExistingPlants(...)
%       [plant_ids, plant_names, path_config_mat]= findExistingPlants(...)
%       [plant_ids, plant_names, path_config_mat, path_to_file]=
%       findExistingPlants(...) 
%
%% Description
%
% |[plant_ids]= findExistingPlants()| searches the
% <matlab:doc('getconfigpath') config_mat> folder and returns all
% plant ids found in the folder. 
%
%%
% @return |plant_ids| : <matlab:doc('matlab/cellstr') cell array of chars>
% containing the found plant IDs 
%
%%
% |[plant_ids]= findExistingPlants(plant_ids)| the found ids are
% concatenated to the given char-cell array |plant_ids|.
%
%%
% @param |plant_ids| : extended cell array of chars containing the found
% plant IDs 
%
%%
% |[plant_ids]= findExistingPlants((plant_ids, plant_names)| the found
% plant names are concatenated to the given char-cell array |plant_names|.
%
%%
% @param |plant_names| : cell array of chars containing plant names
%
%%
% @param |p_index| : double value: 1,2,3... If you use |path_to_file| as
% return value, then the path to the |p_index|th found plant id is
% returned. 
%
%%
% |[plant_ids, plant_names]= findExistingPlants(...)| additionally returns
% all plant names found in the folder.
%
%%
% @return |plant_names| : cell array of chars containing plant names
%
%%
% |[plant_ids, plant_names, path_config_mat]= findExistingPlants(...)| also
% returns the path to the 'config_mat' folder and returns it via
% |path_config_mat|.
%
%%
% @return |path_config_mat| : path to the 'config_mat' folder
%
%%
% @return |path_to_file| : if you pass |p_index| then the path to the
% |p_index|th found plant id is returned.
%
%% Example
% 
% find available plant ids in toolbox.

[plant_ids, plant_names]= findExistingPlants();

disp(plant_ids)
disp(plant_names)

%%
%

[plant_ids, plant_names, path_config_mat, path_to_file]= ...
            findExistingPlants([], [], 2);
          
disp(path_config_mat)
disp(path_to_file)


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
% <a href="matlab:doc('ls')">
% matlab/ls</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('dir')">
% matlab/dir</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_gui/gui_plant')">
% biogas_gui/gui_plant</a>
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
% <a href="loadplantstructure.html">
% loadPlantStructure</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('getbiogaslibpath')">
% getBiogasLibPath</a>
% </html>
%
%% TODOs
% # improve documentation, create docu for script file
%
%% <<AuthorTag_DG/>>


