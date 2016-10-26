%% createParamsBoundsfiles
% Create the files |params_min__plant_id_.mat| and
% |params_max__plant_id_.mat| for the given |plant_id|.  
%
function createParamsBoundsfiles(plant_id, varargin)
%% Release: 1.2

%%
% check input parameters

error( nargchk(1, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

% calib_type
if nargin > 1 && ~isempty(varargin{1})  
  calib_type= varargin{1};
  
  validatestring(calib_type, {'default', 'user'}, mfilename, 'calib_type', 2);
else
  calib_type= [];
end

% calib_opt for calib_type = 'default'
if nargin > 1 && strcmp(calib_type, 'default')
  if nargin > 2 && ~isempty(varargin{2}),
    calib_opt= varargin{2}; % percentage values of increment and decrement
    
    isR(calib_opt, 'calib_opt', 3, '+');
  else
    calib_opt= 0;
  end
else
  calib_opt= 0.1;
end

% calib_opt for calib_type = 'user'
if nargin > 1 && strcmp(calib_type, 'user')
  if nargin > 2 && ~isempty(varargin{2}),
    %% TODO
    % must contain different min and max for each digester
    
    p_MatrixMaxMin= varargin{2};  % matrix containing user defined min 
                                  % and max values M[max, min]
                                  
    validateattributes(p_MatrixMaxMin, {'double'}, {'2d', 'nonnegative'}, ...
                       mfilename, 'p_MatrixMaxMin', 3);
  else
    error( ['p_MatrixMaxMin: "', varargin{2},'" is invalid or empty!'] )
  end
end


%%

checkArgument(plant_id, 'plant_id', 'char', '1st');

%%

p_Matrix= calib_getDefaultADM1params();
 
%%
% Load plant's data [ substrate, plant, ... ]
%
[ dummy, plant ]= load_biogas_mat_files(plant_id);
   
%%

n_fermenter= plant.getNumDigestersD(); % nº of fermenters   

%%

params_max= repmat(p_Matrix, 1, n_fermenter);
params_min= repmat(p_Matrix, 1, n_fermenter);

save ( fullfile( getConfigPath(), plant_id, ...
         sprintf('params_max_%s.mat', plant_id) ), 'params_max' );
     
save ( fullfile( getConfigPath(), plant_id, ...
         sprintf('params_min_%s.mat', plant_id) ), 'params_min' );
    
%%

if strcmp(calib_type, 'default')
    
  for n= 1:n_fermenter

    params_max(:,n) = p_Matrix*(1 + calib_opt);

    params_min(:,n) = p_Matrix*(1 - calib_opt);
    
  end

elseif strcmp(calib_type, 'user')
  
  % 'user'
  for n= 1:n_fermenter

    params_max(:,n) = p_MatrixMaxMin(:,1);

    params_min(:,n) = p_MatrixMaxMin(:,2);
    
  end
    
end

%%

if ~isempty(calib_type) && ...
   ~exist(sprintf('params_max_%s.mat', plant_id), 'file')
  
  save ( sprintf('params_max_%s.mat', plant_id), 'params_max' );
     
end

if ~isempty(calib_type) && ...
   ~exist(sprintf('params_min_%s.mat', plant_id), 'file')
  
  save ( sprintf('params_min_%s.mat', plant_id), 'params_min' );
    
end

%%


