%% Preliminaries
% This function depends on the
% <http://www.lri.fr/~hansen/cmaes_inmatlab.html CMA-ES> implementation,
% so this toolbox has to be installed first. The installation is already
% realized with the installation of this toolbox.
%
%% Syntax
%       u= startCMAES(fitnessfcn, u0, LB, UB)
%       u= startCMAES(fitnessfcn, u0, LB, UB, popSize)
%       u= startCMAES(fitnessfcn, u0, LB, UB, popSize, maxIter)
%       u= startCMAES(fitnessfcn, u0, LB, UB, popSize, maxIter, parallel)
%       u= startCMAES(fitnessfcn, u0, LB, UB, popSize, maxIter, parallel,
%       nWorker) 
%       [u, fitness]= startCMAES(...)
%       [u, fitness, counteval]= startCMAES(...)
%       [u, fitness, counteval, exitflag]= startCMAES(...)
%       [u, fitness, counteval, exitflag, population]= startCMAES(...)
%
%% Description
% |[u]= startCMAES(fitnessfcn, u0, LB, UB)| prepares and
% starts CMA-ES Covariance Matrix Adaptation Evolution Strategy
% with standard settings to minimize the given fitness function
% |fitnessfcn|. 
%
%%
% @param |fitnessfcn| : a <matlab:doc('function_handle') function_handle>
% with the objective function, which CMA-ES minimizes.
%
%%
% @param |u0| : initial population (start point), double matrix. may also
% be empty. If not empty, then number of columns define the dimension of
% the problem and number of rows the number of individuals in the initial
% population. If there are more rows then |popSize|, then the last rows are
% deleted. 
%
%%
% @param |LB| : lower bound of the individual, double row or column vector
%
%%
% @param |UB| : upper bound of the individual, double row or column vector
%
%%
% @return |u| : optimal individual
%
%%
% |u= startCMAES(fitnessfcn, u0, LB, UB, popSize)| 
%
%%
% @param |popSize| : the population size, double salar integer
%
%%
% |u= startCMAES(fitnessfcn, u0, LB, UB, popSize, maxIter)|
%
%%
% @param |maxIter| : the maximal number of iterations / generations
%
%%
% |u= startCMAES(fitnessfcn, u0, LB, UB, popSize, maxIter, parallel)|
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
% |u= startCMAES(fitnessfcn, u0, LB, UB, popSize, maxIter, parallel,
% nWorker)| 
%
%% <<nWorker/>>
%
%%
% |[u, fitness]= startCMAES(...)|
%
%%
% @return |fitness| : fitness of the optimal individual
%
%%
% |[u, fitness, counteval]= startCMAES(...)|
%
%%
% @return |counteval| : number of function evaluations performed during
% optimization
%
%%
% |[u, fitness, counteval, exitflag]= startCMAES(...)|
%
%%
% @return |exitflag| : flag that is returned by the cmaes method
%
%%
% |[u, fitness, counteval, exitflag, population]= startCMAES(...)|
%
%%
% @return |population| : final population
%
%% Example
% 
% # Solve generalized Rastrigin's Function using CMA Evolution Strategy

nvars= 5;

LB= -5.12.*ones(nvars,1);
UB= 5.12.*ones(nvars,1);

popSize= 75;
maxIter= 150;


[u, fitnessCMAES, counteval, exitflag, population, various]= ...
                   startCMAES(@fitness_rastrigin, ...
                              [], LB, UB, popSize, maxIter);

disp(u);
disp('fitness: ')
disp(fitnessCMAES);
disp('counteval: ')
disp(counteval)
disp('exitflag: ')
disp(exitflag)
disp('population: ')
disp(population)
disp('various: ')
disp(various)

%%
% cleanup

delete('final_u_CMAES.mat');


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
% <a href="setpopsize.html">
% setPopSize</a>
% </html>
% ,
% <html>
% <a href="matlab:edit('cmaes')">
% edit('cmaes')</a>
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
% <a href="startsimulannealing.html">
% startSimulAnnealing</a>
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
% # create docu for script file
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% Hansen, N.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\cmaes\\06 The CMA Evolution Strategy - A Comparing Review.pdf'', 
% optimization_tool.getHelpPath())'))">
% The CMA Evolution Strategy: A Comparing Review</a>, 
% in J.A. Lozano, P. Larrañga, I. Inza and E. Bengoetxea (eds.). Towards a
% new evolutionary computation. Advances in estimation of distribution
% algorithms. pp. 75-102, Springer, 2006
% </li>
% <li> 
% Hansen, N., S.D. Müller and P. Koumoutsakos: <br>
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\cmaes\\03 Reducing the Time Complexity of the Derandomized Evolution Strategy with Covariance Matrix Adaptation (CMA-ES).pdf'', 
% optimization_tool.getHelpPath())'))">
% Reducing the Time Complexity of the Derandomized Evolution Strategy with
% Covariance Matrix Adaptation (CMA-ES)</a>,<br>
% Evolutionary Computation, 11(1), pp. 1-18, 2003
% </li>
% <li> 
% Hansen, N. and S. Kern: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\cmaes\\04 Evaluating the CMA Evolution Strategy on Multimodal Test Functions.pdf'', 
% optimization_tool.getHelpPath())'))">
% Evaluating the CMA Evolution Strategy on Multimodal Test Functions</a>,
% in Eighth International Conference on Parallel Problem Solving from
% Nature PPSN VIII, Proceedings, pp. 282-291, Berlin: Springer, 2004
% </li>
% <li> 
% Hansen, N. and A. Ostermeier: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\cmaes\\01 Completely Derandomized Self-Adaptation in Evolution Strategies.pdf'', 
% optimization_tool.getHelpPath())'))">
% Completely Derandomized Self-Adaptation in Evolution Strategies</a>,
% Evolutionary Computation, 9(2), pp. 159-195, 2001
% </li>
% <li> 
% Auger, A. and Hansen, N.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\cmaes\\05 A Restart CMA Evolution Strategy With Increasing Population Size.pdf'', 
% optimization_tool.getHelpPath())'))">
% A Restart CMA Evolution Strategy With Increasing Population Size</a>,
% in Proceedings of the IEEE Congress on Evolutionary Computation, CEC
% 2005, pp.1769-1776, 2005
% </li>
% <li> 
% Hansen, N., A.S.P. Niederberger, L. Guzzella and P. Koumoutsakos: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\cmaes\\09 A Method for Handling Uncertainty in Evolutionary Optimization with an Application to Feedback Control of Combustion.pdf'', 
% optimization_tool.getHelpPath())'))">
% A Method for Handling 
% Uncertainty in Evolutionary Optimization with an Application to Feedback 
% Control of Combustion</a>,
% IEEE Transactions on Evolutionary Computation, 13(1), pp. 180-197, 2009
% </li>
% </ol>
% </html>
%


