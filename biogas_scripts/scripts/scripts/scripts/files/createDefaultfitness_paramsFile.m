%% createDefaultfitness_paramsFile
% Create fitness_params__plant_id_.xml file with default params
%
function fitness_params= createDefaultfitness_paramsFile(plant_id)
%% Release: 1.5

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% read out varargin

is_plant_id(plant_id, '1st');

%%

plant= load_biogas_mat_files(plant_id, [], 'plant');

%%
% create fitness_params object

fitness_params= biooptim.fitness_params(plant.getNumDigestersD());

%% 
% save it to xml file

fitness_params.saveAsXML(sprintf('fitness_params_%s.xml', plant_id));

%%


