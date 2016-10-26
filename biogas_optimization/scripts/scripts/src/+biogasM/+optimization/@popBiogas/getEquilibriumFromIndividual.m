%% biogas.optimization.popBiogas.getEquilibriumFromIndividual
% Create the equilibrium struct out of an individual.
%
function equilibrium= getEquilibriumFromIndividual(obj, u, plant, substrate, ...
                                     plant_network, fitness)
%% Release: 1.4

%%
%

error( nargchk(6, 6, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check params

validateattributes(u, {'double'}, {'2d'}, mfilename, 'individual',  1);

is_plant(plant, '2nd');
is_substrate(substrate, '3rd');
is_plant_network(plant_network, 4, plant);
checkArgument(fitness, 'fitness', 'double', '5th');


%%
% get individual in full dimension, d.h. die zahlen im individuum
% entsprechen exakt der physik, ohne skalierung oder ähnliches
%

u= getPointsInFullDimension(obj.conObj, u);


%% 
% get the network flux for this individual
            
[networkFlux, fluxString, lenFluxIndividual]= ...
        getNetworkFluxFromIndividual(obj, u, plant, substrate, plant_network);
    
    
    
%% 
% get the initial state for this individual
    
equilibrium= getInitStateFromIndividual(obj, u, ...
                                        plant, plant_network, ...
                                        fitness, lenFluxIndividual);

       
                                    
%%                                    
% set the flux in the equilibrium struct

equilibrium.network_flux= networkFlux;
equilibrium.network_flux_string= fluxString;

%%


