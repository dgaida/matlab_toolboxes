%% setStateBoundsToEqState
% Set digester bounds to states inside equilibrium
%
function [digester_state_min, digester_state_max]= ...
            setStateBoundsToEqState(equilibrium, varargin)
%% Release: 1.3

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

if nargin >= 2 && ~isempty(varargin{1})
  plant_id= varargin{1};
  checkArgument(plant_id, 'plant_id', 'char', '2nd');
else
  plant_id= [];
end

%% 
% plant is not needed here, go over fieldnames

is_equilibrium(equilibrium, '1st');
%is_plant(plant, '2nd');

%%

fields= fieldnames(equilibrium.fermenter);

%%

n_fermenter= numel(fields);  %plant.getNumDigestersD(); % nº of fermenters

%%

digester_state_max= zeros(biogas.ADMstate.dim_state, n_fermenter);
digester_state_min= digester_state_max;

%%
% digester_state_min/max
for ifermenter= 1:n_fermenter

  %%
  % Select fermenter name independent of model structure
  fermenter_id= fields{ifermenter};   %char(plant.getDigesterID(ifermenter)); 

  % Digester min/max -> Set equals in the optimization -> less one var
  digester_state_max(:, ifermenter)= ...
        eval( sprintf( ['equilibrium.fermenter.', fermenter_id, '.x0'] ) );
      
  digester_state_min(:, ifermenter)= ...
        eval( sprintf( ['equilibrium.fermenter.', fermenter_id, '.x0'] ) );

end

clear ifermenter % clear temp variables

%%

if ~isempty(plant_id)

  save ( [ 'digester_state_min_', plant_id ] , 'digester_state_min' );   
  save ( [ 'digester_state_max_', plant_id ] , 'digester_state_max' );
  
end

%%


