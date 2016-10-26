%% load_ADMparam_vec_from_file
% Loads ADM param vector from adm1_param_vec mat file and saves them in
% plant object
%
function plant= load_ADMparam_vec_from_file(plant, varargin)
%% Release: 1.3

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 2 && ~isempty(varargin{1})
  silent= varargin{1};
  is0or1(silent, 'silent', 2);
else
  silent= 0;
end

%%
% check arguments

is_plant(plant, '1st');

%%

plantID= char(plant.id);%getPlantIDfrombdroot();

%%

if ~exist(sprintf('adm1_param_vec_%s.mat', plantID), 'file')
  if ~silent
    warning('file:notexist', 'File adm1_param_vec_%s.mat does not exist!', plantID);
  end
  
  return;
end

%%

p_vec= load_file(sprintf('adm1_param_vec_%s.mat', plantID));

%%

for ifermenter= 1:plant.getNumDigestersD()

  %%
  
  fermenter_id= char(plant.getDigesterID(ifermenter));

  %%
  
  plant.setDefaultADMparams(fermenter_id, p_vec.(fermenter_id));

  %%
  
end

%%



%%


