%% calib_BiogasPlantParams
% Create ADM1 parameter *.mat files min/max and default values
%             
function calib_BiogasPlantParams(plant_id, varargin)    
%% Release: 1.7

%%
% check input parameters

error( nargchk(1, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(plant_id, 'plant_id', 'char', '1st');

%%
% get default values for parameters to be optimized

p_Matrix= calib_getDefaultADM1params();
                          
%%
% adm1_params_opt.mat

p_opt.fermenter(:,1)= p_Matrix;

% save default p_opt, only used for simba models
save ( fullfile( getConfigPath(), 'adm1_params_opt.mat' ), 'p_opt' );

%%
% write adm1_params_opt_plant_id.mat in config_mat/plant_id folder

createADM1paramsfile(plant_id);
     
%%
% write params_max and params_min.mat files in config_mat/plant_id folder
% as well as in the current folder

createParamsBoundsfiles(plant_id, varargin{:});

%%


