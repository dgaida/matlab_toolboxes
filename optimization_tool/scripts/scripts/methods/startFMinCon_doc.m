%% Preliminaries
% This function depends on the |Optimization
% Toolbox| so this toolbox has to be installed first. 
%
%% Syntax
%       u= startFMinCon(ObjectiveFunction, u0)
%       u= startFMinCon(ObjectiveFunction, u0, LB)
%       u= startFMinCon(ObjectiveFunction, u0, LB, UB)
%       u= startFMinCon(ObjectiveFunction, u0, LB, UB, noGenerations)
%       startFMinCon(ObjectiveFunction, u0, LB, UB, noGenerations,
%       timelimit) 
%       startFMinCon(ObjectiveFunction, u0, LB, UB, noGenerations,
%       timelimit, tolerance) 
%       startFMinCon(ObjectiveFunction, u0, LB, UB, noGenerations,
%       timelimit, tolerance, A, b) 
%       startFMinCon(ObjectiveFunction, u0, LB, UB, noGenerations,
%       timelimit, tolerance, A, b, Aeq, beq) 
%       startFMinCon(ObjectiveFunction, u0, LB, UB, noGenerations,
%       timelimit, tolerance, A, b, Aeq, beq, parallel) 
%       startFMinCon(ObjectiveFunction, u0, LB, UB, noGenerations,
%       timelimit, tolerance, A, b, Aeq, beq, parallel, nWorker) 
%       startFMinCon(ObjectiveFunction, u0, LB, UB, noGenerations,
%       timelimit, tolerance, A, b, Aeq, beq, parallel, nWorker, OutputFcn) 
%       [u, fitness]= startFMinCon(ObjectiveFunction, u0, ...)
%       [u, fitness, exitflag]= startFMinCon(ObjectiveFunction, u0, ...)
%       [u, fitness, exitflag, output]= startFMinCon(ObjectiveFunction, u0, ...)
%
%% Description
% |[u]= startFMinCon(ObjectiveFunction, u0)| prepares and
% starts <matlab:doc('fmincon') |fmincon|> with standard settings to
% minimize given fitness function |ObjectiveFunction|. 
%
% fmincon is a gradient-based method that is designed to work on problems
% where the objective and constraint functions are both continuous and have
% continuous first derivatives. 
%
%%
% @param |ObjectiveFunction| : a <matlab:doc('function_handle') function
% handle> with the objective function, which |fmincon| minimizes.
%
%%
% @param |u0| : (part of the) initial population. double matrix with number
% of columns equals dimension of the problem and number of rows
% arbitrarily (number of individuals to evaluate). 
%
%%
% @return |u| : optimal individual, row vector
%
%%
% |[u]= startFMinCon(ObjectiveFunction, u0, LB)|
%
%%
% @param |LB| : lower bound of the individual, double vector
%
%%
% |[u]= startFMinCon(ObjectiveFunction, u0, LB, UB)|
%
%%
% @param |UB| : upper bound of the individual, double vector
%
%%
% |startFMinCon(ObjectiveFunction, u0, LB, UB, noGenerations)|
%
%%
% @param |noGenerations| : number of generations to run, double scalar
%
%%
% |startFMinCon(ObjectiveFunction, lenIndividual, LB, UB, noGenerations,
% timelimit)| 
%
%%
% @param |timelimit| : time limit for the whole optimization process in
% seconds
%
%%
% |startFMinCon(ObjectiveFunction, lenIndividual, LB, UB, noGenerations,
% timelimit, tolerance)| 
%
%%
% @param |tolerance| : tolerance in the change of the fitness before ending
% the optimization process, double scalar
%
%%
% |startFMinCon(ObjectiveFunction, lenIndividual, LB, UB, noGenerations,
% timelimit, tolerance, A, b)| 
%
%%
% @param |A| : linear matrix inequality constraint. double matrix with
% number of columns equal to dimension of the problem and number of rows
% the number of constraints. 
%
%%
% @param |b| : linear matrix inequality constraint, double column vector
% with as many rows as |A|. 
%
%%
% |startFMinCon(ObjectiveFunction, lenIndividual, LB, UB, noGenerations,
% timelimit, tolerance, A, b, Aeq, beq)| 
%
%%
% @param |Aeq| : linear matrix equality constraint. double matrix with
% number of columns equal to dimension of the problem and number of rows
% the number of constraints. 
%
%%
% @param |beq| : linear matrix equality constraint, double column vector
% with as many rows as |Aeq|. 
%
%%
% |startFMinCon(ObjectiveFunction, lenIndividual, LB, UB, noGenerations,
% timelimit, tolerance, A, b, Aeq, beq, parallel)| 
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
% |startFMinCon(ObjectiveFunction, lenIndividual, LB, UB, noGenerations,
% timelimit, tolerance, A, b, Aeq, beq, parallel, nWorker)| 
%
%%
% @param |nWorker|    : number of workers to run in parallel : 
% 2 for a dual core, 4 for a quadcore, when using with 'multicore', else
% number of computers (workers) in the cluster. The standard value is 2,
% when using parallel computing, else 1.
%
%%
% |startFMinCon(ObjectiveFunction, lenIndividual, LB, UB, noGenerations,
% timelimit, tolerance, A, b, Aeq, beq, parallel, nWorker, OutputFcn)| 
%
%%
% @param |OutputFcn| : function handle which is called after one iteration
% is done 
%
%%
% |[u, fitness]= startFMinCon(ObjectiveFunction, u0, ...)|
%
%%
% @return |fitness| : fitness of the optimal individual
%
%%
% |[u, fitness, exitflag]= startFMinCon(ObjectiveFunction, u0, ...)|
%
%%
% @return |exitflag| : exitflag of |fmincon|
%
%%
% |[u, fitness, exitflag, output]= startFMinCon(ObjectiveFunction, u0, ...)|
%
%%
% @return |output| : output message of the optimization algorithm
%
%% Example
% 
%

nvars= 5;

LB= -5.12.*ones(nvars,1);
UB=  5.12.*ones(nvars,1);

maxIter= 75;

[u, fitnessFMinCon]= startFMinCon(@fitness_rastrigin, ...
                                  rand(nvars,1)', LB, UB, maxIter);

disp(u)
disp(fitnessFMinCon)

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
% <a href="matlab:doc fmincon">
% fmincon</a>
% </html>
% ,
% <html>
% <a href="setfminoptions.html">
% setFMinOptions</a>
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
% # Lagere die Überprüfung d. params in eine separete Funktion aus, welche von
% allen Methoden aufgerufen wird.
% # improve documentation a bit
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


