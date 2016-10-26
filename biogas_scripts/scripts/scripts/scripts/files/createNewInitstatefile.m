%% createNewInitstatefile
% Create the initstate MAT-file with default entries.
%
function initstate= createNewInitstatefile(plant_id)
%% Release: 1.9

%%
% check input parameters

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

is_plant_id(plant_id, '1st');

%%
% load mat files

try
  [plant, plant_network, plant_network_max]= ...
      load_biogas_mat_files(plant_id, [], ...
                            {'plant', 'plant_network', 'plant_network_max'});
catch ME
  rethrow(ME);
end

%%

filename= sprintf('initstate_%s.mat', plant_id);

%%

n_fermenter= plant.getNumDigestersD();

%%
% create initstates for fermenters (ADM1)

for ifermenter= 1:n_fermenter

  fermenter_id= char(plant.getDigesterID(ifermenter));

  %%

  initstate.fermenter.(fermenter_id).default= ...
       double(biogas.ADMstate.getDefaultADMstate())';

  %%
  % get random digester state

  [LB, UB]= biogas.ADMstate.getBoundsForADMstate();

  LB= double(LB);
  UB= double(UB);

  init_state= ...
      ones(1, biogas.ADMstate.pos_pTOTAL) * diag( LB ) + ...
      rand(1, biogas.ADMstate.pos_pTOTAL) * diag( UB - LB );

  init_state= init_state';
  init_state(biogas.ADMstate.pos_pTOTAL, 1)= 1.0;

  initstate.fermenter.(fermenter_id).random= init_state;

  %%
  % set user state to default state 
  
  initstate.fermenter.(fermenter_id).user= ...
              double(biogas.ADMstate.getDefaultADMstate())';

end

%%
% create initstate for pumps (hydraulic delays)

[nSplits, digester_splits]= ...
       getNumDigesterSplits(plant_network, plant_network_max, plant);

%%

for isplit= 1:nSplits     

  %%
  % Fermenter Names for Output_Input  
  fermenter_id_out_in= digester_splits{isplit};         

  init_state= double( biogas.ADMstate.getDefaultADMstate(...
                     biogas.ADMstate.dim_stream - 1) )';

  initstate.hydraulic_delay.(fermenter_id_out_in).default= init_state;

  initstate.hydraulic_delay.(fermenter_id_out_in).user= init_state;
        
end

%%

save_varname(initstate, 'initstate', filename);


%%


