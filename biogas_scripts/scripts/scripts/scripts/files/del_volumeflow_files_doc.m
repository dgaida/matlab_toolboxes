%% Syntax
%       del_volumeflow_files(plant_id, type)
%       del_volumeflow_files(plant_id, type, id_write)
%
%% Description
% |del_volumeflow_files(plant_id, type)| deletes all const (see param
% |type|) substrate volumeflow files for the given plant |plant_id|.
%
%% <<plant_id/>>
%%
% @param |type| : char, defining the type of volumeflow. 
%
% * 'random' : random volumeflow. 
% * 'const' : constant volumeflow. 
% * 'user' : user defined volumeflow.  
%
%%
% @param |id_write| : select the id of the *.mat files that will
% be deleted; e.g. |id_write == 1| leads to deleting e.g. 
% volumeflow_bullmanure_user_1.mat. 
% If empty, the standard is: volumeflow_bullmanure_user.mat. integer. 
%
%% Example
% 

Q= [1 2 3];

create_volumeflow_files(Q, 'gummersbach', 1);

what

%%
% clean up

del_volumeflow_files('gummersbach', 'const');

what

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
% <a href="matlab:doc('script_collection/isn0')">
% script_collection/isN0</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/delete')">
% matlab/delete</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
%
% <html>
% <a href="createinitstatefile.html">
% createinitstatefile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/create_volumeflow_files')">
% biogas_scripts/create_volumeflow_files</a>
% </html>
% ,
% <html>
% <a href="createvolumeflowfile.html">
% createvolumeflowfile</a>
% </html>
%
%% TODOs
% # improve documentation a little
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>

    
