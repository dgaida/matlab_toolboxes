%% Syntax
%       biogasM.optimization.popSubstrate()
%       biogasM.optimization.popSubstrate(lenVector)
%       biogasM.optimization.popSubstrate(lenVector, popSize)
%       biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq)
%       biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq,
%       substrate_eq) 
%       biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq,
%       substrate_eq, LB) 
%       biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq,
%       substrate_eq, LB, UB)
%       biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq,
%       substrate_eq, LB, UB, nonlcon)
%       biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq,
%       substrate_eq, LB, UB, nonlcon, solverlist1)
%       biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq,
%       substrate_eq, LB, UB, nonlcon, solverlist1, solverlist2)
%       biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq,
%       substrate_eq, LB, UB, nonlcon, solverlist1, solverlist2, parallel)
%       biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq,
%       substrate_eq, LB, UB, nonlcon, solverlist1, solverlist2, parallel,
%       nWorker) 
%       biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq,
%       substrate_eq, LB, UB, nonlcon, solverlist1, solverlist2, parallel)
%       biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq,
%       substrate_eq, LB, UB, nonlcon, solverlist1, solverlist2, parallel,
%       nWorker, data)
%       biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq,
%       substrate_eq, LB, UB, nonlcon, solverlist1, solverlist2, parallel)
%       biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq,
%       substrate_eq, LB, UB, nonlcon, solverlist1, solverlist2, parallel,
%       nWorker, data, lenGenom) 
%
%% Description
% Definition of a population for the substrate mix where each individual is
% bounded and constrained to (non-)linear (in-)equality constraints. This
% class can be used to create the initial population of an stochastic
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
% |biogasM.optimization.popSubstrate()| creates an empty object.
%
%%
% |biogasM.optimization.popSubstrate(lenVector)|
%
%%
% @param |lenVector| : defines the dimension of the original problem, here
% it is equal to number of substrates * number of fermenter
%
%%
% |biogasM.optimization.popSubstrate(lenVector, popSize)|
%
%%
% @param |popSize| : population size of the matrix
%
%%
% |biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq)|
%
%%
% @param |substrate_ineq| : matrix and vector of the linear inequality
% constraints in the dimension of the original problem, in the form:
%
% substrate_ineq= [A, b]
%
%%
% |biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq,
% substrate_eq)|
%
%%
% @param |substrate_eq| : matrix and vector of the linear equality
% constraints in the dimension of the original problem, in the form:
%
% substrate_eq= [Aeq, beq]
%
%%
% |biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq,
% substrate_eq, LB)|
%
%%
% @param |LB| : vector with lower bounds in the dimension
% of the original problem. 
%
%%
% |biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq,
% substrate_eq, LB, UB)|
%
%%
% @param |UB| : vector with upper bounds in the dimension
% of the original problem. 
%
%%
% |biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq,
% substrate_eq, LB, UB, nonlcon)|
%
%%
% @param |nonlcon| : <matlab:doc('function_handle') function_handle> with
% nonlinear (in-)equality constraints, see <matlab:doc('nonlcon_substrate')
% nonlcon_substrate> 
%
%%
% |biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq,
% substrate_eq, LB, UB, nonlcon, solverlist1)|
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
% |biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq,
% substrate_eq, LB, UB, nonlcon, solverlist1, solverlist2)|
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
% |biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq,
% substrate_eq, LB, UB, nonlcon, solverlist1, solverlist2, parallel)|
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
% |biogasM.optimization.popSubstrate(lenVector, popSize, substrate_ineq,
% substrate_eq, LB, UB, nonlcon, solverlist1, solverlist2, parallel,
% nWorker)|
%
%%
% @param |nWorker| : number of workers
%
%% Example
%

biogasM.optimization.popSubstrate(3, 10, [1 1 0 30], [], ...
                                  [0, 1, 0.5], [25, 30, 0.5], [], {'CMAES'})
      
%%

biogasM.optimization.popSubstrate(2, 10, [1 0 30], [], ...
                                  [0, 0.5], [25, 0.5], [], {'CMAES'}, ...
                                  [], [], [], [], 2)
      
%%

biogasM.optimization.popSubstrate(3, 10, [1 0 0 30], [1 0 1 10], ...
                                  [0, 0.5 0], [25, 0.5 20], [], {'CMAES'}, ...
                                  [], [], [], [], 2)
                                    
%% Dependencies
%
% The constructor of this class calls:
%
% <html>
% <a href="matlab:doc('optimization_tool/conpopulation')">
% optimization_tool/optimization.conPopulation</a>
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
% <a href="popparameters.html">
% biogasM.optimization.popParameters</a>
% </html>
%
%% TODOs
% # improve documentation
%
%% <<AuthorTag_DG/>>


