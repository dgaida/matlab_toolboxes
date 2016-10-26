%% Syntax
%       path2xml= get_path2xml_configfile(plant_id, filename_pattern)
%       path2xml= get_path2xml_configfile(plant_id, filename_pattern, setting)
%       
%% Description
% |path2xml= get_path2xml_configfile(plant_id, filename_pattern)| gets path
% to any xml config file (substrate, plant, fitness_params, sensors, ...). 
%
%% <<plant_id/>>
%%
% @param |filename_pattern| : char. Examples are: 'substrate_%s.xml',
% 'plant_%s.xml', 'sensors_%s.xml'. 
%
%%
% @param |setting| : char which can specify a subfolder. Default: id of
% plant: |plant_id|. 
%
%%
% @return |path2xml| : path to the by |filename_pattern| specified file. 
%
%% Example
%
% 

get_path2xml_configfile('gummersbach', 'substrate_%s.xml')

%%

get_path2xml_configfile('koeln', 'fitness_params_%s.xml')

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('matlab/fullfile')">
% matlab/fullfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogaslibrary/getconfigpath')">
% biogaslibrary/getConfigPath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant_id')">
% biogas_scripts/is_plant_id</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_mat_files')">
% biogas_scripts/load_biogas_mat_files</a>
% </html>
% 
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_scripts/get_initstate_outof_equilibrium')">
% biogas_scripts/get_initstate_outof_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/save_initstate_to')">
% biogas_scripts/save_initstate_to</a>
% </html>
%
%% TODOs
% # improve documentation a little
% # check appearance of documentation
% # update see also
%
%% <<AuthorTag_DG/>>


