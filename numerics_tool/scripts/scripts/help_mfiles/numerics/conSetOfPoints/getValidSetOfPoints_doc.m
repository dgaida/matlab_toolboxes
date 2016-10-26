%% Syntax
%       conSetOfPoints=
%       numerics.conSetOfPoints.getValidSetOfPoints(conSetOfPoints) 
%       numerics.conSetOfPoints.getValidSetOfPoints(conSetOfPoints,
%       solverlist) 
%       numerics.conSetOfPoints.getValidSetOfPoints(conSetOfPoints,
%       solverlist, parallel) 
%       numerics.conSetOfPoints.getValidSetOfPoints(conSetOfPoints,
%       solverlist, parallel, nWorker) 
%       numerics.conSetOfPoints.getValidSetOfPoints(conSetOfPoints,
%       solverlist, parallel, nWorker, dispValidBounds) 
%       numerics.conSetOfPoints.getValidSetOfPoints(conSetOfPoints,
%       solverlist, parallel, nWorker, dispValidBounds, plotnonlcon) 
%
%% Description
% |conSetOfPoints=
% numerics.conSetOfPoints.getValidSetOfPoints(conSetOfPoints)| creates a
% dataset for the object 
% |conSetOfPoints| which satisfies all constraints defined in
% |conSetOfPoints|. Therefore it uses different optimization algorithms
% which try to minimize the fitness value defined in
% <fitnesssatisfycontraints.html fitnessSatisfyContraints> and therefore
% try to find points which satisfy all boundaries. These points could all
% be the same, so this function does not try to maximize the volume of all
% valid points. As default the solvers 'PS', 'ISRES' and 'GA' are applied
% one after another. 
%
% At the end of the function the created set is validated with respect to
% the constraints defined, calling <validatesetforconstraints.html
% numerics.conSetOfPoints.private.validateSetForConstraints>. 
%
%%
% @param |conSetOfPoints| : object of the <consetofpoints.html
% |numerics.conSetOfPoints|> class 
%
%%
% @return |conSetOfPoints| : updated object of the
% <consetofpoints.html |numerics.conSetOfPoints|> class 
%
%%
% |getValidSetOfPoints(conSetOfPoints, solverlist)| lets you specify the
% optimization methods used to solve the problem. 
%
%%
% @param |solverlist| : <matlab:doc('cellstr') cellstring> with solvers
% which solve one after 
% another the problem finding a valid set of points satisfying the given
% constraints. At the moment possible solvers are
%
% * 'GA' : using <matlab:doc('optimization_tool/startga') Genetic
% Algorithm> (GA) 
% * 'PS' : using <matlab:doc('optimization_tool/startpatternsearch')
% Pattern Search> 
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
% |getValidSetOfPoints(conSetOfPoints, solverlist, parallel)| lets you
% define, whether the optimization problem should be solved in parallel
% using a couple of wokers or even computers. 
%
%%
% @param |parallel| : char 
%
% * 'none' : the optimization methods do not run in parallel (default)
% * 'multicore' : if it is possible for the optimization method to run in
% parallel, like 'GA', 'PSO', then it is started in parallel on a multicore
% processor
% * 'cluster' : the optimization method is started in parallel assuming
% that it runs on a computer cluster
%
%%
% |getValidSetOfPoints(conSetOfPoints, solverlist, parallel, nWorker)| lets
% you define the number of workers. If ran in parallel, then the default
% value is 2. 
%
%%
% @param |nWorker| : number of workers, either cores or pc's, depending on
% the above setting, double scalar
%
%%
% |numerics.conSetOfPoints.getValidSetOfPoints(conSetOfPoints, solverlist,
% parallel, nWorker, dispValidBounds)| 
%
%%
% @param |dispValidBounds| : integer, scalar
% 
% * 0 : If boundaries hold then no message is returned. Default. 
% * 1 : for each boundary that holds a message is returned. 
%
%%
% |numerics.conSetOfPoints.getValidSetOfPoints(conSetOfPoints, solverlist,
% parallel, nWorker, dispValidBounds, plotnonlcon)| 
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
% <a href="validatesetforconstraints.html">
% numerics.conSetOfPoints.private.validateSetForConstraints</a>
% </html>
% ,
% <html>
% <a href="fitnesssatisfycontraints.html">
% numerics.conSetOfPoints.private.fitnessSatisfyContraints</a>
% </html>
% ,
% <html>
% <a href="matlab:doc ml_tool/lhsampling">
% ml_tool/lhSampling</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startsimulannealing">
% optimization_tool/startSimulAnnealing</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startpatternsearch">
% optimization_tool/startPatternSearch</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startisres">
% optimization_tool/startISRES</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startga">
% optimization_tool/startGA</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startpso">
% optimization_tool/startPSO</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startcmaes">
% optimization_tool/startCMAES</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startde">
% optimization_tool/startDE</a>
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
% ,
% <html>
% <a href="matlab:doc('matlab/blkdiag')">
% matlab/blkdiag</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('optimization_tool/setpopsize')">
% optimization_tool/setPopSize</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="consetofpoints.html">
% numerics.conSetOfPoints</a>
% </html>
%
%% See Also
%
% <html>
% <a href="getpointsinconstraineddimension.html">
% numerics.conSetOfPoints.getPointsInConstrainedDimension</a>
% </html>
% ,
% <html>
% <a href="getpointsinfulldimension.html">
% numerics.conSetOfPoints.getPointsInFullDimension</a>
% </html>
%
%% TODOs
% # die Parameter Populationsgröße, Anzahl Iterationen und Übernahme der
% alten Population von anderem Verfahren sollte für jedes Verfahren von
% außen angebbar sein
% # die frage ist ob |u| in der fitness funktion
% |fitnessSatisfyConstraints| alle elemente des datensatzes enthalten muss,
% oder  
% ob es nicht sinnvoller ist, alle elemente des datensatzes einzeln auf
% boundaries zu überprüfen. damit wäre es auch möglich, elemente eines
% datensatzes im vorherein zu behalten falls diese schon die rb's erfüllen.
% # check code
% # solve the TODOs in the file
%
%% <<AuthorTag_DG/>>
              

