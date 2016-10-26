%% save_ADMparams_to_mat_file
% Loads ADM params from plant object and saves them in adm1_params_opt mat
% file
%
function save_ADMparams_to_mat_file(plant)
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
% eigentlich muss das nicht, da alle elemente in p_opt überschrieben werden
p_opt= load_file( sprintf('adm1_params_opt_%s.mat', plantID), ...
                  [], [plantID, '/'] );

%%
% get IDs of ADM params

[p_Matrix, p_ids]= calib_getDefaultADM1params();

%%

for ifermenter= 1:plant.getNumDigestersD()

  %%
  
  fermenter_id= char(plant.getDigesterID(ifermenter));

  %%
  
  for iid= 1:numel(p_ids)

    pos= eval(sprintf('biogas.ADMparams.pos_%s', p_ids{iid}));

    p_opt.(fermenter_id)(iid)= plant.getADMparameter(fermenter_id, pos);

  end

  %%
  
end

%%

save(sprintf('adm1_params_opt_%s.mat', plantID), 'p_opt');

%%


