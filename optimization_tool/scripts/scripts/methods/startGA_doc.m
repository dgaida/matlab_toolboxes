%% Preliminaries
% This function depends on the |Genetic Algorithm and Direct Search
% Toolbox| so this toolbox has to be installed first. 
%
%% Syntax
%       u= startGA(ObjectiveFunction, lenIndividual)
%       u= startGA(ObjectiveFunction, lenIndividual, LB)
%       u= startGA(ObjectiveFunction, lenIndividual, LB, UB)
%       u= startGA(ObjectiveFunction, lenIndividual, LB, UB, u0)
%       startGA(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize)
%       startGA(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize,
%       noGenerations) 
%       startGA(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize,
%       noGenerations, timelimit) 
%       startGA(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize,
%       noGenerations, timelimit, tolerance) 
%       startGA(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize,
%       noGenerations, timelimit, tolerance, A, b)
%       startGA(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize,
%       noGenerations, timelimit, tolerance, A, b, Aeq, beq)
%       startGA(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize,
%       noGenerations, timelimit, tolerance, A, b, Aeq, beq, parallel)
%       startGA(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize,
%       noGenerations, timelimit, tolerance, A, b, Aeq, beq, parallel,
%       nWorker) 
%       startGA(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize,
%       noGenerations, timelimit, tolerance, A, b, Aeq, beq, parallel,
%       nWorker, OutputFcn) 
%       [u, fitness]= startGA(...)
%       [u, fitness, exitflag]= startGA(...)
%       [u, fitness, exitflag, output]= startGA(...)
%       [u, fitness, exitflag, output, population]= startGA(...)
%       [u, fitness, exitflag, output, population, scores]= startGA(...)
%
%% Description
% |u= startGA(ObjectiveFunction, lenIndividual)| prepares and
% starts genetic algorithm with standard settings to minimize given fitness
% function |ObjectiveFunction|. 
%
%%
% @param |ObjectiveFunction| : a <matlab:doc('function_handle')
% function_handle> with the objective function, which GA minimizes. 
%
%%
% @param |lenIndividual| : the length of the individual, double scalar
% integer
%
%%
% @return |u| : optimal individual, row vector
%
%%
% |[u, fitness]= startGA(ObjectiveFunction, lenIndividual, LB)|
%
%%
% @param |LB| : lower bound of the individual, double vector with
% |lenIndividual| components
%
%%
% |[u, fitness]= startGA(ObjectiveFunction, lenIndividual, LB, UB)|
%
%%
% @param |UB| : upper bound of the individual, double vector with
% |lenIndividual| components
%
%%
% |[u, fitness]= startGA(ObjectiveFunction, lenIndividual, LB, UB, u0)|
%
%%
% @param |u0| : (part of the) initial population. matrix with
% |lenIndividual| columns and arbitrarily many rows. 
%
%%
% |startGA(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize)|
%
%%
% @param |popSize| : size of the wanted population of the GA algorithm,
% double scalar integer
%
%%
% |startGA(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize,
% noGenerations)| 
%
%%
% @param |noGenerations| : number of generations to run, double scalar
% integer
%
%%
% |startGA(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize,
% noGenerations, timelimit)| 
%
%%
% @param |timelimit| : time limit for the whole optimization process in
% seconds, double scalar
%
%%
% |startGA(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize,
% noGenerations, timelimit, tolerance)| 
%
%%
% @param |tolerance| : tolerance in the change of the fitness before ending
% the optimization process, double scalar
%
%%
% |startGA(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize,
% noGenerations, timelimit, tolerance, A, b)| 
%
%%
% @param |A| : linear matrix inequality constraint
%
%%
% @param |b| : linear matrix inequality constraint
%
%%
% |startGA(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize,
% noGenerations, timelimit, tolerance, A, b, Aeq, beq)|
%
%%
% @param |Aeq| : linear matrix equality constraint
%
%%
% @param |beq| : linear matrix equality constraint
%
%%
% |startGA(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize,
% noGenerations, timelimit, tolerance, A, b, Aeq, beq, parallel)| 
%
%%
% @param |parallel| : It is 
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
%%
% |startGA(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize,
% noGenerations, timelimit, tolerance, A, b, Aeq, beq, parallel, nWorker)| 
%
%%
% @param |nWorker|    : number of workers to run in parallel : 
% 2 for a dual core, 4 for a quadcore, when using with 'multicore', else
% number of computers (workers) in the cluster. The standard value is 2,
% when using parallel computing, else 1.
%
%%
% |[u, fitness]= startGA(...)|
%
%%
% @return |fitness| : fitness of the optimal individual
%
%%
% |[u, fitness, exitflag]= startGA(...)|
%
%%
% @return |exitflag| : exitflag of ga
%
%%
% |[u, fitness, exitflag, output]= startGA(...)|
%
%%
% @return |output| : output message of the optimization algorithm
%
%%
% |[u, fitness, exitflag, output, population]= startGA(...)|
%
%%
% @return |population| : final population
%
%%
% |[u, fitness, exitflag, output, population, scores]= startGA(...)|
%
%%
% @return |scores| : fitness values of the individuals in the final population
%
%% Example
% 
% # Solve generalized Rastrigin's Function using Genetic Algorithms

nvars= 5;

LB= -5.12.*ones(nvars,1);
UB= 5.12.*ones(nvars,1);

popSize= 75;
maxIter= 75;

[u, fitnessGA]= startGA(@fitness_rastrigin, ...
                        nvars, LB, UB, [], popSize, maxIter);
    
disp(u)
disp(fitnessGA);

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="setgaoptions.html">
% setGAOptions</a>
% </html>
% ,
% <html>
% <a href="setparallelconfiguration.html">
% setParallelConfiguration</a>
% </html>
% ,
% <html>
% <a href="matlab:doc ga">
% matlab/ga</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validatestring')">
% matlab/validatestring</a>
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
% ,
% <html>
% <a href="matlab:doc('numerics_tool/getoptimalpopulation')">
% numerics_tool/numerics.conRandMatrix.getOptimalPopulation</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('numerics_tool/getvalidsetofpoints')">
% numerics_tool/numerics.conSetOfPoints.getValidSetOfPoints</a>
% </html>
%
%% See Also
%
% <html>
% <a href="startpso.html">
% startPSO</a>
% </html>
% ,
% <html>
% <a href="startpatternsearch.html">
% startPatternSearch</a>
% </html>
% ,
% <html>
% <a href="startga_patternsearch.html">
% startGA_PatternSearch</a>
% </html>
% ,
% <html>
% <a href="startde.html">
% startDE</a>
% </html>
% ,
% <html>
% <a href="startcmaes.html">
% startCMAES</a>
% </html>
% ,
% <html>
% <a href="startisres.html">
% startISRES</a>
% </html>
% ,
% <html>
% <a href="startfmincon.html">
% startFMinCon</a>
% </html>
% ,
% <html>
% <a href="startstdpsokriging.html">
% startStdPSOKriging</a>
% </html>
% ,
% <html>
% <a href="startpsokriging.html">
% startPSOKriging</a>
% </html>
% ,
% <html>
% <a href="fitness_rastrigin.html">
% fitness_rastrigin</a>
% </html>
% ,
% <html>
% <a href="fitness_schwefel.html">
% fitness_schwefel</a>
% </html>
%
%% TODOs
% # Parameterreihenfolge sollte noch mal überdacht werden,
% objfunction,...,A,b,Aeq,beq,LB,UB, und dann die Optionen sollte besser
% sein 
% # Lagere die params Überprüfung in eine separete Funktion aus, welche von
% allen Methoden aufgerufen wird.
% # improve documentation
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% <a href="http://www.mathworks.com/products/global-optimization/index.html?ref=pfo" 
% target="_top">
% Global Optimization Toolbox 3.0
% </li>
% </ol>
% </html>
%


