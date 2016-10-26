%% Preliminaries
% This function depends on the Genetic Algorithm and Direct Search
% Toolbox so MATLAB's Global Optimization Toolbox has to be installed first. 
%
%% Syntax
%       u= startPatternSearch(ObjectiveFunction, u0)
%       u= startPatternSearch(ObjectiveFunction, u0, LB) 
%       u= startPatternSearch(ObjectiveFunction, u0, LB, UB) 
%       startPatternSearch(ObjectiveFunction, u0, LB, UB, maxIter) 
%       startPatternSearch(ObjectiveFunction, u0, LB, UB, maxIter,
%       timelimit) 
%       startPatternSearch(ObjectiveFunction, u0, LB, UB, maxIter,
%       timelimit, tolerance) 
%       startPatternSearch(ObjectiveFunction, u0, LB, UB, maxIter,
%       timelimit, tolerance, A, b) 
%       startPatternSearch(ObjectiveFunction, u0, LB, UB, maxIter,
%       timelimit, tolerance, A, b, Aeq, beq) 
%       startPatternSearch(ObjectiveFunction, u0, LB, UB, maxIter,
%       timelimit, tolerance, A, b, Aeq, beq, parallel)
%       startPatternSearch(ObjectiveFunction, u0, LB, UB, maxIter,
%       timelimit, tolerance, A, b, Aeq, beq, parallel, nWorker)
%       startPatternSearch(ObjectiveFunction, u0, LB, UB, maxIter,
%       timelimit, tolerance, A, b, Aeq, beq, parallel, nWorker,
%       searchMethod) 
%       [u, fitness]= startPatternSearch(...)
%       [u, fitness, exitflag]= startPatternSearch(...)
%       [u, fitness, exitflag, output]= startPatternSearch(...)
%
%% Description
% |u= startPatternSearch(ObjectiveFunction, u0)| prepares and starts 
% pattern search with standard settings to minimize the given objective
% function |ObjectiveFunction|. 
%
%%
% @param |ObjectiveFunction| : a <matlab:doc('function_handle')
% function_handle> with the objective function,
% which pattern search minimizes.
%
%%
% @param |u0| : (part of the) initial population
%
%%
% @return |u| : optimal individual
%
%%
% |[u]= startPatternSearch(ObjectiveFunction, u0, LB)|
%
%%
% @param |LB| : lower bound of the individual, double vector with
% as many components as the dimension of the problem
%
%%
% |[u]= startPatternSearch(ObjectiveFunction, u0, LB, UB)|
%
%%
% @param |UB| : upper bound of the individual, double vector with
% as many components as the dimension of the problem
%
%%
% |[u]= startPatternSearch(ObjectiveFunction, u0, LB, UB, maxIter)|
%
%%
% @param |maxIter| : maximal number of iterations, double scalar
% integer
%
%%
% |startPatternSearch(ObjectiveFunction, u0, LB, UB, maxIter, timelimit)|
%
%%
% @param |timelimit| : time limit in seconds the algorithm may run, double
% scalar 
%
%%
% |startPatternSearch(ObjectiveFunction, u0, LB, UB, maxIter, timelimit,
% tolerance)| 
%
%%
% @param |tolerance| : tolerance in the change of the fitness before ending
% the optimization process, double scalar
%
%%
% |startPatternSearch(ObjectiveFunction, u0, LB, UB, maxIter, timelimit,
% tolerance, A, b)| 
%
%%
% @param |A| : linear matrix inequality constraint
%
%%
% @param |b| : linear matrix inequality constraint
%
%%
% |startPatternSearch(ObjectiveFunction, u0, LB, UB, maxIter, timelimit,
% tolerance, A, b, Aeq, beq)| 
%
%%
% @param |Aeq| : linear matrix equality constraint
%
%%
% @param |beq| : linear matrix equality constraint
%
%%
% |startPatternSearch(ObjectiveFunction, u0, LB, UB, maxIter, timelimit,
% tolerance, A, b, Aeq, beq, parallel)| 
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
% |startPatternSearch(ObjectiveFunction, u0, LB, UB, maxIter, timelimit,
% tolerance, A, b, Aeq, beq, parallel, nWorker)| 
%
%%
% @param |nWorker|    : number of workers to run in parallel : 
% 2 for a dual core, 4 for a quadcore, when using with 'multicore', else
% number of computers (workers) in the cluster. The standard value is 2,
% when using parallel computing, else 1.
%
%%
% |[u, fitness]= startPatternSearch(...)|
%
%%
% @return |fitness| : fitness of the optimal individual
%
%%
% |[u, fitness, exitflag]= startPatternSearch(...)|
%
%%
% @return |exitflag| : exitflag of pattern search
%
%%
% |[u, fitness, exitflag, output]= startPatternSearch(...)|
%
%%
% @return |output| : output message of the optimization algorithm
%
%% Example
% 
% # Solve generalized Rastrigin's Function using Pattern Search

nvars= 5;

LB= -5.12.*ones(nvars,1);
UB= 5.12.*ones(nvars,1);

maxIter= 75;

[u, fitnessPS]= startPatternSearch(@fitness_rastrigin, ...
                                   [], LB, UB, maxIter);

disp(u)
disp(fitnessPS)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="setparallelconfiguration.html">
% setParallelConfiguration</a>
% </html>
% ,
% <html>
% <a href="setpatternsearchoptions.html">
% setPatternSearchOptions</a>
% </html>
% ,
% <html>
% <a href="matlab:doc patternsearch">
% matlab/patternsearch</a>
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
% <a href="startcmaes.html">
% startCMAES</a>
% </html>
% ,
% <html>
% <a href="startga.html">
% startGA</a>
% </html>
% ,
% <html>
% <a href="startde.html">
% startDE</a>
% </html>
% ,
% <html>
% <a href="startisres.html">
% startISRES</a>
% </html>
% ,
% <html>
% <a href="startga_patternsearch.html">
% startGA_PatternSearch</a>
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
% # Überprüfe Reihenfolge der Eingangsparameter
% # Überarbeite Dokumentation and create docu for script file
%
%% <<AuthorTag_DG/>>


