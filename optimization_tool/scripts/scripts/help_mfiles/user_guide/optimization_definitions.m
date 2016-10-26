%% Description of important files, objects, variables used in _GECO-C Optimization_ Toolbox
%
%
%% > Definition of optimization method <
%
% To specify an optimization method to solve an optimization problem a
% character is used which contains the id/name of the method. Most of the
% implemented methods are stochastic methods, which have the advantage that
% they do not get stuck so fast in local optima as non-stochastic methods
% do. They are:
%
% * 'GA' : <matlab:doc('ga') genetic algorithms> using MATLAB's |Genetic
% Algorithm and Direct Search Toolbox| T(TM)
% * 'PSO' : particle swarm optimization using the MATLAB toolbox 
% <http://www.mathworks.com/matlabcentral/fileexchange/7506-particle-swarm-optimization-toolbox 
% PSOt> by Brian Birge.
% * 'ISRES' : "Improved" Evolution Strategy using Stochastic Ranking using
% the <http://www3.hi.is/~tpr/index.php?page=software/sres/sres |ISRES|>
% toolbox.
% * 'DE' : <http://www.icsi.berkeley.edu/~storn/code.html Differential
% Evolution>
% * 'CMAES' : Covariance Matrix Adaptation Evolution Strategy using the
% <http://www.lri.fr/~hansen/cmaes_inmatlab.html |CMA-ES|> implementation
% * 'PS' : <matlab:doc('patternsearch') Pattern Search> using MATLAB's
% |Genetic Algorithm and Direct Search Toolbox|
% * 'SMS-EMOA' : SMS evolutionary multi-objective algorithm. It is a
% multi-objective algorithm.
% * 'SMS-EGO' : SMS efficient global optimization. It is a
% multi-objective algorithm. 
% * ...
%
% The toolbox to which the method belongs to, has to be installed first.
% Most methods are automatically installed with this toolbox. An exception
% is the particle swarm optimization method. 
%
%
%% > Definition of population size <
% This is a natural scalar number that defines the size of the population
% of a population-based optimization method. In population-based
% optimization methods there is a fixed number of solution candidates in
% each iteration of the algorithm. The group of solution candidates are
% called the population in this iteration. Thus, the number of solution
% candidates (they are also called individuals) is the population size. 
%
%% > Definition of number of generations <
% This is a natural scalar number that defines the number of iterations a
% population-based optimization method should run. Iterations are also
% called generations based on the evolutionary idea of most
% population-based algorithms. 
%
%% > Definition of parallel operating mode < 
%
% @param |parallel| : If an optimization process is complex (time consuming) it is 
% possible to distribute the work to a bunch of computers or processors to 
% solve the optimization problem in parallel. The standard value is 'none'.
%
% * 'none'          : use one single processor, no parallel computing
% * 'multicore'     : parallel computing using a multicore processor on one
% PC.
% * 'cluster'       : using Parallel Computing Toolbox functions and MATLAB
% Distributed Computing Server on a computer cluster, such that a number of
% computers can work on the problem. (Not yet working)
%
%
%% > Definition of number of worker < 
%
% @param |nWorker| : number of workers to run in parallel : 
% 2 for a dual core, 4 for a quadcore, when using with 'multicore', else
% number of computers (workers) in the cluster. The standard value is 2,
% when using parallel computing, else 1.
%
%


