%% createDefaultSubstrateStock
% Create default substrate stock, which is all values equal to infinity
%
function substrate_stock= createDefaultSubstrateStock(plant_id)
%% Release: 1.4

%%

narginchk(1, 1);
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check argument

is_plant_id(plant_id, '1st');

%%

substrate= load_biogas_mat_files(plant_id);

%%

substrate_stock= Inf(substrate.getNumSubstratesD(), 1);

%%


