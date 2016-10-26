%% Syntax
%       biogasM.optimization.popParameters()
%       biogasM.optimization.popParameters(lenVector)
%       biogasM.optimization.popParameters(lenVector, popSize)
%       biogasM.optimization.popParameters(lenVector, popSize, params_ineq)
%       biogasM.optimization.popParameters(lenVector, popSize, params_ineq,
%       params_eq) 
%       biogasM.optimization.popParameters(lenVector, popSize, params_ineq,
%       params_eq, LB) 
%       biogasM.optimization.popParameters(lenVector, popSize, params_ineq,
%       params_eq, LB, UB)
%       biogasM.optimization.popParameters(lenVector, popSize, params_ineq,
%       params_eq, LB, UB, nonlcon)
%       biogasM.optimization.popParameters(lenVector, popSize, params_ineq,
%       params_eq, LB, UB, nonlcon, solverlist1)
%       biogasM.optimization.popParameters(lenVector, popSize, params_ineq,
%       params_eq, LB, UB, nonlcon, solverlist1, solverlist2)
%       biogasM.optimization.popParameters(lenVector, popSize, params_ineq,
%       params_eq, LB, UB, nonlcon, solverlist1, solverlist2, parallel)
%       biogasM.optimization.popParameters(lenVector, popSize, params_ineq,
%       params_eq, LB, UB, nonlcon, solverlist1, solverlist2, parallel,
%       nWorker) 
%
%% Description
% Definition of a population for the ADM1 parameters where each individual is
% bounded and constrained to (non-)linear (in-)equality constraints. This
% class can be used to create the initial population of a stochastic
% optimization problem. The matrix is created using, among others, the
% <matlab:doc('ga') |ga|>
% method out of the 'Genetic Algorithm and Direct Search Toolbox' toolbox.
%
%%
% This class is a handle class, which is derived from the
% <matlab:doc('optimization_tool/conpopulation')
% |optimization.conPopulation|> class. 
%
%%
% |biogasM.optimization.popParameters()| creates an empty object.
%
%%
% |biogasM.optimization.popParameters(lenVector)|
%
%%
% @param |lenVector| : defines the dimension of the original problem, here
% it is equal to number of ADM1 parameters which should be optimized
%
%%
% |biogasM.optimization.popParameters(lenVector, popSize)|
%
%%
% @param |popSize| : population size of the matrix
%
%%
% |biogasM.optimization.popParameters(lenVector, popSize, params_ineq)|
%
%%
% @param |params_ineq| : matrix and vector of the linear inequality
% constraints in the dimension of the original problem, in the form:
%
% params_ineq= [A, b]
%
%%
% |biogasM.optimization.popParameters(lenVector, popSize, params_ineq,
% params_eq)|
%
%%
% @param |params_eq| : matrix and vector of the linear equality
% constraints in the dimension of the original problem, in the form:
%
% params_eq= [Aeq, beq]
%
%%
% |biogasM.optimization.popParameters(lenVector, popSize, params_ineq,
% params_eq, LB)|
%
%%
% @param |LB| : vector with lower bounds in the dimension
% of the original problem. 
%
%%
% |biogasM.optimization.popParameters(lenVector, popSize, params_ineq,
% params_eq, LB, UB)|
%
%%
% @param |UB| : vector with upper bounds in the dimension
% of the original problem. 
%
%%
% |biogasM.optimization.popParameters(lenVector, popSize, params_ineq,
% params_eq, LB, UB, nonlcon)|
%
%%
% @param |nonlcon| : <matlab:doc('function_handle') function_handle> with
% nonlinear (in-)equality constraints, see <matlab:doc('nonlcon_params')
% nonlcon_params>. 
%
%%
% |biogasM.optimization.popParameters(lenVector, popSize, params_ineq,
% params_eq, LB, UB, nonlcon, solverlist1)|
%
%%
% @param |solverlist1| : <matlab:doc('cellstr') cellstring> with solvers
% which solve one after 
% another the problem finding a valid set of points satisfying the given
% constraints. At the moment possible solvers are
%
% * 'GA' : using <matlab:doc('optimization_tool/startga') Genetic
% Algorithm> (GA) 
% * 'PS' : using <matlab:doc('optimization_tool/startpatternsearch')
% Pattern Search> 
% * 'SA' : using <matlab:doc('optimization_tool/startsimulannealing')
% Simulated Annealing>
% * 'ISRES' : <matlab:doc('optimization_tool/startisres') improved
% Stochastic Ranking Evolution Strategy>
% * 'PSO' : <matlab:doc('optimization_tool/startpso') Particle Swarm
% Optimization>
% * 'CMAES' : <matlab:doc('optimization_tool/startcmaes') CMA-Evolution
% Strategy>
% * 'DE' : <matlab:doc('optimization_tool/startde') Differential
% Evolution>
%
%%
% |biogasM.optimization.popParameters(lenVector, popSize, params_ineq,
% params_eq, LB, UB, nonlcon, solverlist1, solverlist2)|
%
%%
% @param |solverlist2| : <matlab:doc('cellstr') cellstring> with solvers
% which solve one after 
% another the problem changing the set of points such that they satisfy the
% given constraints and have the given distribution. At the moment possible
% solvers are 
%
% * 'GA' : using <matlab:doc('optimization_tool/startga') Genetic
% Algorithm> (GA) 
% * 'PS' : using <matlab:doc('optimization_tool/startpatternsearch')
% Pattern Search> 
% * 'GA+PS' : using a combination of
% <matlab:doc('optimization_tool/startga_patternsearch') GA and PS>
% * 'SA' : using <matlab:doc('optimization_tool/startsimulannealing')
% Simulated Annealing>
% * 'ISRES' : <matlab:doc('optimization_tool/startisres') improved
% Stochastic Ranking Evolution Strategy>
% * 'PSO' : <matlab:doc('optimization_tool/startpso') Particle Swarm
% Optimization>
% * 'CMAES' : <matlab:doc('optimization_tool/startcmaes') CMA-Evolution
% Strategy>
% * 'DE' : <matlab:doc('optimization_tool/startde') Differential
% Evolution>
%
% e.g. {'PS', 'ISRES', 'GA'}
%
%%
% |biogasM.optimization.popParameters(lenVector, popSize, params_ineq,
% params_eq, LB, UB, nonlcon, solverlist1, solverlist2, parallel)|
%
%%
% @param |parallel| : char 
%
% * 'none' : the optimization method do not run in parallel
% * 'multicore' : if it is possible for the optimization method to run in
% parallel, like 'GA', 'PSO', then it is started in parallel on a multicore
% processor
% * 'cluster' : the optimiaztion method is started in parallel assuming it
% is run on a computer cluster
%
%%
% |biogasM.optimization.popParameters(lenVector, popSize, params_ineq,
% params_eq, LB, UB, nonlcon, solverlist1, solverlist2, parallel,
% nWorker)|
%
%%
% @param |nWorker| : number of workers
%
%% Example
%

biogasM.optimization.popParameters(3, 10, [], [], ...
                                  [0.1, 0.3, 1.2], [2.41, 3.2, 4.5])

%% Dependencies
%
% The constructor of this class calls:
%
% <html>
% <a href="matlab:doc('optimization_tool/conpopulation')">
% optimization_tool/optimization.conPopulation</a>
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
% <a href="popbiogas.html">
% biogasM.optimization.popBiogas</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc('numerics_tool/conrandmatrix')">
% numerics_tool/numerics.conRandMatrix</a>
% </html>
% ,
% <html>
% <a href="popstate.html">
% biogasM.optimization.popState</a>
% </html>
% ,
% <html>
% <a href="popplantnetwork.html">
% biogasM.optimization.popPlantNetwork</a>
% </html>
% ,
% <html>
% <a href="popsubstrate.html">
% biogasM.optimization.popSubstrate</a>
% </html>
%
%% TODOs
% # improve documentation
%
%% <<AuthorTag_DG/>>


