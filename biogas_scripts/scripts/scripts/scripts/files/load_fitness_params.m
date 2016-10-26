%% load_fitness_params
% Loads the file fitness_params_....xml for given plant_id
%
function fitness_params= load_fitness_params(plant_id)
%% Release: 1.5

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

is_plant_id(plant_id, '1st');

%%

fitness_params= load_biogas_mat_files(plant_id, [], 'fitness_params');

%%


