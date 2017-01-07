%% getStateEstimateOfBiogasPlant
% Return current state estimate of a biogas plant for each digester
%
function x_hat= getStateEstimateOfBiogasPlant(plant, sensors, varargin)
%% Release: 1.3

%%

error( nargchk(2, 5, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1})
  method= varargin{1};
  checkArgument(method, 'method', 'char', '3rd');
else
  method= 'RF';
end

if nargin >= 4 && ~isempty(varargin{2})
  convertUnitToDefault= varargin{2};
  is0or1(convertUnitToDefault, 'convertUnitToDefault', 4);
else
  convertUnitToDefault= 0;
end

if nargin >= 5 && ~isempty(varargin{3})
  minimize_dx= varargin{3};
  is0or1(minimize_dx, 'minimize_dx', 5);
else
  minimize_dx= 1;
end

%%

is_plant(plant, 1);
checkArgument(sensors, 'sensors', 'biogas.sensors || struct', '2nd');

%%

digester_state_dataset_min= load_file('digester_state_dataset_min');
digester_state_dataset_max= load_file('digester_state_dataset_max');

%%

dataset_flag_vec= load_file('dataset_flag_vec');

goal_variables= load_file('adm1_state_abbrv');

%%

x_hat= zeros(size(goal_variables, 1), plant.getNumDigestersD());

% das sind die LB und UB der klasse in der sich x_hat befinden kann
x_lb= zeros(size(goal_variables, 1), plant.getNumDigestersD());
x_ub= zeros(size(goal_variables, 1), plant.getNumDigestersD());

%%

for idigester= 1:plant.getNumDigestersD()
  
  %%
  
  fermenter_id= char( plant.getDigesterID(idigester) );
  
  %%
  % same as idigester
  %fermenter_index= plant.getDigesterIndex(fermenter_id);

  %%

  %% WARNING
  % although we pass fermenter_id here, sensors must contain measurement data
  % from both digesters. That's because we assume that the state of one
  % digester may also be depend on the measured data at the other digester.
  % E.g. the state of the post digester may be dependent on the state of the
  % primary digester
  
  if ~isa(sensors, 'biogas.sensors')
    sensors_id= sensors;%.(fermenter_id);
  else
    sensors_id= sensors;
  end
  
  %%
  
  [x_hat(:,idigester), x_lb(:,idigester), x_ub(:,idigester)]= ...
         getStateEstimateOfDigester(plant, sensors_id, fermenter_id, ...
                  method, dataset_flag_vec, goal_variables, ...
                  digester_state_dataset_min(:, idigester), ...
                  digester_state_dataset_max(:, idigester));

  
  %%
  % geht hier nicht, da einheit nicht stimmt
  %biogas.ADMstate.print(x_hat(:,idigester), fermenter_id, plant)
  
  %%
  
end

%%
% first 37 components for digester1, then 37 comp. for digester2
x_hat= x_hat(:);


%% 
% choose estimated x between boundaries that has minimal velocity: dx/dt

%% TODO
% was mache ich hier für ein blödsinn??? digester_state_dataset_min und
% digester_state_dataset_max sind gesamte LB und UB und nicht nur die für
% die gefundene Klasse!!!
% Mit x_lb und x_ub sollte es jetzt richtig sein

if (minimize_dx)
%   x_hat= findMinDXNorm(plant, x_hat', ...
%            digester_state_dataset_min(:), ...
%            digester_state_dataset_max(:))';
         
  x_hat= findMinDXNorm(plant, x_hat', x_lb(:), x_ub(:))';       
end

%%
% x_hat is currently measured in default measurement units, such as g/l,
% ...

x_hat= reshape(x_hat, biogas.ADMstate.dim_state, plant.getNumDigestersD());

%%

if (convertUnitToDefault)
  
  x_hat= convertStateEstimateToDefaultUnits(x_hat, goal_variables);
  
end

%%


