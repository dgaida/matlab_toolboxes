%% biogasM.optimization.popBiogas.getNetworkFluxFromIndividual
% Get the networkflux in values (|networkFlux|) and words (|fluxString|) 
% from the individual |u|.
%
function [networkFlux, fluxString, lenFluxIndividual]= ...
           getNetworkFluxFromIndividual(obj, u, plant, substrate, plant_network)
%% Release: 1.4

%%

error( nargchk(5, 5, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%
% check input parameters

validateattributes(u, {'double'}, {'2d'}, mfilename, 'individual',  1);

is_plant(plant, '2nd');
is_substrate(substrate, '3rd');
is_plant_network(plant_network, 4, plant);

%%

%% 
% set lenGenom as parameter
% length of the substrate flow coding -> its the
% number of changes during the simulation duration, if it is constant, then
% it is 1, if it changes once, then it is 2, etc.

lenGenomSubstrate= obj.pop_substrate.lenGenom;

%% TODO
% sometime in the future add param lenGenomPump to class popPlant...

lenGenomPump= 1;


%%

substrate_network_min= obj.pop_substrate.substrate_network_min;
substrate_network_max= obj.pop_substrate.substrate_network_max;

plant_network_min= obj.pop_plant.plant_network_min;
plant_network_max= obj.pop_plant.plant_network_max;


%%

if ~isempty(u)
  u= reshape(u, 1, max(size(u)));
else
  u= [];
end

n_substrate= substrate.getNumSubstratesD();
n_fermenter= plant.getNumDigestersD();


%%
% calc NetworkFlux for Substrate

%[dummy, substrateNetworkMask]= ...
%            getIndividualByMask( [], ...
%                            substrate_network_min, substrate_network_max );
                               
[dummy, substrateNetworkMask]= ...
            getIndividualByMask( obj, [], ...
                                 obj.pop_substrate.substrate_ineq(:, 1:end - 1), ...
                                 obj.pop_substrate.substrate_eq(:, 1:end - 1), ...
                                 substrate_network_min, ...
                                 substrate_network_max, ...
                                 [], lenGenomSubstrate );                        
                        
%%

substrateNetworkMask= ...
                reshape(substrateNetworkMask, ...
                        n_substrate * lenGenomSubstrate, n_fermenter);

%%

% Initialize somehow
fluxString(1,1)= {'a'};
networkFlux(1,1)= 0;

% index in the individual vector u
i_individual= 1;
% index in the substrate flux vectors networkFlux and fluxString
i_flux= 1;

for ifermenter= 1:n_fermenter
   
  fermenter_name= char( plant.getDigesterID(ifermenter) );

  for isubstrate= 1:1:n_substrate

    substrate_name= char( substrate.getID(isubstrate) );

    % Fallunterscheidung wird in diesem Fall nicht benötigt, da alle
    % Substrate in networkFlux aufgenommen werden
    % von daher auch deutlich einfacher möglich
    
    % If max > min, then we will find a entry in the individual
    % vector
    if substrateNetworkMask(isubstrate*lenGenomSubstrate, ifermenter)

        fluxString(1,i_flux:i_flux + lenGenomSubstrate - 1)= ...
            {[substrate_name, '->' , fermenter_name]};

        networkFlux(1,i_flux:i_flux + lenGenomSubstrate - 1)= ...
            u(1, i_individual:i_individual + lenGenomSubstrate - 1);

        i_individual= i_individual + lenGenomSubstrate;

        i_flux= i_flux + lenGenomSubstrate;

    % min == max >= 0, each substrate flow, also 0 m^3/d is put in
    % the flux vectors
    elseif substrate_network_max(isubstrate, ifermenter) >= 0

        fluxString(1,i_flux:i_flux + lenGenomSubstrate - 1)= ...
            {[substrate_name, '->' , fermenter_name]};

        networkFlux(1,i_flux:i_flux + lenGenomSubstrate - 1)= ...
            substrate_network_max(isubstrate, ifermenter);

        i_flux= i_flux + lenGenomSubstrate;

    end

  end
        
end



%%
% calc NetworkFlux for Pumps

%% TODO
% lenGenomPump wird noch nicht richtig genutzt, d.h. funktioniert nur für
% lenGenomPump == 1

if lenGenomPump ~= 1
  error('lenGenomPump ~= 1: %i', lenGenomPump);
end

%[dummy, plantNetworkMask]= getIndividualByMask( [], ...
%                                  plant_network_min, plant_network_max );
                               
[dummy, plantNetworkMask]= getIndividualByMask( obj, [], ...
                                obj.pop_plant.plant_ineq(:, 1:end - 1), ...
                                obj.pop_plant.plant_eq(:, 1:end - 1), ...
                                plant_network_min, plant_network_max, ...
                                [], lenGenomPump );                              
                              
plantNetworkMask= ...
    reshape(plantNetworkMask, n_fermenter, n_fermenter + 1);

  
%%
% das sollte deutlich einfacher möglich sein unter Nutzung von
% getNumDigesterSplits

for ifermenterIn= 1:n_fermenter + 1
           
  % the last 'fermenter' is the endlager, which is not inside the
  % plant.fermenter struct, but is inside the plant_network struct
  if ifermenterIn <= n_fermenter
    fermenter_name_in= char( plant.getDigesterID(ifermenterIn) );
  else
    fermenter_name_in= 'endlager';    % besser wäre storagetank
  end

  for ifermenterOut= 1:n_fermenter

    fermenter_name_out= char( plant.getDigesterID(ifermenterOut) );

    % if we have two or more controllable (< Inf and max > min) pumps in 
    % one knot (behind a fermenter)
    % then they are in the individual
    if plantNetworkMask(ifermenterOut, ifermenterIn)

      fluxString(1,i_flux:i_flux + lenGenomPump - 1)= ...
          {[fermenter_name_out, '->' , fermenter_name_in]};

      if i_individual + lenGenomPump - 1 <= size(u, 2)
        networkFlux(1,i_flux:i_flux + lenGenomPump - 1)= ...
              u(1, i_individual:i_individual + lenGenomPump - 1);
      else
        networkFlux(1,i_flux:i_flux + lenGenomPump - 1)= 0;
      end

      i_individual= i_individual + lenGenomPump;

      i_flux= i_flux + lenGenomPump;

      break;

    % if we can pump something ( > 0 in plant_network) and if its theoretically controllable
    % (< Inf) then its not in the individual
    % does not matter if we pump something or not, it just does matter
    % that we can control the pump, therefore > 0 for plant_network and not
    % plant_network_max
    elseif plant_network(ifermenterOut, ifermenterIn) > 0 && ...
           plant_network_max(ifermenterOut, ifermenterIn) < Inf

      fluxString(1,i_flux)= ...
                  {[fermenter_name_out, '->' , fermenter_name_in]};

      networkFlux(1,i_flux)= ...
                  plant_network_max(ifermenterOut, ifermenterIn);

      i_flux= i_flux + 1;

    end

  end
                
end



lenFluxIndividual= i_individual - 1;

%%


