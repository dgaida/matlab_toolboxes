%% Syntax
%       create_volumeflow_files_user(plant_id, time, Q)
%
%% Description
% |create_volumeflow_files_user(plant_id, time, Q)| creates volumeflow user
% mat files for given plant |plant_id|. The volumeflow_..._user.mat files
% will have the volumetric flowrates given in |Q| at the time instances
% given by |time|. In contrast to
% <matlab:doc('biogas_scripts/create_volumeflow_files') 
% biogas_scripts/create_volumeflow_files> here a user defined time grid can
% be used, instead of a uniform time grid. 
%
%% <<plant_id/>>
%%
% @param |time| : a time vector with increasing time instances measured in
% days. To each value in the columns of |Q| there must be two values in this
% vector, specifying the start and end time of the corresponding value in
% |Q|.
%
%%
% @param |Q| : a double matrix with the volumetric flowrates of each
% substrate over the time given by the vector |time|. The matrix must have
% as many columns as there are substrates and half as many rows as there
% are elements in the vector |time|. 
%
%% Example
% 
% # Create volumeflow files
%

init_feed= [15,   10, 0,  2,   0, 0, 0, 0, 0, 0];

myQ1= [init_feed; ...
       95    95  0  45    0  0  0  0  0  0; ...
        0,   10, 0,  0,   0, 0, 0, 0, 0, 0; ...
       18.4, 15, 0,  1.2, 0, 0, 0, 0, 0, 0];

myt= 100;
myt1= [0, 750, 751, 750 + myt, 750 + myt + 1, 750 + myt + 100, ...
       750 + myt + 101, 1500 + myt]; 

create_volumeflow_files_user('geiger', myt1, myQ1)

%%
%

ls('volumeflow_*_user.mat')

%%
% clean up

del_volumeflow_files('geiger', 'user');

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/save_varname')">
% script_collection/save_varname</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isrn')">
% script_collection/isRn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_mat_files')">
% biogas_scripts/load_biogas_mat_files</a>
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
% <a href="matlab:doc('biogas_scripts/createvolumeflowfile')">
% biogas_scripts/createvolumeflowfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/create_volumeflow_files')">
% biogas_scripts/create_volumeflow_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_volumeflows_at_time')">
% biogas_scripts/get_volumeflows_at_time</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/create_rand_signal')">
% data_tool/create_rand_signal</a>
% </html>
%
%% TODOs
% # improve documentation a bit
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>

    
