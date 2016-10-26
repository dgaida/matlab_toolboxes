%% Syntax
%       getOptimalPopulation(conObj, conRandMatrix, solverlist)
%       getOptimalPopulation(conObj, conRandMatrix, solverlist, fh)
%       getOptimalPopulation(conObj, conRandMatrix, solverlist, fh,
%       parallel) 
%       getOptimalPopulation(conObj, conRandMatrix, solverlist, fh,
%       parallel, nWorker) 
%       getOptimalPopulation(conObj, conRandMatrix, solverlist, fh,
%       parallel, nWorker, dispValidBounds) 
%       getOptimalPopulation(conObj, conRandMatrix, solverlist, fh,
%       parallel, nWorker, dispValidBounds, plotnonlcon) 
%
%% Description
% |getOptimalPopulation(conObj, conRandMatrix, solverlist)| rearranges the
% points inside the <..\consetofpoints\consetofpoints.html
% |numerics.conSetOfPoints|> object |conObj| such that the distance between
% the points are equal (see param: |fh|). This is done solving an
% optimization problem, which is defined by one of the three fitness
% functions:
%
% * <fitness1dmesh.html numerics.conRandMatrix.private.fitness1dmesh>
% * <fitness2dmesh.html numerics.conRandMatrix.private.fitness2dmesh>
% * <fitnessndmesh.html numerics.conRandMatrix.private.fitnessndmesh>
%
% This optimization problem is solved using different optimization methods
% defined in |solverlist|. 
%
% At the end of the function the generated data is validated calling
% <..\consetofpoints\validatesetforconstraints.html
% numerics.conSetOfPoints.validateSetForConstraints>
%
% Warning: At the moment this function does nothing! It just uses the data
% out of |conObj| which satisfies the boundaries and whose initial
% population is a latin hypercube sampling. 
%
%%
% @param |conObj| : object of the class <..\consetofpoints\consetofpoints.html
% |numerics.conSetOfPoints|>.  
%
%%
% @param |conRandMatrix| : object of the <conrandmatrix.html
% |numerics.conRandMatrix|> class
%
%%
% @param |solverlist| : solver used to create the constrained matrix. May
% also be a cell of strings <matlab:doc('cellstr') cellstr>. If it is a
% cellstr, then the methods defined in the cell are called one after another
% to solve the optimization problem. Default: {'PS', 'ISRES', 'GA'}. 
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
%%
% |getOptimalPopulation(conRandMatrix, solverlist, fh)| lets you specify
% the scaled edge length function h(x,y). It defines the distance between
% the points in the set. The default scaled edge length function
% <matlab:doc('numerics_tool/huniform') @huniform> makes the distance
% between all points equal. 
%
%%
% @param |fh| : scaled edge length function h(x,y), which may depend on the
% data 'p', <matlab:doc('function_handle') function_handle>
%
% * inline('min(4*sqrt(sum(p.^2,2))-1,2)','p')
% * <matlab:doc('numerics_tool/hgaussian') @hgaussian>
% * <matlab:doc('numerics_tool/huniform') @huniform> (Default)
% * <matlab:doc('numerics_tool/hlhsamp') @hlhsamp>
%
%%
% |getOptimalPopulation(conObj, conRandMatrix, solverlist, fh, parallel)|
% lets you specify whether the optimization problem should be solved in
% parallel. 
%
%%
% @param |parallel| : char, default: 'none'
%
% * 'none' : the optimization method do not run in parallel
% * 'multicore' : if it is possible for the optimization method to run in
% parallel, like 'GA', 'PSO', then it is started in parallel on a multicore
% processor
% * 'cluster' : the optimiaztion method is started in parallel assuming it
% is run on a computer cluster
%
%%
% |getOptimalPopulation(conObj, conRandMatrix, solverlist, fh, parallel,
% nWorker)| lets you specify the numbe rof workers used, if ran in
% parallel. Default: 2, if not run in parallel, then 1.
%
%%
% @param |nWorker| : number of workers, either cores or pc's, depending on
% the above setting |parallel|, double scalar
%
%%
% |getOptimalPopulation(conObj, conRandMatrix, solverlist, fh, parallel,
% nWorker, dispValidBounds)| 
%
%%
% @param |dispValidBounds| : integer, scalar
% 
% * 0 : If boundaries hold then no message is returned. Default. 
% * 1 : for each boundary that holds a message is returned. 
%
%%
% |getOptimalPopulation(conObj, conRandMatrix, solverlist, fh, parallel,
% nWorker, dispValidBounds, plotnonlcon)| 
%
%%
% @param |plotnonlcon| : if 1, then nonlinear constraints are plotted, else
% 0. Since plotting the nonlinear constraints is very ressources consuming,
% this parameter should be set to 0 to spare time and memory.
%
%% Example
%
%
%% Dependencies
%
% This method calls:
%
% <html>
% <a href="fitness1dmesh.html">
% numerics.conRandMatrix.private.fitness1dmesh</a>
% </html>
% ,
% <html>
% <a href="fitness2dmesh.html">
% numerics.conRandMatrix.private.fitness2dmesh</a>
% </html>
% ,
% <html>
% <a href="fitnessndmesh.html">
% numerics.conRandMatrix.private.fitnessndmesh</a>
% </html>
% ,
% <html>
% <a href="..\consetofpoints\validatesetforconstraints.html">
% numerics.conSetOfPoints.validateSetForConstraints</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('numerics_tool/setcondata')">
% numerics.conSetOfPoints.setConData</a>
% </html>
% ,
% <html>
% <a href="matlab:doc optimization_tool/startga">
% optimization_tool/startGA</a>
% </html>
% ,
% <html>
% <a href="matlab:doc optimization_tool/startpso">
% optimization_tool/startPSO</a>
% </html>
% ,
% <html>
% <a href="matlab:doc optimization_tool/startpatternsearch">
% optimization_tool/startPatternSearch</a>
% </html>
% ,
% <html>
% <a href="matlab:doc optimization_tool/startisres">
% optimization_tool/startISRES</a>
% </html>
% ,
% <html>
% <a href="matlab:doc optimization_tool/startga_patternsearch">
% optimization_tool/startGA_PatternSearch</a>
% </html>
% ,
% <html>
% <a href="matlab:doc optimization_tool/startsimulannealing">
% optimization_tool/startSimulAnnealing</a>
% </html>
% ,
% <html>
% <a href="matlab:doc optimization_tool/startcmaes">
% optimization_tool/startCMAES</a>
% </html>
% ,
% <html>
% <a href="matlab:doc optimization_tool/startde">
% optimization_tool/startDE</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validatestring')">
% matlab/validatestring</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="conrandmatrix.html">
% numerics.conRandMatrix</a>
% </html>
%
%% See Also
%
% <html>
% <a href="..\consetofpoints\consetofpoints.html">
% numerics.conSetOfPoints</a>
% </html>
%
%% TODOs
% # s. in der Datei
% # documentation for numerics.conSetOfPoints.setConData does not exist,
% thus link above does not work
% # improve code and documentation
% # warning: latin hypercube sampling is used instead of solving
% optimization problem, but constraints are satisfied, because of the data
% generated in conSetOfPoints is used
% # test method, for useLHS = 0
%
%% <<AuthorTag_DG/>>


