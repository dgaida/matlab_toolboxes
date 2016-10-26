%% Syntax
%       u= getIndividualFromEquilibrium(obj, equilibrium, plant)
%       
%% Description
% |u= getIndividualFromEquilibrium(obj, equilibrium, plant)|
%
%%
% @param |obj| : object of the <popbiogas.html
% |biogas.optimization.popBiogas|> class 
%
%%
% @param |equilibrium| : the equilibrium structure
%
%%
% @param |plant| : the structure of the plant, object of C# class
% |biogas.plant| 
%
%%
% @return |u| : the individual belonging to the |equilibrium|, double row
% vector
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

%%
%

u= getIndividualFromEquilibrium(popBiogas, equilibrium, plant);

disp('u: ')
disp(u)


%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('numerics_tool/getpointsinconstraineddimension')">
% numerics_tool/numerics.conSetOfPoints.getPointsInConstrainedDimension</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('optimization_tool/getindividualbymask')">
% optimization.conPopulation.getIndividualByMask</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('findoptimalequilibrium')">
% findOptimalEquilibrium</a>
% </html>
%
%% See Also
%
% <html>
% <a href="popbiogas.html">
% biogas.optimization.popBiogas</a>
% </html>
%
%% TODOs
% # improve documentation
%
%% <<AuthorTag_DG/>>


