%% Syntax
%        equilibrium= getEquilibriumFromIndividual(obj, u, plant,
%        substrate, plant_network, fitness) 
%
%% Description
% |equilibrium= getEquilibriumFromIndividual(obj, u, plant, substrate,
% plant_network, fitness)| creates the equilibrium struct |equilibrium| out
% of the passed individual |u|. First it gets the network flux from the
% individual calling <getnetworkfluxfromindividual.html
% getNetworkFluxFromIndividual> and sets the variables |network_flux| and
% |network_flux_string| inside the equilibrium structure. Furthermore it
% calls <getinitstatefromindividual.html getInitStateFromIndividual> which
% generates the initial states of the digesters and hydraulic delays out of
% the individual |u|. 
%
%%
% @param |obj| : object of the class <popbiogas.html 
% biogasM.optimization.popBiogas>
%
%%
% @param |u| : the individual, double row vector
%
%%
% @param |plant| : object of the C# class |biogas.plant|
%
%%
% @param |substrate| : object of the C# class |biogas.substrates|
%
%%
% @param |plant_network| : see the struct file
%
%%
% @param |fitness| : the fitness value of the individual, double scalar
%
%%
% @return |equilibrium| : the equilibrium structure for the given individual
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

[equilibrium]= getEquilibriumFromIndividual(popBiogas, [5 7 3 2 5 3], ...
                                 plant, substrate, plant_network, 0);
  
disp('equilibrium: ')
disp(equilibrium)


%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('numerics_tool/getpointsinfulldimension')">
% numerics_tool/numerics.conSetOfPoints.getPointsInFullDimension</a>
% </html>
% ,
% <html>
% <a href="getnetworkfluxfromindividual.html">
% biogasM.optimization.popBiogas.getNetworkFluxFromIndividual</a>
% </html>
% ,
% <html>
% <a href="getinitstatefromindividual.html">
% biogasM.optimization.popBiogas.getInitStateFromIndividual</a>
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
% <a href="matlab:doc('adm1_analysis_substrate')">
% ADM1_analysis_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('adm1_analysis_reachability')">
% ADM1_analysis_reachability</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('digester_state_nonlcon')">
% digester_state_nonlcon</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('findoptimalequilibrium')">
% findOptimalEquilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('fitnessfindoptimalequilibrium')">
% fitnessFindOptimalEquilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('getinitpopofequilibria')">
% getInitPopOfEquilibria</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nonlinearmpc')">
% biogas_control/nonlinearMPC</a>
% </html>
% ,
% <html>
% ...
% </html>
%
%% See Also
%
% <html>
% <a href="popbiogas.html">
% biogasM.optimization.popBiogas</a>
% </html>
%
%% TODOs
% # improve documentation
%
%% <<AuthorTag_DG/>>


