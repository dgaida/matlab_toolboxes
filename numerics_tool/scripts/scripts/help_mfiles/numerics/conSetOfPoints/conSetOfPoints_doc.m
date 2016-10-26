%% Syntax
%       obj= numerics.conSetOfPoints()
%       numerics.conSetOfPoints(dim)
%       numerics.conSetOfPoints(dim, rows)
%       numerics.conSetOfPoints(dim, rows, A)
%       numerics.conSetOfPoints(dim, rows, A, b)
%       numerics.conSetOfPoints(dim, rows, A, b, Aeq)
%       numerics.conSetOfPoints(dim, rows, A, b, Aeq, beq)
%       numerics.conSetOfPoints(dim, rows, A, b, Aeq, beq, LB)
%       numerics.conSetOfPoints(dim, rows, A, b, Aeq, beq, LB, UB)
%       numerics.conSetOfPoints(dim, rows, A, b, Aeq, beq, LB, UB, nonlcon)
%       numerics.conSetOfPoints(dim, rows, A, b, Aeq, beq, LB, UB, nonlcon,
%       solverlist) 
%       numerics.conSetOfPoints(dim, rows, A, b, Aeq, beq, LB, UB, nonlcon,
%       solverlist, parallel) 
%       numerics.conSetOfPoints(dim, rows, A, b, Aeq, beq, LB, UB, nonlcon,
%       solverlist, parallel, nWorker) 
%       numerics.conSetOfPoints(dim, rows, A, b, Aeq, beq, LB, UB, nonlcon,
%       solverlist, parallel, nWorker, data) 
%       numerics.conSetOfPoints(dim, rows, A, b, Aeq, beq, LB, UB, nonlcon,
%       solverlist, parallel, nWorker, data, dispValidBounds) 
%       numerics.conSetOfPoints(dim, rows, A, b, Aeq, beq, LB, UB, nonlcon,
%       solverlist, parallel, nWorker, data, dispValidBounds, plotnonlcon) 
%
%% Description
% Definition of a randomly (actually latin hypercube sampling is used, see
% <getvalidsetofpoints.html
% numerics.conSetOfPoints.private.getValidSetOfPoints>) created set of
% points where each row is bounded 
% and constrained to (non-)linear (in-)equality constraints. Each row
% defines one point, the elements of the point are the cells of the row. 
% The points are arranged in a matrix, such that the column number of this
% matrix defines the dimension of the space in which the points are located
% in. This class can be used to create 
% the initial population of an stochastic optimization problem. The matrix
% is created using optimization methods like the
% <matlab:doc('patternsearch') pattern search> or 
% <matlab:doc('simulannealbnd') simulated annealing> method out of 
% the 'Genetic Algorithm and Direct
% Search Toolbox' toolbox, if installed, see the parameter |solverlist| and
% <getvalidsetofpoints.html 
% numerics.conSetOfPoints.private.getValidSetOfPoints>. 
% The matrix only contains points which satisfy the constraints, if you
% want the 
% points additionally have a specified arrangement (e.g. equal distance
% between the points filling a maximal volume) use the class
% <..\conrandmatrix\conrandmatrix.html numerics.conRandMatrix> which also uses
% this class. Linear equality constraints are used to transform the set of
% points in a lower dimensional space, which live in the
% <matlab:doc('null') nullspace> of the 
% linear equality constraint matrix $A_{eq}$ and therefore implicitly
% satisfy the linear equality constraints (see <getconstrainedspace.html
% numerics.conSetOfPoints.private.getConstrainedSpace>). Furthermore the
% data is scaled between 0 and 10 using a scaling transformation
% (<getscalingtransformation.html 
% numerics.conSetOfPoints.private.getScalingTransformation>). The class
% also has some methods for validating and plotting the set. 
%
%%
% This class is a handle class.
%
%%
% @param |dim| : dimension of the space the points should lie in. The
% resulting matrix will have |dim| columns. double scalar, integer.
%
%%
% @param |rows| : double integer scalar, with the number of points in the
% set 
%
%%
% @param |A| : double matrix of the inequality constraint $A \cdot x \leq
% b$. Number of columns must be equal to |dim|. Number of rows define
% number of constraints. 
%
%%
% @param |b| : double column vector of the inequality constraint $A \cdot x
% \leq b$. Must have same number of rows as |A|. 
%
%%
% @param |Aeq| : double matrix of the equality constraint $A_{eq} \cdot x =
% b_{eq}$. Number of columns must be equal to |dim|. Number of rows define
% number of constraints. 
%
%%
% @param |beq| : double column vector of the equality constraint $A_{eq} \cdot
% x = b_{eq}$. Must have same number of rows as |Aeq|. 
%
%%
% @param |LB| : lower bound of the space the points are lying in, double
% row vector. Must have |dim| elements. 
%
%%
% @param |UB| : upper bound of the space the points are lying in, double
% row vector. Must have |dim| elements. 
%
%%
% @param |nonlcon| : <matlab:doc('function_handle') function_handle>
% defining a nonlinear (in-)equality constraint function. 
%
%%
% @param |solverlist| : <matlab:doc('cellstr') cellstring> with solvers
% which solve one after another the problem finding a valid set of points
% satisfying the given constraints (default: {'PS', 'ISRES', 'GA'}). At the
% moment possible solvers are 
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
% @param |parallel| : char. default: 'none'
%
% * 'none' : the optimization methods do not run in parallel
% * 'multicore' : if it is possible for the optimization method to run in
% parallel, like 'GA', 'PSO', then it is started in parallel on a multicore
% processor
% * 'cluster' : the optimiaztion method is started in parallel assuming it
% is run on a computer cluster
%
%%
% @param |nWorker| : defines the number of workers, when using a parallel
% configuration. double scalar, integer. Default: 2, if running in
% parallel, else 1. 
%
%%
% @param |data| : data which is used as e.g. initial population for the to
% be solved optimization problem that the data should satisfy the
% constraints. the rows in |data| satisfying the constraints already, are
% not changed, the data not yet satisfying the constraints are changed as
% wanted.
%
%%
% @param |dispValidBounds| : integer, scalar
% 
% * 0 : If boundaries hold then no message is returned. Default. 
% * 1 : for each boundary that holds a message is returned. 
%
%%
% @param |plotnonlcon| : if 1, then nonlinear constraints are plotted, else
% 0. Since plotting the nonlinear constraints is very ressources consuming,
% this parameter should be set to 0 to spare time and memory.
%
%% Example
%
%% 1-D Examples
% 
% <html>
% <a href="consetofpoints_samples1d.html">
% 1-D Examples</a>
% </html>
%
%% 2-D Examples
% 
% <html>
% <a href="consetofpoints_samples2d.html">
% 2-D Examples</a>
% </html>
%
%% 3-D Examples
% 
% <html>
% <a href="consetofpoints_samples3d.html">
% 3-D Examples</a>
% </html>
%                        
%% 4-D Examples
%
% <html>
% <a href="consetofpoints_samples4d.html">
% 4-D Examples</a>
% </html>
%                               
%% 5-D Examples
% 
% <html>
% <a href="consetofpoints_samples5d.html">
% 5-D Examples</a>
% </html>
%    
%%
% create a set with no boundaries. TODO: should throw an error, because it
% does not make any sense at all.

numerics.conSetOfPoints(3, 10)

%% Dependencies
%
% The constructor of this class calls:
%
% <html>
% <a href="getvalidsetofpoints.html">
% numerics.conSetOfPoints.private.getValidSetOfPoints</a>
% </html>
% ,
% <html>
% <a href="getconstrainedspace.html">
% numerics.conSetOfPoints.private.getConstrainedSpace</a>
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
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="..\conrandmatrix\conrandmatrix.html">
% numerics.conRandMatrix</a>
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
% <a href="plotvalidpoints.html">
% numerics.conSetOfPoints.private.plotValidPoints</a>
% </html>
% ,
% <html>
% <a href="getpointsinfulldimension.html">
% numerics.conSetOfPoints.getPointsInFullDimension</a>
% </html>
% ,
% <html>
% <a href="getscalingtransformation.html">
% numerics.conSetOfPoints.private.getScalingTransformation</a>
% </html>
%
%% TODOs
% # see todo in last example. is this important?
% # check documentation
%
%% <<AuthorTag_DG/>>


