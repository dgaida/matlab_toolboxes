%% Syntax
%       optimization.conPopulation()
%       optimization.conPopulation(lenVector)
%       optimization.conPopulation(lenVector, popSize)
%       optimization.conPopulation(lenVector, popSize, A)
%       optimization.conPopulation(lenVector, popSize, A, b)
%       optimization.conPopulation(lenVector, popSize, A, b, Aeq)
%       optimization.conPopulation(lenVector, popSize, A, b, Aeq, beq)
%       optimization.conPopulation(lenVector, popSize, A, b, Aeq, beq, LB)
%       optimization.conPopulation(lenVector, popSize, A, b, Aeq, beq, LB,
%       UB) 
%       optimization.conPopulation(lenVector, popSize, A, b, Aeq, beq, LB,
%       UB, nonlcon) 
%       optimization.conPopulation(lenVector, popSize, A, b, Aeq, beq, LB,
%       UB, nonlcon, solverlist1) 
%       optimization.conPopulation(lenVector, popSize, A, b, Aeq, beq, LB,
%       UB, nonlcon, solverlist1, solverlist2) 
%       optimization.conPopulation(lenVector, popSize, A, b, Aeq, beq, LB,
%       UB, nonlcon, solverlist1, solverlist2, parallel) 
%       optimization.conPopulation(lenVector, popSize, A, b, Aeq, beq, LB,
%       UB, nonlcon, solverlist1, solverlist2, parallel, nWorker) 
%       optimization.conPopulation(lenVector, popSize, A, b, Aeq, beq, LB,
%       UB, nonlcon, solverlist1, solverlist2, parallel, nWorker,
%       data)  
%       optimization.conPopulation(lenVector, popSize, A, b, Aeq, beq, LB,
%       UB, nonlcon, solverlist1, solverlist2, parallel, nWorker,
%       data, lenGenom)  
%       optimization.conPopulation(lenVector, popSize, A, b, Aeq, beq, LB,
%       UB, nonlcon, solverlist1, solverlist2, parallel, nWorker,
%       data, lenGenom, dispValidBounds)  
%       optimization.conPopulation(lenVector, popSize, A, b, Aeq, beq, LB,
%       UB, nonlcon, solverlist1, solverlist2, parallel, nWorker,
%       data, lenGenom, dispValidBounds, plotnonlcon)  
%
%% Description
% Definition of a population where each individual is bounded and constrained to
% (non-)linear (in-)equality constraints. This class can be used to create
% the initial population of an stochastic optimization problem. The matrix
% is created, among others, using the <matlab:doc('ga') |ga|> method out of
% the 'Genetic Algorithm and Direct Search Toolbox' toolbox.
%
% This class can be seen as a interface between the classes
% <matlab:doc('biogas_optimization/popsubstrate')
% biogasM.optimization.popSubstrate>,
% <matlab:doc('biogas_optimization/popplantnetwork') 
% biogasM.optimization.popPlantNetwork>, 
% <matlab:doc('biogas_optimization/popstate') 
% biogasM.optimization.popState>, 
% <matlab:doc('biogas_optimization/popparameters')
% biogasM.optimization.popParameters>,
% and the 
% class <matlab:doc('numerics_tool/conrandmatrix') numerics.conRandMatrix>. It
% automatically detects the size of the optimization problem, given the
% problem provided by the first named classes and transfers the problem
% further to the <matlab:doc('numerics_tool/conrandmatrix')
% numerics.conRandMatrix> class, where the problem is solved.
%
%%
% This class is a handle class, which is derived from the 
% <matlab:doc('numerics_tool/conrandmatrix') |numerics.conRandMatrix|>
% class. 
%
%%
% |optimization.conPopulation()| creates an empty object
%
%%
% |optimization.conPopulation(lenVector)|
%
%%
% @param |lenVector| : defines the dimension of the original problem.
%
%%
% |optimization.conPopulation(lenVector, popSize)|
%
%%
% @param |popSize| : population size of the matrix
%
%%
% |optimization.conPopulation(lenVector, popSize, A)|
%
%%
% @param |A| : matrix of the linear inequality constraints in the dimension
% of the original problem. 
%
%%
% |optimization.conPopulation(lenVector, popSize, A, b)|
%
%%
% @param |b| : double vector of the inequality constraint $A \cdot x \leq b$
%
%%
% |optimization.conPopulation(lenVector, popSize, A, b, Aeq)|
%
%%
% @param |Aeq| : matrix of the linear equality constraints in the dimension
% of the original problem. 
%
%%
% |optimization.conPopulation(lenVector, popSize, A, b, Aeq, beq)|
%
%%
% @param |beq| : double vector of the equality constraint $A_{eq} \cdot x =
% b_{eq}$ 
%
%%
% |optimization.conPopulation(lenVector, popSize, A, b, Aeq, beq, LB)|
%
%%
% @param |LB| : vector with lower bounds in the dimension
% of the original problem. 
%
%%
% |optimization.conPopulation(lenVector, popSize, A, b, Aeq, beq, LB, UB)|
%
%%
% @param |UB| : vector with upper bounds in the dimension
% of the original problem. 
%
%%
% |optimization.conPopulation(lenVector, popSize, A, b, Aeq, beq, LB, UB,
% nonlcon)|
%
%%
% @param |nonlcon| : <matlab:doc('function_handle') function_handle> with
% nonlinear (in-)equality constraints
%
%%
% |optimization.conPopulation(lenVector, popSize, A, b, Aeq, beq, LB,
% UB, nonlcon, solverlist1)|
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
% |optimization.conPopulation(lenVector, popSize, A, b, Aeq, beq, LB,
% UB, nonlcon, solverlist1, solverlist2)|
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
% |optimization.conPopulation(lenVector, popSize, A, b, Aeq, beq, LB,
% UB, nonlcon, solverlist1, solverlist2, parallel)|
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
% |optimization.conPopulation(lenVector, popSize, A, b, Aeq, beq, LB,
% UB, nonlcon, solverlist1, solverlist2, parallel, nWorker)|
%
%%
% @param |nWorker| : number of workers
%
%%
% @param |data| : data which is used as e.g. initial population for the to
% be solved optimization problem that the data should satisfy the
% constraints. the rows in |data| satisfying the constraints already, are
% not changed, the data not yet satisfying the constraints are changed as
% wanted.
%
%%
% @param |lenGenom| : length of the genome
%
%%
% @param |dispValidBounds| : integer, scalar
% 
% * 0 : If boundaries hold then no message is returned. Default. 
% * 1 : for each boundary that holds a message is returned. 
%
%%
% @param |plotnonlcon| : if 1, then nonlinear constraints are plotted, else
% 0. Since plotting the nonlinear constraints is very ressources consuming,
% this parameter should be set to 0 to spare time and memory.
%
%% Example
%
%% 1-D Examples
% 
% <html>
% <a href="conpopulation_samples1d.html">
% 1-D Examples</a>
% </html>
% 
%% 2-D Examples
% 
% <html>
% <a href="conpopulation_samples2d.html">
% 2-D Examples</a>
% </html>
% 
%% 3-D Examples
% 
% <html>
% <a href="conpopulation_samples3d.html">
% 3-D Examples</a>
% </html>
%       
%%
%

optimization.conPopulation()

%% Dependencies
%
% The constructor of this class calls:
%
% <html>
% <a href="matlab:doc('numerics_tool/conrandmatrix')">
% numerics_tool/numerics.conRandMatrix</a>
% </html>
% ,
% <html>
% <a href="getminimaldescription.html">
% optimization.conPopulation.private.getMinimalDescription</a>
% </html>
% ,
% <html>
% <a href="adaptconstraintstolengenom.html">
% optimization.conPopulation.private.adaptConstraintsToLenGenom</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_optimization/popbiogas')">
% biogas_optimization/biogasM.optimization.popBiogas</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/popparameters')">
% biogas_optimization/biogasM.optimization.popParameters</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/popplantnetwork')">
% biogas_optimization/biogasM.optimization.popPlantNetwork</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/popstate')">
% biogas_optimization/biogasM.optimization.popState</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/popsubstrate')">
% biogas_optimization/biogasM.optimization.popSubstrate</a>
% </html>
%
%% See Also
%
% <html>
% <a href="getindividualbymask.html">
% optimization.conPopulation.getIndividualByMask</a>
% </html>
%
%% TODOs
% # go through documentation, maybe improve it
%
%% <<AuthorTag_DG/>>


