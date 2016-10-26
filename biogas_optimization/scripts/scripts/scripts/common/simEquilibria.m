%% simEquilibria
% Simulate the selected equilibria out of the equilibria struct file
%
function equilibria= simEquilibria(plant_id, indexlist, timespan)
%% Release: 0.9

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check parameters

checkArgument(plant_id, 'plant_id', 'char', '1st');
checkArgument(indexlist, 'indexlist', 'double', '2nd');
checkArgument(timespan, 'timespan', 'double', '3rd');

%%

fcn= ['plant_', plant_id];


%%
% load struct files

[substrate, plant, substrate_network, plant_network]= ...
                    load_biogas_mat_files(plant_id);
                              
%load (['fitness_params_', plant_id, '.mat']);
fitness_params= load_biogas_mat_files(plant_id, [], 'fitness_params');

%load (['equilibria_', plant_id, '.mat']);
%load (['equilibrium_', plant_id, '_optimum.mat']);
load (['equilibrium_', plant_id, '_optimum_3params_optimal.mat']);
%load (['equilibrium_', plant_id, '_optimum_2+1params_optimal.mat']);
%load (['initstate_', plant_id, '.mat']);

equilibria= equilibrium;


%%
% load the model

load_biogas_system(fcn, 'none', 1);

%%
% simulate the selected equilibria
%par
for ieq= indexlist

  disp(sprintf('Simulation %i of %i', ieq, max(indexlist)));

  %%

  [fitness, equilibria(1,ieq)]= ...
       simBiogasPlantExtended(equilibria(1,ieq), plant, substrate, ...
                      plant_network, substrate_network, ...
                      fitness_params, timespan, ...
                      0, 1, [], 2.5, 1);               

  %%

  assignin('base', 'equilibria', equilibria);

end

%%

close_biogas_system(fcn);

%%


