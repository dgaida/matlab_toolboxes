%% Syntax
%     plantID= getPlantIDfrombdroot()
%
%% Description
% |plantID= getPlantIDfrombdroot()| returns _plant_id_ from
% <matlab:doc('bdroot') bdroot> (the top-level Simulink system must be a 
% biogas plant model). The parameter _plant_id_ must not contain '_'.
%
%%
% @return |plantID| : char containing the plant ID, as defined in the plant
% structure
%
%% Example
%
% get plant ID of the Gummersbach plant

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

load_biogas_system('plant_gummersbach');

plantID= getPlantIDfrombdroot();

close_biogas_system('plant_gummersbach');

disp(['The plant ID is: ', plantID]);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc bdroot">
% matlab/bdroot</a>
% </html>
% ,
% <html>
% <a href="matlab:doc regexp">
% matlab/regexp</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('p_adm1xp')">
% p_adm1xp</a>
% </html>
%
%% See Also
%
% -
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


