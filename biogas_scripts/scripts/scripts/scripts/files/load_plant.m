%% load_plant
% Loads the file plant_....xml for given plant_id
%
function plant= load_plant(plant_id)
%% Release: 1.5

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

is_plant_id(plant_id, '1st');

%%

plant= load_biogas_mat_files(plant_id, [], 'plant');

%%


