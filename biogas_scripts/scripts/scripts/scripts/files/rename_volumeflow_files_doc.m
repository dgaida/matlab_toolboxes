%% Syntax
%       rename_volumeflow_files(plant_id, id_old, id_new)
%       rename_volumeflow_files(plant_id, id_old, id_new, do_backup)
%       rename_volumeflow_files(plant_id, id_old, id_new, do_backup,
%       flow_type) 
%       rename_volumeflow_files(plant_id, id_old, id_new, do_backup,
%       flow_type, keep_orgs) 
%       
%% Description
% |rename_volumeflow_files(plant_id, id_old, id_new)| renames volumeflow
% files by adding, replacing or deleting ids. The files of the plant with
% the ID |plant_id| are load and changed accordingly. The currently
% existing files must have the ids |id_old|. The id will be changed to
% |id_new|. All substrate feed and pumped sludge volumeflow mat files are
% changed. If one of the files that should exist, do not, then an error is
% thrown. 
%
%%
% @param |plant_id| : char with the id of the simulation model of the
% biogas plant. The plant's id is defined in the object |plant| and has 
% to be set in the simulation model, which is
% <matlab:doc('develop_model_stepbystep') created> 
% using the toolbox's library. 
%
%%
% @param |id_old| : current id of volumeflow files. If they have no id,
% then this parameter must be empty. 
%
%%
% @param |id_new| : new id of volumeflow files. If the new volumeflow files
% should not have an id, then this parameter must be empty. 
%
%%
% @param |do_backup| : if 1, then backups of the currently existing files
% are created. Default: 0.
%
% * 0 : do not create backups
% * 1 : create backups. backups are named with the extension '_copy'
%
%%
% @param |flow_type| : defines which volumeflow files are changed. Default:
% 'user'. 
%
% * 'const' : constant volumeflow files: 'volumeflow_..._const.mat'
% * 'user' : 'volumeflow_..._user.mat'
% * 'random' : 'volumeflow_..._random.mat'
%
%%
% @param |keep_orgs| : 0 or 1
%
% * 0 : do not keep original volumeflow files, so really rename them.
% Default. 
% * 1 : keep original volumeflow files. So create copies with the new name.
%
%% Example
%
% 

cd( fullfile( getBiogasLibPath(), 'examples/nmpc/Gummersbach' ) );

%%

rename_volumeflow_files('gummersbach', [], 1, 0, 'const')

%%

rename_volumeflow_files('gummersbach', 1, [], 0, 'const')

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
% <a href="matlab:doc('matlab/movefile')">
% matlab/movefile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/getnumdigestersplits')">
% biogas_scripts/getNumDigesterSplits</a>
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


