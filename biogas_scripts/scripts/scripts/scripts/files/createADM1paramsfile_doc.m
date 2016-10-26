%% Syntax
%       createADM1paramsfile(plant_id)
%       createADM1paramsfile(plant_id, path_to_folder)
%      
%% Description
% |createADM1paramsfile(plant_id)| creates the file
% |adm1_params_opt__plant_id_.mat| for the given |plant_id|. As default the  
% file is created in the subfolder |plant_id| inside the |config_mat| folder
% obtained calling <matlab:doc('getconfigpath') getConfigPath>.
% Inside this file the default free ADM1 parameters for each digester
% inside the plant are written. The default free ADM1 parameters are defined
% in <matlab:doc('biogas_calibration/calib_getdefaultadm1params')
% calib_getDefaultADM1params>. 
%
% Remark: The file is only created if it is not yet existent!!!
%
%%
% @param |plant_id| : char with the id of the plant == plant__plant_id_.id
%
%%
% |createADM1paramsfile(plant_id, path_to_folder)| lets you specify where
% the mat file should be saved. 
%
%%
% @param |path_to_folder| : char with the path to the folder in which the
% |adm1_params_opt__plant_id_.mat| is created. As default the file is
% created in the subfolder |plant_id| inside the |config_mat| folder
% obtained calling <matlab:doc('getconfigpath') getConfigPath>. 
%
%% Example
%
% 

createADM1paramsfile('gummersbach', pwd)

delete('adm1_params_opt_gummersbach.mat');


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_calibration/calib_getdefaultadm1params')">
% biogas_calibration/calib_getDefaultADM1params</a>
% </html>
% ,
% <html>
% <a href="load_biogas_mat_files.html">
% load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('getconfigpath')">
% getConfigPath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/save')">
% matlab/save</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_calibration/calib_biogasplantparams')">
% biogas_calibration/calib_BiogasPlantParams</a>
% </html>
%
%% See Also
%
% <html>
% <a href="createvolumeflowfile.html">
% createvolumeflowfile</a>
% </html>
% ,
% <html>
% <a href="createinitstatefile.html">
% createinitstatefile</a>
% </html>
%
%% TODOs
%
%
%% <<AuthorTag_ALSB/>>


