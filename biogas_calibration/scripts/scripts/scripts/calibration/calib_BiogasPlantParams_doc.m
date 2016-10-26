%% Syntax
%       calib_BiogasPlantParams(plant_id)
%       calib_BiogasPlantParams(plant_id, calib_type)
%       calib_BiogasPlantParams(plant_id, calib_type, calib_opt)
%       
%% Description
% |calib_BiogasPlantParams(plant_id)| creates the following ADM1 parameter
% related files:
%
% * |adm1_params_opt.mat| in the |config_mat| folder. This file is actually
% only needed for Simba models. Maybe delete this file sometimes in the
% future.
% * |adm1_params_opt_plant_id.mat| in the |config_mat| folder. Defines the
% default ADM1 parameter values of each fermenter on the plant. 
% * |params_min/max_plant_id.mat| files in the subfolder |plant_id| of the
% |config_mat| folder. Define lower and upper boundaries of the ADM1
% parameters for each digester. Here both files are equal. 
%
%%
% @param |plant_id| : char with the id of the simulation model of the
% biogas plant. The plant's id is defined in the structure |plant| and has 
% to be set in the simulation model, which is
% <matlab:doc('develop_model_stepbystep') created> 
% using the toolbox's library. 
%
%%
% |calib_BiogasPlantParams(plant_id, calib_type)| additionally creates the
% |params_min/max_plant_id.mat| files in the current folder. Here the lower
% and upper boundaries are defined by the two arguments |calib_type| and
% |calib_opt|. 
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

calib_BiogasPlantParams('gummersbach', 'default', 0.1);

if exist('params_max_gummersbach.mat', 'file')
  delete('params_max_gummersbach.mat');
end

if exist('params_min_gummersbach.mat', 'file')
  delete('params_min_gummersbach.mat');
end

%%
%

calib_BiogasPlantParams('gummersbach');

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="calib_getdefaultadm1params.html">
% calib_getDefaultADM1params</a>
% </html>
% ,
% <html>
% <a href="matlab:doc createadm1paramsfile">
% createADM1paramsfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc createparamsboundsfiles">
% createParamsBoundsfiles</a>
% </html>
% ,
% <html>
% <a href="matlab:doc getconfigpath">
% getConfigPath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="startadmparamscalibration.html">
% startADMparamsCalibration</a>
% </html>
%
%% See Also
%
% <html>
% <a href="calib_steadystatecalc.html">
% calib_SteadyStateCalc</a>
% </html>
% 
%% TODOs
% # improve documentation of example a bit
%
%% <<AuthorTag_ALSB/>>


