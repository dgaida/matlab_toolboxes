%% Preliminaries
% # This function depends on the MATLAB PSO Toolbox
% <http://www.mathworks.com/matlabcentral/fileexchange/7506-particle-swarm-optimization-toolbox PSOt>
% so this toolbox has to be installed first. You can find this toolbox in
% the |extools| folder: |PSOt.zip|. 
%
%% Syntax
%       u= startPSO(ObjectiveFunction, lenIndividual)
%       startPSO(ObjectiveFunction, lenIndividual, LB)
%       startPSO(ObjectiveFunction, lenIndividual, LB, UB)
%       startPSO(ObjectiveFunction, lenIndividual, LB, UB, u0)
%       startPSO(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize)
%       startPSO(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize,
%       noGenerations) 
%       startPSO(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize,
%       noGenerations, timelimit) 
%       startPSO(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize,
%       noGenerations, timelimit, tolerance) 
%       [u, fitness]= startPSO(...)
%       [u, fitness, te]= startPSO(...)
%       [u, fitness, te, tr]= startPSO(...)
%
%% Description
% |u= startPSO(ObjectiveFunction, lenIndividual)| prepares and
% starts particle swarm optimization algorithm with standard settings to
% minimize given objective function |ObjectiveFunction|. 
%
%%
% @param |ObjectiveFunction| : a <matlab:doc('function_handle')
% function_handle> with the objective function,
% which PSO minimizes. If you don't pass a function_handle, e.g. [], then a
% warning is thrown and an default fitness function is used, which is a
% constant, so every valid individual is optimal.
%
%%
% @param |lenIndividual| : the length of the individual, double scalar
% integer
%
%%
% @return |u| : optimal individual, row vector
%
%%
% |startPSO(ObjectiveFunction, lenIndividual, LB)|
%
%%
% @param |LB| : lower bound of the individual, double vector with
% |lenIndividual| components
%
%%
% |startPSO(ObjectiveFunction, lenIndividual, LB, UB)|
%
%%
% @param |UB| : upper bound of the individual, double vector with
% |lenIndividual| components
%
%%
% |startPSO(ObjectiveFunction, lenIndividual, LB, UB, u0)|
%
%%
% @param |u0| : (part of the) initial population. matrix with
% |lenIndividual| columns and arbitrarily many rows. 
%
%%
% |startPSO(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize)|
%
%%
% @param |popSize| : size of the wanted population of the PSO algorithm,
% double scalar integer
%
%%
% |startPSO(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize,
% noGenerations)| 
%
%%
% @param |noGenerations| : number of generations to run, double scalar
% integer
%
%%
% |startPSO(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize,
% noGenerations, timelimit)| 
%
%%
% @param |timelimit| : time limit for the whole optimization process in
% seconds, double scalar
%
%%
% |startPSO(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize,
% noGenerations, timelimit, tolerance)| 
%
%%
% @param |tolerance| : tolerance in the change of the fitness before ending
% the optimization process, double scalar
%
%%
% |[u, fitness]= startPSO(...)|
%
%%
% @return |fitness| : fitness of the optimal individual
%
%%
% |[u, fitness, te]= startPSO(...)|
%
%%
% @return |te| : epochs to train, returned as a vector 1:endepoch
%
%%
% |[u, fitness, te, tr]= startPSO(...)|
%
%%
% @return |tr| : vector of fitness values, one for each iteration
%
%% Example
% 
% # Solve generalized Rastrigin's Function using Particle Swarm
% Optimization

nvars= 5;

LB= -5.12.*ones(nvars,1);
UB= 5.12.*ones(nvars,1);

popSize= 75;
maxIter= 75;

[u, fitnessPSO, te, tr]= startPSO(@fitness_rastrigin, ...
                          nvars, LB, UB, [], popSize, maxIter);
        
disp(u)
disp('fitness: ')
disp(fitnessPSO)
disp('te: ')
disp(te)
disp('tr: ')
disp(tr)

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
% <a href="matlab:edit('pso_Trelea_vectorized.m')">
% edit('pso_Trelea_vectorized')</a>
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
% ,
% <html>
% <a href="matlab:doc('script_collection/existmpfile')">
% script_collection/existMPfile</a>
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
% <a href="startga.html">
% startGA</a>
% </html>
% ,
% <html>
% <a href="startpatternsearch.html">
% startPatternSearch</a>
% </html>
% ,
% <html>
% <a href="startsimulannealing.html">
% startSimulAnnealing</a>
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
% # Überprüfe alle Eingangsparameter auf Größe und Datentyp
% # Verstehe den Algorithmus und den Aufruf
% # provide an initial population (seed?)
% # improve documentation significantly
% # timelimit not used yet
% 
%% <<AuthorTag_CW/>>
%% References
%
% <html>
% <ol>
% <li> 
% Poli, R., Kennedy, J. and Blackwell, T.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\07 Particle Swarm Optimization - An Overview.pdf'', 
% optimization_tool.getHelpPath())'))">
% Particle swarm optimization - An Overview</a>, Springer, vol. 1(1):33-57,
% 2007
% </li>
% </ol>
% </html>
%
%%
% Alternativen, welche allerdings entweder noch nicht funktionieren oder
% nicht so gut aussehen:
%
%%
% # Poli, R., Kennedy, J. and Blackwell, T.: 
% <matlab:winopen('../pdfs/07 Particle Swarm Optimization - An Overview.pdf') Particle swarm optimization - An Overview>, 
% Springer, vol. 1(1):33-57, 2007
%
%%
% # Poli, R., Kennedy, J. and Blackwell, T.: 
% <"../pdfs/07 Particle Swarm Optimization - An Overview.pdf" 
% Particle swarm optimization - An Overview>, 
% Springer, vol. 1(1):33-57, 2007
%


