%% init_ADMparams_from_mat_file
% Loads ADM params from file and sets them in plant object
%
function plant= init_ADMparams_from_mat_file(plant)
%% Release: 1.3

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

is_plant(plant, '1st');

%%

plantID= char(plant.id); %getPlantIDfrombdroot();

%%
% 
p_opt= load_file( sprintf('adm1_params_opt_%s.mat', plantID), ...
                  [], [plantID, '/'] );

%%
% get IDs of ADm params

[p_Matrix, p_ids]= calib_getDefaultADM1params();

%%

ignore_params= {'kdis', 'khyd_ch', 'khyd_pr', 'khyd_li', ...
                'km_c4', 'km_pro', 'km_ac', 'km_h2'};

%%

for ifermenter= 1:plant.getNumDigestersD()

  %%
  
  fermenter_id= char(plant.getDigesterID(ifermenter));

  %%
  
  for iid= 1:numel(p_ids)

    if any(cellfun(@any, strfind(ignore_params, p_ids{iid})))
      continue;
    end
    
    pos= eval(sprintf('biogas.ADMparams.pos_%s', p_ids{iid}));

    plant.setADMparameter(fermenter_id, pos, p_opt.(fermenter_id)(iid));

  end

  %%
  
end

%%



%%


