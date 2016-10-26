%% Preliminaries
% # This function depends on the MATLAB DE Toolbox
% <http://www.icsi.berkeley.edu/~storn/code.html DE> so this toolbox has to
% be installed first, is done by installing this toolbox. 
%
%% Syntax
%       [u]= startDE(fitnessfcn, nvars)
%       [u]= startDE(fitnessfcn, nvars, LB)
%       [u]= startDE(fitnessfcn, nvars, LB, UB)
%       [u]= startDE(fitnessfcn, nvars, LB, UB, u0)
%       startDE(fitnessfcn, nvars, LB, UB, u0, popSize)
%       startDE(fitnessfcn, nvars, LB, UB, u0, popSize, ...
%                       noGenerations)
%       startDE(fitnessfcn, nvars, LB, UB, u0, popSize, ...
%                       noGenerations, parallel)
%       startDE(fitnessfcn, nvars, LB, UB, u0, popSize, ...
%                       noGenerations, parallel, nWorker)
%       [u, fitness]= startDE(...)
%       [u, fitness, I_nf]= startDE(...)
%       [u, fitness, I_nf, population]= startDE(...)
%
%% Description
% |[u]= startDE(fitnessfcn, nvars)| prepares and starts Differential Evolution  
% algorithm with standard settings to minimize given fitness function
% |fitnessfcn|. 
%
%%
% @param |fitnessfcn| : a <matlab:doc('function_handle') function handle>
% with the objective function, which DE minimizes.
%
%%
% @param |nvars| : the length of the individual, thus the number of
% variables to be optimized, double integer scalar
%
%%
% @return |u| : optimal individual
%
%%
% |[u]= startDE(fitnessfcn, nvars, LB)|
%
%%
% @param |LB| : lower bound of the individual, double row or column vector
% with |nvars| entries
%
%%
% |[u]= startDE(fitnessfcn, nvars, LB, UB)|
%
%%
% @param |UB| : upper bound of the individual, double row or column vector
% with |nvars| entries
%
%%
% |[u]= startDE(fitnessfcn, nvars, LB, UB, u0)|
%
%%
% @param |u0| : (part of the) initial population. double matrix with
% |nvars| columns and arbitrarily many rows. 
%
%%
% |startDE(fitnessfcn, nvars, LB, UB, u0, popSize)|
%
%%
% @param |popSize| : size of the wanted population of the DE algorithm,
% double integer scalar 
%
%%
% |startDE(fitnessfcn, nvars, LB, UB, u0, popSize, ...
%          noGenerations)|
%
%%
% @param |noGenerations| : number of generations to run, double integer
% scalar 
%
%%
% |[u, fitness]= startDE(...)|
%
%%
% @return |fitness| : fitness of the optimal individual
%
%%
% |[u, fitness, I_nf]= startDE(...)|
%
%%
% @return |I_nf| : number of function evaluations during optimization
%
%%       
% |[u, fitness, I_nf, population]= startDE(...)|
%
%%
% @return |population| : final population
%
%% Example
% 
% # Solve generalized Rastrigin's Function using Differential Evolution

nvars= 5;

LB= -5.12.*ones(nvars,1);
UB= 5.12.*ones(nvars,1);

popSize= 75;
maxIter= 75;

[u, fitnessDE, I_nf, population]= ...
                startDE(@fitness_rastrigin, ...
                        nvars, LB, UB, [], popSize, maxIter);

disp(u)
disp('fitness: ')
disp(fitnessDE)
disp('I_nf: ')
disp(I_nf)
disp('population: ')
disp(population)

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
% <a href="matlab:edit('deopt')">
% edit('deopt')</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% doc validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validatestring')">
% doc validatestring</a>
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
% <a href="matlab:doc('ml_tool/findoptimalkrigingmodel')">
% ml_tool/findOptimalKrigingModel</a>
% </html>
% ,
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
% <a href="startga_patternsearch.html">
% startGA_PatternSearch</a>
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
% # improve documentation and create it for script file
% 
%% <<AuthorTag_DG/>>
%% References
% # Price, K., Storn, R., Lampinen, J.: Differential Evolution - A
% Practical Approach to Global Optimization, Springer, 2005
%


