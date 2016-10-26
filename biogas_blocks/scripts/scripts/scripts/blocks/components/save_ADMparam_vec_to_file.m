%% save_ADMparam_vec_to_file
% Loads ADM param vector from plant object and saves them in adm1_param_vec mat
% file
%
function save_ADMparam_vec_to_file(plant)
%% Release: 1.3

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check arguments

is_plant(plant, '1st');

%%

plantID= char(plant.id);%getPlantIDfrombdroot();

%%

for ifermenter= 1:plant.getNumDigestersD()

  %%
  
  fermenter_id= char(plant.getDigesterID(ifermenter));

  %%
  
  p_vec.(fermenter_id)= double(plant.getDefaultADMparams(fermenter_id));

  %%
  
end

%%

save(sprintf('adm1_param_vec_%s.mat', plantID), 'p_vec');

%%


