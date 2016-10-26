%% Syntax
%        fitness= getFitnessNonlconFromIndividual(obj, u)
%
%% Description
% |getFitnessNonlconFromIndividual| calculates the fitness of the passed
% individual |u| with respect to nonlinear (in-)equality constraints
% defined in the object |obj| of the <popbiogas.html
% |biogasM.optimization.popBiogas|> class. 
%
% The following nonlinear constraints are checked:
% 
% * substrate of the class <popsubstrate.html
% biogasM.optimization.popSubstrate> 
% * plant of the class <popplantnetwork.html
% biogasM.optimization.popPlantNetwork>.  
% * state of the class <popstate.html biogasM.optimization.popState>.
% * params of the class <popparameters.html
% biogasM.optimization.popParameters>. 
%
%%
% @param |obj| : object of the <popbiogas.html
% |biogasM.optimization.popBiogas|> class 
%
%%
% @param |u| : the individual, double row vector
%
%%
% @return |fitness| : fitness of the given individual. fitness is 0, if all
% constraints hold, else it is > 0. 
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
                    parallel, nWorker, [], 1);%2);%1);%2);%1);

[popBiogas]= biogasM.optimization.popBiogas(10, ...
                    substrate_network_min, substrate_network_max, ...
                    plant_network_min, plant_network_max, ...
                    digester_state_min, digester_state_max, ...
                    params_min, params_max, ...
                    substrate_ineq, substrate_eq, ...
                    @(u)nonlcon_substrate(u, plant, substrate, ...
                            popBiogas, fitness_params.TS_feed_max), ...
                    [], [], @(u)nonlcon_plant(u), ...
                    [], [], [], ...
                    @(u)nonlcon_params(u), ...
                    parallel, nWorker, [], 1);%2);%1);%2);%1);

%%
%

getFitnessNonlconFromIndividual(popBiogas, [40 2 3])

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
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('fitnessfindoptimalequilibrium')">
% fitnessFindOptimalEquilibrium</a>
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
% <a href="matlab:doc('nonlcon_substrate')">
% nonlcon_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('nonlcon_plant')">
% nonlcon_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('nonlcon_params')">
% nonlcon_params</a>
% </html>
%
%% TODOs
% # improve example, plot nonlinear constraint
%
%% <<AuthorTag_DG/>>


