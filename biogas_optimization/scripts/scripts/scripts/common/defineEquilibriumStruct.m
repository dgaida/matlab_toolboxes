%% defineEquilibriumStruct
% Define the structure of the equilibrium struct.
%
function equilibria= defineEquilibriumStruct(plant, plant_network, varargin)
%% Release: 1.3
% reduced version number because of extension with varargin which is not
% yet documented and completed

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1})
  statevec= varargin{1};
  
  %% TODO check argument
else
  statevec= [];
end


%%
% check input parameters

is_plant(plant, '1st');
is_plant_network(plant_network, 2, plant);

%%

n_fermenter= plant.getNumDigestersD();

if ~isempty(statevec)
  if any(size(statevec) ~= [biogas.ADMstate.dim_state n_fermenter])
    error('TODO');
  end
end

for ifermenter= 1:n_fermenter

  fermenter_name= char(plant.getDigesterID(ifermenter));

  if ~isempty(statevec)
    % the final (equilibrium) state of the fermenter
    equilibria(1).fermenter.( fermenter_name ).x0= statevec(:,ifermenter);
  else
    % the final (equilibrium) state of the fermenter
    equilibria(1).fermenter.( fermenter_name ).x0= ...
                  zeros(biogas.ADMstate.dim_state,1);  
  end
  
end


%%

[nRecirculations, digester_recirculations]= ...
       getNumRecirculations(plant_network, plant);

%%

for ihydraulicdelay= 1:nRecirculations

  rec= digester_recirculations{ihydraulicdelay};

  equilibria(1).hydraulic_delay.( rec ).x0= zeros(biogas.ADMstate.dim_stream,1);
  
end

%%

equilibria(1).fitness= 0;
% the total flux in the model, which leads to the equilibrium, row vector
equilibria(1).network_flux(1,1)= 0;
% description of the vector network_flux above, row vector of cells
equilibria(1).network_flux_string= {''};

%%
    
    
    