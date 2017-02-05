%% NMPC_getEquilibriumFromFiles
% Get equilibrium from files and simulate it to steady state
%
function equilibriumInit= NMPC_getEquilibriumFromFiles(plant_id, fcn, control_horizon, ...
  delta, varargin)
%% Release: 1.2

%%

error( nargchk(4, 5, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 5 && ~isempty(varargin{1})
  tend_ss= varargin{1};
  isR(tend_ss, 'tend_ss', 5);
else
  tend_ss= 750;     % end time of steady state simulation
end

%%
% check arguments

is_plant_id(plant_id, '1st');
checkArgument(fcn, 'fcn', 'char', '2nd');
isN(control_horizon, 'control_horizon', 3);
isR(delta, 'delta', 4, '+');

%%
% get initial equilibrium from initstate user file and volumeflow_const
% files

equilibriumInit= getEquilibriumFromFiles(plant_id);


%% 
% get variables

[substrate, plant, substrate_network, plant_network]= ...
    load_biogas_mat_files(plant_id);

fitness_params= load_biogas_mat_files(plant_id, [], {'fitness_params'});

%% TODO 
% A long simulation is done to get to a steady state.
% 
% CHANGE THE INITIATION SOURCE FROM USER TO CONSTANT
% The NMPC simulation has to be performed with user defined flow.
% But the steady state simulation has to be performed with constant flow.

% if useStateEstimator
%   [fit, equilibriumInit, sensor_data]= ...
%      NMPC_simBiogasPlantExtended(fcn, equilibriumInit, plant, substrate, ...
%                             plant_network, substrate_network, ...
%                                fitness_params, [0, 750], ...% 750
%                            control_horizon,1,fix(control_horizon/delta) ); 
% else
[fit, equilibriumInit, ~, sensor_data, sensors]= ...
    NMPC_simBiogasPlantExtended(fcn, equilibriumInit, plant, substrate, ...
                         plant_network, substrate_network, ...
                         fitness_params, [0, tend_ss], ...% 750
                         control_horizon, 1, getNumSteps_Tc(control_horizon, delta)); 
% end

%%
% wir sind hier im UO mpc. die datei soll aber im überordner geschrieben
% werden
save(fullfile('..', 'sensor_data_estim.mat'), 'sensor_data');

%%
% create ref file, only use last methane values and write them before time
% 0. needed, such that we can shift volumeflow while evaluating the control
% later in simulations, because then ref values must be shifted as well
NMPC_create_ref_biogas_1_slave(sensors, plant, 1);

%%


