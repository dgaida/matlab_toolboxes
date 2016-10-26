%% Syntax
%       vflows= get_volumeflows_at_time(t, plant_id, vol_type)
%       [...]= get_volumeflows_at_time(t, plant_id, vol_type, accesstofile) 
%       
%% Description
% |vflows= get_volumeflows_at_time(t, plant_id, vol_type)| gets volumeflows
% of plant at time |t| out of volumeflow variables or files (see param
% |accesstofile|). 
%
%%
% @param |t| : double scalar with the time measured in days the volumeflow
% should be returned. 
%
%% <<plant_id/>>
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
% @return |vflows| : double vector with volumeflows for each substrate at
% given time |t|, or nearest possible to |t|.
%
%% Example
%
% # Example: load volumeflows from file
%

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

% load from file
get_volumeflows_at_time(5, 'gummersbach', 'const')

get_volumeflows_at_time(-1, 'gummersbach', 'const')

get_volumeflows_at_time(500, 'gummersbach', 'const')


%%
% # Example

Q= [1 .* rand(5, 1) 2 .* rand(5, 1) 3 .* rand(5, 1) 4 .* rand(5, 1) ...
    5 .* rand(5, 1) 6 .* rand(5, 1) 7 .* rand(5, 1)];

% create in workspace  
create_volumeflow_files(Q, 'sunderhook', 0, 'user', 1);

% load from workspace
get_volumeflows_at_time(0, 'sunderhook', 'user', 0)

get_volumeflows_at_time(6, 'sunderhook', 'user', 0)


%%
% # Example 

vflows= get_volumeflows_at_time(20, 'sunderhook', 'user', 0);

% create const files in workspace again
create_volumeflow_files(vflows, 'sunderhook', 0, 'const');

% look at the variables in the workspace
who('volumeflow_*_const')


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('matlab/fieldnames')">
% matlab/fieldnames</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/get_nearest_el_in_vec')">
% script_collection/get_nearest_el_in_vec</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_volumeflows_from')">
% biogas_scripts/get_volumeflows_from</a>
% </html>
%
% and is called by:
%
% (the user)
% 
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_scripts/plot_volumeflow_files')">
% biogas_scripts/plot_volumeflow_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_volumeflows_sludge_from')">
% biogas_scripts/get_volumeflows_sludge_from</a>
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
% # could add save to const file option
%
%% <<AuthorTag_DG/>>


