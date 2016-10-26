%% Syntax
%       sensors= set_sensors_sampling_time(plant_id, sampling_time)
%       
%% Description
% |sensors= set_sensors_sampling_time(plant_id, sampling_time)| sets
% |sampling_time| in sensors xml file, loads and saves the file. 
%
%% <<plant_id/>>
%%
% @param |sampling_time| : sampling time in days
%
%%
% @return |sensors| : sensors object with given sampling time
%
%% Example
%
%

set_sensors_sampling_time('gummersbach', 0.5);

%%
% clean up

delete('sensors_gummersbach.xml');

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_mat_files')">
% biogas_scripts/load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_path2xml_configfile')">
% biogas_scripts/get_path2xml_configfile</a>
% </html>
% 
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_control/startnmpcatequilibrium')">
% biogas_control/startNMPCatEquilibrium</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc('biogas_blocks/create_sensor_network')">
% biogas_blocks/create_sensor_network</a>
% </html>
%
%% TODOs
% # check documentation
% # improve documentation a bit
%
%% <<AuthorTag_DG/>>


