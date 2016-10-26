%% Syntax
%       volumeflows= get_volumeflows_sludge_from(plant, plant_network,
%       plant_network_max, vol_type) 
%       volumeflows= get_volumeflows_sludge_from(plant, plant_network,
%       plant_network_max, vol_type, accesstofile) 
%       volumeflows= get_volumeflows_sludge_from(plant, plant_network,
%       plant_network_max, vol_type, accesstofile, mypath) 
%       
%% Description
% |volumeflows= get_volumeflows_sludge_from(plant, plant_network,
% plant_network_max, vol_type)| gets sludge volumeflows from file or
% workspace. As default volumeflow_..._|type|.mat 
% files are load from the pwd (see params |accesstofile| and |mypath|). 
%
%% <<plant/>>
%% <<plant_network/>>
%% <<plant_network_max/>>
%%
% @param |vol_type| : char, defining the type of volumeflow. 
%
% * 'random' : random volumeflow. Here the volumeflow is generated using
% uniformly distributed pseudorandom numbers. 
% * 'const' : constant volumeflow. the volumeflow is constant. 
% * 'user' : user defined volumeflow. 
%
%%
% @param |accesstofile| : double scalar
%
% * 1 : if 1, then really load data from a file, 
% * 0 : if set to 0, then data isn't load from a file, but is load from the 
% base workspace (better for optimization purpose -> speed)
%
%%
% @param |mypath| : char with the path where the files should be load from.
% Default: <matlab:doc('pwd') pwd>. 
%
%%
% @return |volumeflows| : struct containing all volumeflow variables
%
%% Example
%
% # Example: load volumeflows from file

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

[plant, plant_network, plant_network_max]= load_biogas_mat_files('gummersbach', [], ...
  {'plant', 'plant_network', 'plant_network_max'});

% load from file
get_volumeflows_sludge_from(plant, plant_network, plant_network_max, 'const')


%%
% # Example

[plant, plant_network, plant_network_max]= load_biogas_mat_files('gummersbach', [], ...
  {'plant', 'plant_network', 'plant_network_max'});

Q= 1 .* rand(5, 1);

% create in workspace  
create_volumeflow_sludge_files(Q, 'sunderhook', 0, 'user', 1);

% load from workspace
get_volumeflows_sludge_from(plant, plant_network, plant_network_max, 'user', 0)



%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('matlab/load')">
% matlab/load</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/evalin')">
% matlab/evalin</a>
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
% <a href="matlab:doc('biogas_scripts/load_volumeflow_files')">
% biogas_scripts/load_volumeflow_files</a>
% </html>
% 
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_scripts/plot_volumeflow_files')">
% biogas_scripts/plot_volumeflow_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_volumeflows_from')">
% biogas_scripts/get_volumeflows_from</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/create_volumeflow_files')">
% biogas_scripts/create_volumeflow_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/create_volumeflow_sludge_files')">
% biogas_scripts/create_volumeflow_sludge_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/createvolumeflowfile')">
% biogas_scripts/createvolumeflowfile</a>
% </html>
%
%% TODOs
% # improve documentation
% # check appearance of documentation
% # extend with id_write/id_read. 
%
%% <<AuthorTag_DG/>>


