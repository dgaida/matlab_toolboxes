%% Syntax
%       copy_volumeflow_files(plant_id, pathfrom, path2)
%       copy_volumeflow_files(plant_id, pathfrom, path2, vol_type)
%       copy_volumeflow_files(plant_id, pathfrom, path2, vol_type,
%       id_write) 
%       copy_volumeflow_files(plant_id, pathfrom, path2, vol_type,
%       id_write, do_backup) 
%
%% Description
% |copy_volumeflow_files(plant_id, pathfrom, path2)| copies volumeflow
% files of given plant |plant_id| between the two paths from |pathfrom| to
% |path2|. 
%
%% <<plant_id/>>
%%
% @param |pathfrom| : path where to copy from. char.
%
%%
% @param |path2| : path where to copy to. char. can also be a relative path,
% see example. 
%
%%
% @param |vol_type| : char, defining the type of volumeflow. 
%
% * 'random' : random volumeflow. 
% * 'const' : constant volumeflow. 
% * 'user' : user defined volumeflow.  
%
%%
% @param |id_write| : select the id of the *.mat files that will
% be copied; e.g. |id_write == 1| leads to copying e.g. 
% volumeflow_bullmanure_user_1.mat. 
% If empty, the standard is: volumeflow_bullmanure_user.mat. integer. 
%
%%
% @param |do_backup| : if 1, then backups of the currently existing files
% are created. Default: 0.
%
% * 0 : do not create backups
% * 1 : create backups. backups are named with the extension '_copy'
%
%% Example
% 

cd( fullfile( getBiogasLibPath(), 'examples/nmpc/Gummersbach' ) );

%%

copy_volumeflow_files('gummersbach', pwd, '..', 'const')

cd('..')

ls('volumeflow_*_const.mat')

%%
% clean up

del_volumeflow_files('gummersbach', 'const');

ls('volumeflow_*_const.mat')


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant_id')">
% biogas_scripts/is_plant_id</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_volumeflow_type')">
% biogas_scripts/is_volumeflow_type</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_mat_files')">
% biogas_scripts/load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/copyfile')">
% matlab/copyfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/fullfile')">
% matlab/fullfile</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
%
% <html>
% <a href="rename_volumeflow_files.html">
% biogas_scripts/rename_volumeflow_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/create_volumeflow_files')">
% biogas_scripts/create_volumeflow_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/save_volumeflows_from_ws2file')">
% biogas_scripts/save_volumeflows_from_ws2file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/plot_volumeflow_files')">
% biogas_scripts/plot_volumeflow_files</a>
% </html>
% ,
% <html>
% <a href="createvolumeflowfile.html">
% biogas_scripts/createvolumeflowfile</a>
% </html>
%
%% TODOs
% # improve documentation
% # check appearance of documentation
% # soll sich id_write nur auf quelle oder auch auf ziel beziehen? evtl. 2
% parameter nutzen. ansonsten kann man in ziel auch rename_volumeflow_files
% aufrufen. aktuell bezieht es sich auf beides. erstmal so lassen, mal
% schauen
%
%% <<AuthorTag_DG/>>

    
