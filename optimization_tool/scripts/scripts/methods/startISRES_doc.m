%% Preliminaries
% This function depends on the
% <http://www3.hi.is/~tpr/index.php?page=software/sres/sres |ISRES|> so
% this toolbox has to be installed first (already done). The file srsort.c
% has to be compiled first, use |mex srsort.c|. 
%
%% Syntax
%       u= startISRES(fitnessfcn, LB, UB)
%       u= startISRES(fitnessfcn, LB, UB, u0)
%       u= startISRES(fitnessfcn, LB, UB, u0, popSize)
%       u= startISRES(fitnessfcn, LB, UB, u0, popSize, noGenerations)
%       startISRES(fitnessfcn, LB, UB, u0, popSize, noGenerations,
%       parallel)  
%       startISRES(fitnessfcn, LB, UB, u0, popSize, noGenerations,
%       parallel, nWorker) 
%       [u, fitness]= startISRES(...)
%       [u, fitness, Gm]= startISRES(...)
%       [u, fitness, Gm, population]= startISRES(...)
%
%% Description
% |u= startISRES(fitnessfcn, LB, UB)| prepares and
% starts ISRES "Improved" Evolution Strategy using Stochastic
% Ranking with standard settings to minimize given |fitnessfcn|. 
%
%%
% @param |fitnessfcn| : a <matlab:doc('function_handle') function_handle>
% with the objective function, which ISRES minimizes.
%
%%
% @param |LB| : lower bound of the individual, double vector
%
%%
% @param |UB| : upper bound of the individual, double vector
%
%%
% @return |u| : optimal individual, row vector
%
%%
% |u= startISRES(fitnessfcn, LB, UB, u0)|
%
%%
% @param |u0| : (part of the) initial population. matrix with
% as many columns as is the dimension of the problem and arbitrarily many
% rows. 
%
%%
% |startISRES(fitnessfcn, LB, UB, u0, popSize)|
%
%%
% @param |popSize| : size of the wanted population of the ISRES algorithm,
% double scalar integer
%
%%
% |startISRES(fitnessfcn, LB, UB, u0, popSize, noGenerations)|
%
%%
% @param |noGenerations| : number of generations to run, double scalar
% integer
%
%%
% |startISRES(fitnessfcn, LB, UB, u0, popSize, noGenerations, parallel)| 
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
% |startISRES(fitnessfcn, LB, UB, u0, popSize, noGenerations, parallel,
% nWorker)| 
%
%%
% @param |nWorker|    : number of workers to run in parallel : 
% 2 for a dual core, 4 for a quadcore, when using with 'multicore', else
% number of computers (workers) in the cluster. The standard value is 2,
% when using parallel computing, else 1.
%
%%
% |[u, fitness]= startISRES(...)|
%
%%
% @return |fitness| : fitness of the optimal individual
%
%%
% |[u, fitness, Gm]= startISRES(...)|
%
%%
% @return |Gm| : generation where the minimum was found
%
%%
% |[u, fitness, Gm, population]= startISRES(...)|
%
%%
% @return |population| : final population
%
%% Example
% 
% # install tool
%
% |mex isres/srsort.c|
%
%%
% # Solve generalized Rastrigin's Function using Improved Stochastic
% Ranking Evolution Strategy 

nvars= 5;

LB= -5.12.*ones(nvars,1);
UB= 5.12.*ones(nvars,1);

popSize= 75;
maxIter= 75;

[u, fitnessISRES, Gm, population]= ...
                   startISRES(@fitness_rastrigin, ...
                              LB, UB, [], popSize, maxIter);

disp(u)
disp('fitness: ')
disp(fitnessISRES);
disp('Gm: ')
disp(Gm)
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
% <a href="matlab:edit('isres')">
% edit('isres')</a>
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
% <a href="startcmaes.html">
% startCMAES</a>
% </html>
% ,
% <html>
% <a href="startsimulannealing.html">
% startSimulAnnealing</a>
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
% # Lagere die params Überprüfung in eine separete Funktion aus, welche von
% allen Methoden aufgerufen wird.
% # create documentation for script file and improve it here
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% Thomas Philip Runarsson and Xin Yao: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\isres\\05 Search Biases in Constrained Evolutionary Optimization.pdf'', 
% optimization_tool.getHelpPath())'))">
% Search Biases in Constrained Evolutionary Optimization</a>, <br>
% IEEE Transactions on Systems, Man and Cybernetics -- Part C: Applications
% and Reviews. Vol. 35, No. 2, pp 233-243, May 2005
% </li>
% <li> 
% Thomas Philip Runarsson and Xin Yao: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\isres\\00 Stochastic Ranking for Constrained Evolutionary Optimization.pdf'', 
% optimization_tool.getHelpPath())'))">
% Stochastic Ranking for Constrained Evolutionary Optimization</a>, <br>
% IEEE Transactions on Evolutionary Computation, Vol. 4, No. 3, pp.
% 284-294, September 2000
% </li>
% </ol>
% </html>
%


