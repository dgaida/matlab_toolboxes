%% Syntax
%       xmin= findMinDXNorm(plant, x0, LB, UB)
%       xmin= findMinDXNorm(plant, x0, LB, UB, method)
%
%% Description
% |xmin= findMinDXNorm(plant, x0, LB, UB)| finds digester state vector for
% given biogas plant which is nearest to a steady state. This state is
% always between the lower and upper boundaries |LB| and |UB|. 
%
%% <<plant/>>
%%
% @param |x0| : initial individual, which is the concatenated vector of all
% digester states inside the plant
%
%%
% @param |LB| : contains min values of digester state variables measured
% in default measurement units. vector containing 37 rows times number of
% digester columns, first 37 values: digester 1, 2nd 37 values: digester 2
%
%%
% @param |UB| : contains max values of digester state variables measured
% in default measurement units. vector containing 37 rows times number of
% digester columns, first 37 values: digester 1, 2nd 37 values: digester 2
%
%%
% @return |xmin| : optimal state vector of the digesters with minimal
% velocity. row vector with 37 times number of digesters. first 37 values:
% 1st digester, ...
%
%%
% |xmin= findMinDXNorm(plant, x0, LB, UB, method)| 
%
%% <<opt_method/>>
%
% at the moment only 'CMAES' is implemented. 
%
%% Examples
%
%

clear

%%

cd( fullfile( getBiogasLibPath(), 'examples/nmpc/Sunderhook' ) );

%%

[~, plant]= load_biogas_mat_files('sunderhook');

% contains min respectively max values of digester state variables measured
% in default measurement units
% arrays containing 37 rows and number of digester columns
digester_state_dataset_min= load_file('digester_state_dataset_min');
digester_state_dataset_max= load_file('digester_state_dataset_max');

%%

x_hat= rand(numel(digester_state_dataset_min), 1) .* ...
      ( digester_state_dataset_max(:) - ...
        digester_state_dataset_min(:) ...
      ) + ...
        digester_state_dataset_min(:);

%%

try
%   x_hat= findMinDXNorm(plant, x_hat', ...
%            digester_state_dataset_min(:), ...
%            digester_state_dataset_max(:))';
catch ME
  close_biogas_system('plant_sunderhook');
  
  rethrow(ME);
end

         
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc load_file">
% load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc load_biogas_mat_files">
% load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="fitness_dxnorm.html">
% fitness_DXNorm</a>
% </html>
% ,
% <html>
% <a href="matlab:doc load_biogas_system">
% load_biogas_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('optimization_tool/startcmaes')">
% optimization_tool/startCMAES</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant')">
% biogas_scripts/is_plant</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc getstateestimateofbiogasplant">
% getStateEstimateOfBiogasPlant</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_control/startnmpc')">
% biogas_control/startNMPC</a>
% </html>
% ,
% <html>
% <a href="matlab:doc ex_model_nmpc_sh">
% ex_model_nmpc_sh</a>
% </html>
%
%% TODOs
% # do the example
% # improve documentation
%
%% <<AuthorTag_DG/>>


