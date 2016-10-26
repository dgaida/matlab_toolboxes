%% biogasM.optimization.popBiogas.getSubstrateFlowFromIndividual
% Get the substrate flow |substrateFlow| from the individual |u|.
%
function [substrateFlow]= ...
           getSubstrateFlowFromIndividual(obj, u, plant, substrate, plant_network)
%% Release: 1.0

%%

error( nargchk(5, 5, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check input parameters

validateattributes(u, {'double'}, {'2d'}, mfilename, 'individual',  1);

is_plant(plant, '2nd');
is_substrate(substrate, '3rd');
is_plant_network(plant_network, 4, plant);

%%

[networkFlux]= getNetworkFluxFromIndividual(obj, u, plant, substrate, plant_network);

%%

lenGenomSubstrate= obj.pop_substrate.lenGenom;
n_substrates= substrate.getNumSubstratesD();
n_digester= plant.getNumDigestersD();

%%

[substrateFlow]= get_substratefeed_oo_networkflux(networkFlux, ...
  n_substrates, n_digester, lenGenomSubstrate);

%%


