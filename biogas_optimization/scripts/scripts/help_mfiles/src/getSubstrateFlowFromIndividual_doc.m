%% Syntax
%       [substrateFlow]= getSubstrateFlowFromIndividual(popBiogas, u, plant,
%       substrate, plant_network) 
%
%% Description
% |[substrateFlow]= getSubstrateFlowFromIndividual(popBiogas, u, plant,
% substrate, plant_network)| returns from the individual |u| the 
% substrate feed |substrateFlow|.  
%
%%
% @param |popBiogas| : object of the class <popbiogas.html 
% biogasM.optimization.popBiogas>
%
%%
% @param |u| : individual vector, double row vector. This |u| must 
% contain the real physical values, not some scaled values, see
% <getequilibriumfromindividual.html 
% biogas.optimization.popBiogas.getEquilibriumFromIndividual>. 
%
%% <<plant/>>
%% <<substrate/>>
%% <<plant_network/>>
%%
% @return |substrateFlow| : 
%
%% Example
% 
%

plant_id= 'gummersbach';

[substrate, plant, substrate_network, plant_network, ...
   substrate_network_min, substrate_network_max, ...
   plant_network_min, plant_network_max, ...
   digester_state_min, digester_state_max, ...
   params_min, params_max]= load_biogas_mat_files(plant_id);

[popBiogas]= biogasM.optimization.popBiogas(0, ...
                    substrate_network_min, substrate_network_max, ...
                    plant_network_min, plant_network_max, ...
                    digester_state_min, digester_state_max, ...
                    params_min, params_max);

%%

[substrateFlow]= ...
    getSubstrateFlowFromIndividual(popBiogas, [10 17 10 2 5 3], plant, substrate, plant_network);
  
disp('substrateFlow: ')
disp(substrateFlow)


%% Dependencies
%
% This method calls:
%
% <html>
% <a href="getnetworkfluxfromindividual.html">
% biogasM.optimization.popBiogas.getNetworkFluxFromIndividual</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_substratefeed_oo_networkflux')">
% biogas_scripts/get_substratefeed_oo_networkflux</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant')">
% biogas_scripts/is_plant</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
%
% <html>
% <a href="popbiogas.html">
% biogasM.optimization.popBiogas</a>
% </html>
% ,
% <html>
% <a href="getinitstatefromindividual.html">
% biogasM.optimization.popBiogas.private.getInitStateFromIndividual</a>
% </html>
%
%% TODOs
% # improve the documentation
% # check documentation
% 
%% <<AuthorTag_DG/>>


