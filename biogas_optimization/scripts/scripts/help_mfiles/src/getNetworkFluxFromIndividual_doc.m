%% Syntax
%       [networkFlux, fluxString, lenFluxIndividual]=
%       getNetworkFluxFromIndividual(popBiogas, u, plant, substrate,
%       plant_network) 
%
%% Description
% |getNetworkFluxFromIndividual| returns from the individual |u| the
% networkflux in values (|networkFlux|) and words (|fluxString|).
%
% |networkFlux| and |fluxString| contain each substrate mix flow, even if
% it is 0, but it only contains those pump fluxes which are > 0 && < Inf. 
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
% @return |networkFlux| : 
%
%%
% @return |fluxString| : 
%
%%
% @return |lenFluxIndividual| : length of the individual belonging to the
% flux
%
%% Example
% 
%

plant_id= 'gummersbach';

parallel= 'none';
nWorker= 1;

[substrate, plant, substrate_network, plant_network, ...
   substrate_network_min, substrate_network_max, ...
   plant_network_min, plant_network_max, ...
   digester_state_min, digester_state_max, ...
   params_min, params_max, ...
   substrate_eq, substrate_ineq, fitness_params]= ...
                                load_biogas_mat_files(plant_id);

[popBiogas]= biogasM.optimization.popBiogas(0, ...
                    substrate_network_min, substrate_network_max, ...
                    plant_network_min, plant_network_max, ...
                    digester_state_min, digester_state_max, ...
                    params_min, params_max, ...
                    substrate_ineq, substrate_eq, ...
                    @(obj)@(u)nonlcon_substrate(u, plant, substrate, ...
                                        obj, fitness_params.TS_feed_max), ...
                    [], [], @(u)nonlcon_plant(u), ...
                    [], [], [], ...
                    @(u)nonlcon_params(u), ...
                    parallel, nWorker, [], 2);

%%

[networkFlux, fluxString, lenFluxIndividual]= ...
    getNetworkFluxFromIndividual(popBiogas, [10 17 10 2 5 3], plant, substrate, plant_network);
  
disp('networkFlux: ')
disp(networkFlux)
disp('fluxString: ')
disp(fluxString)
disp('lenFluxIndividual: ')
disp(lenFluxIndividual)

%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('optimization_tool/getindividualbymask')">
% optimization_tool/optimization.conPopulation.getIndividualByMask</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('nonlcon_substrate')">
% nonlcon_substrate</a>
% </html>
% ,
% <html>
% <a href="getequilibriumfromindividual.html">
% biogasM.optimization.popBiogas.getEquilibriumFromIndividual</a>
% </html>
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
% ,
% <html>
% <a href="matlab:doc('getnetworkfluxthreshold')">
% getNetworkFluxThreshold</a>
% </html>
%
%% TODOs
% # improve the documentation
% 
%% <<AuthorTag_DG/>>


