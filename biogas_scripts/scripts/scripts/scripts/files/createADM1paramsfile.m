%% createADM1paramsfile
% Create the file |adm1_params_opt__plant_id_.mat| for the given |plant_id|
%
function createADM1paramsfile(plant_id, varargin)
%% Release: 1.8

%%
% check input parameters

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 2 && ~isempty(varargin{1})
  path_to_folder= varargin{1};
else
  path_to_folder= fullfile( getConfigPath(), plant_id );
end

%%

is_plant_id(plant_id, '1st');
checkArgument(path_to_folder, 'path_to_folder', 'char', '2nd');

%%

p_Matrix= calib_getDefaultADM1params();
 
%%
% Load plant's data [ substrate, plant, ... ]
%
[ dummy1, plant ]= load_biogas_mat_files(plant_id);
   
%%

n_fermenter= plant.getNumDigestersD(); % nº of fermenters   

%%
% create adm1_params_opt_plant_id.mat

p_opt= [];

for ifermenter= 1:n_fermenter        % nº of Columms -> Inputs to the fermenter    
    
  % Fermenter Name for Input  
  fermenter_id= char(plant.getDigesterID(ifermenter));

  p_opt.(fermenter_id)= p_Matrix;

end

%%
% save created p_opt

filename= fullfile( path_to_folder, ...
                 sprintf('adm1_params_opt_%s.mat', plant_id) );

if ~exist(filename, 'file')
  save ( filename, 'p_opt' );
end
     

%%


