%% Syntax
%       Qtot= get_volumeflow_total_at_time(t, plant_id, vol_type)
%       [...]= get_volumeflow_total_at_time(t, plant_id, vol_type, accesstofile) 
%       
%% Description
% |Qtot= get_volumeflow_total_at_time(t, plant_id, vol_type)| gets total
% substrate feed of plant |plant_id| at given time |t|. 
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
% @return |Qtot| : double scalar with sum of volumeflows of all substrates at
% given time |t|, or nearest possible to |t|.
%
%% Example
%
% # Example: load volumeflows from file
%

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

% load from file
get_volumeflow_total_at_time(5, 'gummersbach', 'const')

get_volumeflow_total_at_time(-1, 'gummersbach', 'const')

get_volumeflow_total_at_time(500, 'gummersbach', 'const')


%%
% # Example

Q= [1 .* rand(5, 1) 2 .* rand(5, 1) 3 .* rand(5, 1) 4 .* rand(5, 1) ...
    5 .* rand(5, 1) 6 .* rand(5, 1) 7 .* rand(5, 1)];

% create in workspace  
create_volumeflow_files(Q, 'sunderhook', 0, 'user', 1);

% load from workspace
get_volumeflow_total_at_time(0, 'sunderhook', 'user', 0)

get_volumeflow_total_at_time(6, 'sunderhook', 'user', 0)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('matlab/sum')">
% matlab/sum</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_volumeflows_at_time')">
% biogas_scripts/get_volumeflows_at_time</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_scripts/get_volumeflow_total')">
% biogas_scripts/get_volumeflow_total</a>
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
%
%% <<AuthorTag_DG/>>


