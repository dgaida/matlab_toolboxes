%% Preliminaries
% This function depends on the |Genetic Algorithm and Direct Search
% Toolbox| so MATLAB's Global Optimization Toolbox has to be installed first. 
%
%% Syntax
%       u= startSimulAnnealing(ObjectiveFunction, u0)
%       startSimulAnnealing(ObjectiveFunction, u0, LB) 
%       startSimulAnnealing(ObjectiveFunction, u0, LB, UB) 
%       startSimulAnnealing(ObjectiveFunction, u0, LB, UB, maxIter) 
%       startSimulAnnealing(ObjectiveFunction, u0, LB, UB, maxIter,
%       timelimit) 
%       startSimulAnnealing(ObjectiveFunction, u0, LB, UB, maxIter,
%       timelimit, tolerance) 
%       [u, fitness]= startSimulAnnealing(...)
%       [u, fitness, exitflag]= startSimulAnnealing(...)
%       [u, fitness, exitflag, output]= startSimulAnnealing(...)
%
%% Description
% |u= startSimulAnnealing(ObjectiveFunction, u0)| prepares and starts
% simulated annealing algorithm with standard settings to minimize given
% objective function |ObjectiveFunction|. 
%
%%
% @param |ObjectiveFunction| : a <matlab:doc('function_handle')
% function_handle> with the objective function,
% which simulated annealing minimizes. 
%
%%
% @param |u0| : starting point in the search space, either a vector or a
% scalar
%
%%
% @return |u| : optimal individual, row vector
%
%%
% |startSimulAnnealing(ObjectiveFunction, u0, LB)|
%
%%
% @param |LB| : lower bound of the individual, double vector
%
%%
% |startSimulAnnealing(ObjectiveFunction, u0, LB, UB)|
%
%%
% @param |UB| : upper bound of the individual, double vector
%
%%
% |startSimulAnnealing(ObjectiveFunction, u0, LB, UB, maxIter)|
%
%%
% @param |maxIter| : maximal number of iterations to run, double scalar
% integer
%
%%
% |startSimulAnnealing(ObjectiveFunction, u0, LB, UB, maxIter, timelimit)|
%
%%
% @param |timelimit| : time limit for the whole optimization process in
% seconds, double scalar
%
%%
% |startSimulAnnealing(ObjectiveFunction, u0, LB, UB, maxIter, timelimit,
% tolerance)| 
%
%%
% @param |tolerance| : tolerance in the change of the fitness before ending
% the optimization process, double scalar
%
%%
% |[u, fitness]= startSimulAnnealing(...)|
%
%%
% @return |fitness| : fitness of the optimal individual
%
%%
% |[u, fitness, exitflag]= startSimulAnnealing(...)|
%
%%
% @return |exitflag| : exitflag of <matlab:doc('simulannealbnd')
% |simulannealbnd|> 
%
%%
% |[u, fitness, exitflag, output]= startSimulAnnealing(...)|
%
%%
% @return |output| : output message of the optimization algorithm
%
%% Example
% 
% # Solve generalized Rastrigin's Function using Simulated Annealing

nvars= 5;

LB= -5.12.*ones(nvars,1);
UB=  5.12.*ones(nvars,1);

maxIter= 75;

[u, fitnessSA]= startSimulAnnealing(@fitness_rastrigin, ...
                                    [], LB, UB, maxIter);

disp(u)
disp(fitnessSA)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="setsimulannealingoptions.html">
% setSimulAnnealingOptions</a>
% </html>
% ,
% <html>
% <a href="matlab:doc simulannealbnd">
% matlab/simulannealbnd</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
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
% <a href="startga.html">
% startGA</a>
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
% <a href="startisres.html">
% startISRES</a>
% </html>
% ,
% <html>
% <a href="startcmaes.html">
% startCMAES</a>
% </html>
% ,
% <html>
% <a href="setparallelconfiguration.html">
% setParallelConfiguration</a>
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
% # Überprüfe Reihenfolge der Eingangsparameter sowie diese auf Größe und
% Datentyp 
% # do documentation of script file and improve documentation here
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


