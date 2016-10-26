%% Syntax
%       create_volumeflow_files(Q, plant_id)
%       create_volumeflow_files(Q, plant_id, accesstofile)
%       create_volumeflow_files(Q, plant_id, accesstofile, type)
%       create_volumeflow_files(Q, plant_id, accesstofile, type,
%       user_deltatime) 
%
%% Description
% |create_volumeflow_files(Q, plant_id)| creates all const (see param
% |type|) substrate volumeflow files for the given plant |plant_id|.
% Therefore, |Q| must contain the feed values of each substrate. 
%
%%
% @param |Q| : may be a vector or matrix. If matrix, then number of columns
% must be equal to number of substrates on plant. The number of rows define
% the volumeflow values with sampling time |user_deltatime|. If it is a
% vector, then its dimension must be equal to number of substrates on
% plant |plant_id|. 
%
%% <<plant_id/>>
%%
% |create_volumeflow_files(Q, plant_id, accesstofile)| 
%
%%
% @param |accesstofile| : 
%
% * 1 : if 1, then really save the data to a file. 
% * 0 : if set to 0, then the data isn't saved to a file, but is saved to
% the base workspace (better for optimization purpose -> speed) 
% * -1 : if it is -1, then save the data not to the workspace but to the
% model workspace. In the newest MATLAB versions, from 7.11 on, it is not
% allowed anymore to save into the modelworkspace while the model is
% running. So then we save to a file using <matlab:doc('save')
% matlab/save>. In case we are running the models in parallel, then to the
% filename an integer is appended, this is the integer of the currently
% load model. 
%
%%
% @param |type| : char, defining the type of volumeflow. Default: 'const'. 
%
% * 'random' : random volumeflow. Here the volumeflow is generated using
% uniformly distributed pseudorandom numbers ranging from 0 to |Q|. 
% * 'const' : constant volumeflow. the volumeflow is constant = |Q|. 
% * 'user' : user defined volumeflow. It is not possible to call this
% function with four arguments and using this option, because
% |user_deltatime| must be given as well. 
%
%%
% @param |user_deltatime| : time duration between the given entries in the
% |Q| matrix measured in days, double scalar. 
%
%%
% @param |user_unit| : defines the unit of the input data: 
%
% * 'kg_day' for kg/day or 
% * 'm3_day' for m³/day (default)
%
% the output data has always the unit [m^3/day]
%
%% Example
% 
% # Create volumeflow const variables in workspace
%

Q= [1 2 3 4 5 6 7];

create_volumeflow_files(Q, 'sunderhook', 0);

who


%% 
% # Create volumeflow const variables in workspace
%

Q= [1 2 3 4 5 6 7];   % Q in kg/day

create_volumeflow_files(Q, 'sunderhook', 0, [], [], 'kg_day');

who


%%
% # Create volumeflow user variables in workspace
%

Q= [1 .* rand(5, 1) 2 .* rand(5, 1) 3 .* rand(5, 1) 4 .* rand(5, 1) ...
    5 .* rand(5, 1) 6 .* rand(5, 1) 7 .* rand(5, 1)];

create_volumeflow_files(Q, 'sunderhook', 0, 'user', 1);

who


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_mat_files')">
% biogas_scripts/load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/createvolumeflowfile')">
% biogas_scripts/createvolumeflowfile</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="get_feed_oo_equilibrium_and_save_to.html">
% biogas_scripts/get_feed_oo_equilibrium_and_save_to</a>
% </html>
%
%% See Also
%
% <html>
% <a href="del_volumeflow_files.html">
% biogas_scripts/del_volumeflow_files</a>
% </html>
% ,
% <html>
% <a href="createinitstatefile.html">
% biogas_scripts/createinitstatefile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/create_rand_signal')">
% data_tool/create_rand_signal</a>
% </html>
% ,
% <html>
% <a href="createtimeseriesfile.html">
% createtimeseriesfile</a>
% </html>
%
%% TODOs
% # improve documentation
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>

    
