%% Syntax
%       volumeflowfiles_append(plant_id, substrate_feed, shift)
%       volumeflowfiles_append(plant_id, substrate_feed, shift, id_write)
%       volumeflowfiles_append(plant_id, substrate_feed, shift, id_write,
%       position) 
%       volumeflowfiles_append(plant_id, substrate_feed, shift, id_write,
%       position, start_time) 
%
%% Description
% |volumeflowfiles_append(plant_id, substrate_feed, shift)| appends
% given volumeflow |substrate_feed| to all substrate volumeflow user files
% of given plant |plant_id|. 
%
%% <<plant_id/>>
%%
% @param |substrate_feed| : double vector with as many rows as there are
% substrates on the plant. Values are volumeflow for each substrate in
% m³/d. 
%
%%
% @param |shift| : double scalar, measured in days. By this amount of time
% the time values in the existing volumeflow user files are shifted. 
%
%%
% @param |id_write| : select the id of the *.mat files that will
% be append; e.g. |id_write == 1| leads to append e.g. to the file
% volumeflow_bullmanure_user_1.mat. 
% If empty, the standard is: volumeflow_bullmanure_user.mat. integer. 
%
%%
% @param |position| : char, defining the position where to append |values|
% in file. Default: 'start'
%
% * 'start' : at the start. The already existing values are shifted in time
% by the next higher integer after the value |shift|. See the example. 
% * 'end' : at the end. The given values |substrate_feed| are added at time
% |shift|. Therefore, |shift| must be higher as the end of the time values
% saved in the load volumeflow file. Otherwise an error is thrown. 
%
%%
% @param |start_time| : real number. Only used if |position == 'start'|.
% This is the time value written in the file before the number |shift|. Can
% be 0. Default: |shift - 1|.
%
%% Example
% 
% first create some files

Q= [1 2 3; 4 5 6; 7 8 9]';

create_volumeflow_files(Q, 'gummersbach', 1, 'user', 1);

%%
% plot variables to see the originals

substrate= load_biogas_mat_files('gummersbach');

plot_volumeflow_files('substrate', 'user', substrate);

%%
% change the files

volumeflowfiles_append('gummersbach', [3 2 1], 7.5);

%%
% plot variables again to see the change

plot_volumeflow_files('substrate', 'user', substrate);

%%
% change the files

volumeflowfiles_append('gummersbach', [5 6 7], 20.5, [], 'end');

%%
% plot variables again to see the change

plot_volumeflow_files('substrate', 'user', substrate);

%%
% clean up

del_volumeflow_files('gummersbach', 'user');


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
% <a href="matlab:doc('biogas_scripts/volumeflowfile_append')">
% biogas_scripts/volumeflowfile_append</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isrn')">
% script_collection/isRn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant_id')">
% biogas_scripts/is_plant_id</a>
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
% <a href="matlab:doc('biogas_scripts/create_volumeflow_files')">
% biogas_scripts/create_volumeflow_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/rename_volumeflow_files')">
% biogas_scripts/rename_volumeflow_files</a>
% </html>
% ,
% <html>
% <a href="createvolumeflowfile.html">
% createvolumeflowfile</a>
% </html>
% ,
% <html>
% <a href="plot_volumeflow_files.html">
% plot_volumeflow_files</a>
% </html>
%
%% TODOs
% # improve documentation
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>

    
