%% Syntax
%       save_volumeflows_from_ws2file(plant_id, vol_type)
%       save_volumeflows_from_ws2file(plant_id, vol_type, do_backup)
%       save_volumeflows_from_ws2file(plant_id, vol_type, do_backup, mypath)
%       
%% Description
% |save_volumeflows_from_ws2file(plant_id, vol_type)| saves volumeflow
% variables existing in workspace to mat file. At the moment this only
% affects substrate volumeflow variables. It goes through all possible
% variable names, e.g. 'volumeflow_manure_user', if it exists then it is
% saved to a mat file with the same name. If it does not exist an error
% message is displayed and the next substrate is processed. 
%
%% <<plant_id/>>
%%
% @param |vol_type| : defines which volumeflow files are created. 
%
% * 'const' : constant volumeflow files: 'volumeflow_..._const.mat'
% * 'user' : 'volumeflow_..._user.mat'
% * 'random' : 'volumeflow_..._random.mat'
%
%%
% @param |do_backup| : if 1, then backups of the currently existing files
% are created. Default: 0.
%
% * 0 : do not create backups
% * 1 : create backups. backups are named with the extension '_copy'
%
%%
% @param |mypath| : char with the path where the files should be created.
% Default: <matlab:doc('pwd') pwd>. 
%
%% Example
%
% 

% create variables

volumeflow_maize_user= [0 10 20 30; 5 4 3 3];
volumeflow_grass_user= [0 10 30 40; 15 4 33 3];

save_volumeflows_from_ws2file('gummersbach', 'user')

% clean up

delete('volumeflow_maize_user.mat');
delete('volumeflow_grass_user.mat');


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
% <a href="matlab:doc('biogas_scripts/is_volumeflow_type')">
% biogas_scripts/is_volumeflow_type</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant_id')">
% biogas_scripts/is_plant_id</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/copyfile')">
% matlab/copyfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/save_varname')">
% script_collection/save_varname</a>
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
% <a href="matlab:doc('biogas_scripts/load_volumeflow_files')">
% biogas_scripts/load_volumeflow_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_volumeflows_from')">
% biogas_scripts/get_volumeflows_from</a>
% </html>
%
%% TODOs
% # improve documentation a little
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


