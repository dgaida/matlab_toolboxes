%% Syntax
%       create_pwc_volumeflows(plant_id, Q_start, Q_end, timespan,
%       num_steps) 
%       create_pwc_volumeflows(plant_id, Q_start, Q_end, timespan,
%       num_steps, accesstofile) 
%       create_pwc_volumeflows(plant_id, Q_start, Q_end, timespan,
%       num_steps, accesstofile, do_plots) 
%
%% Description
% |create_pwc_volumeflows(plant_id, Q_start, Q_end, timespan, num_steps)|
% creates stepwise constant user volumeflows for given plant |plant_id|
% between start |Q_start| and end |Q_end| volumeflow values. 
%
%% <<plant_id/>>
%%
% @param |Q_start| : double vector with initial volumeflow of all
% substrates on plant. Must have as many values as there are substrates on
% the plant. Values are measured in m³/d. 
%
%%
% @param |Q_end| : double vector with final volumeflow of all
% substrates on plant. Must have as many values as there are substrates on
% the plant. Values are measured in m³/d. 
%
%%
% @param |timespan| : the duration in days during which substrate feed is
% changed from |Q_start| to |Q_end|. 
%
%%
% @param |num_steps| : number of feed steps over the |timespan|. 
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
% @param |do_plots| : 0 or 1
%
% * 0 do not make plots (default)
% * 1 do make plots of created user files
%
%% Example
% 
%

Q_start= [1 2 3];
Q_end=   [10 20 30];

create_pwc_volumeflows('gummersbach', Q_start, Q_end, 50, 4, 0, 1);


%%

create_pwc_volumeflows('gummersbach', Q_start, Q_end, 50, 1, 0, 1);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
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
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/plot_volumeflow_files')">
% biogas_scripts/plot_volumeflow_files</a>
% </html>
%
% and is called by:
%
% (the user)
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

    
