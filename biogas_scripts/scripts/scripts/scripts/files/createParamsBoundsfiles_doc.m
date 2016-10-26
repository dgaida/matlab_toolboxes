%% Syntax
%       createParamsBoundsfiles(plant_id)
%       createParamsBoundsfiles(plant_id, calib_type)
%       createParamsBoundsfiles(plant_id, calib_type, calib_opt)
%      
%% Description
% |createParamsBoundsfiles(plant_id)| creates the files
% |params_min__plant_id_.mat| and |params_max__plant_id_.mat| for the given
% |plant_id|. On the one hand it creates both files inside the subfolder
% |plant_id| inside the |config_mat| folder of the toolbox (see
% <matlab:doc('getconfigpath') getConfigPath>) with the default free ADM1
% parameters gotten from
% <matlab:doc('biogas_calibration/calib_getdefaultadm1params')
% calib_getDefaultADM1params>. 
%
%%
% @param |plant_id| : char with the id of the plant == plant__plant_id_.id
%
%%
% |createParamsBoundsfiles(plant_id, calib_type)| furthermore writes the
% files |params_min__plant_id_.mat| and |params_max__plant_id_.mat| also in
% the present working directory. The content of both files is defined by
% the arguments |calib_type| and |calib_opt|. Both files are only written
% when they do not exist yet. This gives the user the chance to define both
% files manually before calling the calibration function. 
%
%%
% @param |calib_type| : type of parameters to be used in the default or 
% user defined scenario. The default value is []. 
% 
% * 'default' : default parameter ranges. If you use this value, then the
% next argument |calib_opt| must be a double scalar, defining the
% percentage value to be incremented (param_max) and decremented  
% (param_min) according to the default values.
% * 'user' : user defined parameter ranges. If you use this value, then the
% next argument |calib_opt| must be a double matrix containing the
% parameter ranges M[max, min] 
% * [] : then only in the config_mat subfolder the params_min/max files are
% created and not in the current folder (Default)
%
%%
% @param |calib_opt| : defines parameter ranges default or user defined
% 
% * 0.1 : percentage value to be incremented (param_max) and decremented 
% (param_min) according to the default values.
% * user : user defined matrix containing the parameter ranges M[max, min]
%
%% Example
%
% 

createParamsBoundsfiles('gummersbach')

%%
%

%createParamsBoundsfiles('vreden', 'default', 0.1)

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
% ,
% <html>
% <a href="matlab:doc('matlab/validatestring')">
% matlab/validatestring</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
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
% ,
% <html>
% <a href="createADM1paramsfile.html">
% createADM1paramsfile</a>
% </html>
%
%% TODOs
% # improve documentation a little bit
% # make TODO in file
%
%% <<AuthorTag_ALSB/>>


