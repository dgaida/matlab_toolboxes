%% simOptimalKrigingInput
% Simulate optimal substrate feeds generated by Kriging model
%
function [opt_inputs, opt_outputs]= ...
         simOptimalKrigingInput(plant_id, inputs, outputs, LB, UB, varargin)
%% Release: 0.0

%%

error( nargchk(5, 6, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

if nargin >= 6 && ~isempty(varargin{1})
  opt_method= varargin{1};
else
  % 
  opt_method= 'SMS-EMOA';
end

%%

opt_inputs= getOptimalInputUsingKriging('min', inputs, outputs, LB, UB, opt_method);

%%

[substrate, plant, substrate_network, plant_network, ...
 substrate_network_min, substrate_network_max, ...
 plant_network_min, plant_network_max, ...
 digester_state_min, digester_state_max, params_min, params_max, ...
 substrate_eq, substrate_ineq, fitness_params]= ...
                              load_biogas_mat_files(plant_id);

%%
% load the model(s)

fcn= ['plant_', plant_id];

load_biogas_system(fcn, 'none', 1);

%%

for irow= 1:size(opt_inputs, 2)

  %% TODO
  % was ist equilirbium?
  % was wird zur�ck gegeben?
  % habe ich alle anderen Parameter?
  opt_outputs(irow)= simBiogasPlantExtended(equilibrium, plant, substrate, ...
                                plant_network, substrate_network, ...
                                fitness_params, timespan, ...
                                saveInEquilibrium, nWorker, ...
                                fitness_function, ...
                                500, 1, 1, model_suffix, ...
                                control_horizon, ...
                                popBiogas.pop_substrate.lenGenom, 1);
  
end

%%



%% TODO
% diese Funktion in findOptimalequilibria aufrufen und r�ckgabewerte zu
% paretoset und paretofront hinzuf�gen

