%% Syntax
%       fitness= fitness_DXNorm(x, plant, plant_network, goal_variables) 
%
%% Description
% |fitness= fitness_DXNorm(x, plant, plant_network, goal_variables)|
% calculates the distance of the given individual |x| from a 
% steady state, the smaller the distance, the smaller and better the
% |fitness| value. 
%
%%
% @param |x| : individual, which is the concatenated vector of all digester
% states inside the plant. row vector, measured in default measurement
% units, such as g/l, etc. teh first 37 values are the state values for the
% first digester, then 2nd digester, ...
%
%% <<plant/>>
%% <<plant_network/>>
%%
% @param |goal_variables| : 37 dim column vector as cellstring with the
% abbreviations of the state vector components
%
%%
% @return |fitness| : fitness of the evaluated individual |x|
%
%% Example
%
%

clear

%%

cd( fullfile( getBiogasLibPath(), 'examples/nmpc/Sunderhook' ) );

plant_id= 'sunderhook';

%%

[~, plant, ~, plant_network]= load_biogas_mat_files('sunderhook');

digester_state_dataset_min= load_file('digester_state_dataset_min');
digester_state_dataset_max= load_file('digester_state_dataset_max');

goal_variables= load_file('adm1_state_abbrv');


%%

x_hat= rand(numel(digester_state_dataset_min),1) .* ...
      ( digester_state_dataset_max(:) - ...
        digester_state_dataset_min(:) ...
      ) + ...
        digester_state_dataset_min(:);


%%

try
  fitness_DXNorm(x_hat', plant, plant_network, plant_id, goal_variables)
catch ME

  %%

  close_biogas_system(['plant_', plant_id]);
  
  rethrow(ME);
  
end


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="defineequilibriumstruct.html">
% defineEquilibriumStruct</a>
% </html>
% ,
% <html>
% <a href="matlab:doc getvectoroutofstream">
% getVectorOutOfStream</a>
% </html>
% ,
% <html>
% <a href="matlab:doc getdefaultmeasurementunit">
% getDefaultMeasurementUnit</a>
% </html>
% ,
% <html>
% <a href="setinitstateinworkspace.html">
% setInitStateInWorkspace</a>
% </html>
% ,
% <html>
% <a href="matlab:doc close_biogas_system">
% close_biogas_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="findmindxnorm.html">
% findMinDXNorm</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc getstateestimateofbiogasplant">
% getStateEstimateOfBiogasPlant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nonlinearmpc')">
% biogas_control/nonlinearMPC</a>
% </html>
% ,
% <html>
% <a href="matlab:doc ex_model_nmpc_sh">
% ex_model_nmpc_sh</a>
% </html>
%
%% TODOs
% # improve documentation
% # check code
%
%% <<AuthorTag_DG/>>


