%% Syntax
%       numerics.conRandMatrix()
%       numerics.conRandMatrix(cols)
%       numerics.conRandMatrix(cols, rows)
%       numerics.conRandMatrix(cols, rows, A)
%       numerics.conRandMatrix(cols, rows, A, b)
%       numerics.conRandMatrix(cols, rows, A, b, Aeq)
%       numerics.conRandMatrix(cols, rows, A, b, Aeq, beq)
%       numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB)
%       numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB, UB)
%       numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB, UB, nonlcon)
%       numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB, UB, nonlcon,
%       fitness) 
%       numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB, UB, nonlcon,
%       fitness, solverlist1) 
%       numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB, UB, nonlcon,
%       fitness, solverlist1, solverlist2) 
%       numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB, UB, nonlcon,
%       fitness, solverlist1, solverlist2, parallel) 
%       numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB, UB, nonlcon,
%       fitness, solverlist1, solverlist2, parallel, nWorker) 
%       numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB, UB, nonlcon,
%       fitness, solverlist1, solverlist2, parallel, nWorker, data) 
%       numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB, UB, nonlcon,
%       fitness, solverlist1, solverlist2, parallel, nWorker, data,
%       dispValidBounds) 
%       numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB, UB, nonlcon,
%       fitness, solverlist1, solverlist2, parallel, nWorker, data,
%       dispValidBounds, plotnonlcon) 
%
%% Description
% Definition of a random matrix where each row is bounded and constrained to
% (non-)linear (in-)equality constraints (|LB, UB, A, b, Aeq, beq,
% nonlcon|). This class can be used to create 
% the initial population of an stochastic optimization problem. The matrix
% is created using among others the <matlab:doc('ga') |ga|> method out of the 
% 'Genetic Algorithm and Direct Search Toolbox' toolbox (see parameter:
% |solverlist1| and |solverlist2|). 
%
% First a randomly distributed matrix is created which satisfies the bounds
% and all constraints using the class
% <..\consetofpoints\consetofpoints.html |numerics.conSetOfPoints|>. To
% create this matrix the solvers given in |solverlist1| are used. As the
% initial population is generated using latin hypercube sampling the matrix
% is not totally random, but already has a satisfying distribution (see
% param: |data|). 
% Then the randomly distributed rows (vectors) are arranged (changed) such
% that they in the end try to satisfy the given distribution (it is always
% equal distance between points, see e.g.
% <matlab:doc('numerics_tool/fitness1dmesh') numerics_tool/fitness1dmesh>).
% The results  
% are validated and plotted, if possible, using the method
% <..\consetofpoints\validatesetforconstraints.html
% |numerics.conSetOfPoints.validateSetForConstraints|>. 
%
%%
% This class is a handle class.
%
%%
% |numerics.conRandMatrix()| creates an object with an empty matrix
%
%%
% |numerics.conRandMatrix(cols)|
%
%%
% @param |cols| : dimension of the space the points should lie in. The
% resulting matrix will have |cols| columns. double scalar, integer.
%
%%
% |numerics.conRandMatrix(cols, rows)|
%
%%
% @param |rows| : double integer scalar, with the number of points in the
% set 
%
%%
% |numerics.conRandMatrix(cols, rows, A)|
%
%%
% @param |A| : double matrix of the inequality constraint $A \cdot x \leq
% b$. Number of columns must be equal to |cols|. Number of rows define
% number of constraints. 
%
%%
% |numerics.conRandMatrix(cols, rows, A, b)|
%
%%
% @param |b| : double column vector of the inequality constraint $A \cdot x
% \leq b$. Must have same number of rows as |A|. 
%
%%
% |numerics.conRandMatrix(cols, rows, A, b, Aeq)|
%
%%
% @param |Aeq| : double matrix of the equality constraint $A_{eq} \cdot x =
% b_{eq}$. Number of columns must be equal to |cols|. Number of rows define
% number of constraints. 
%
%%
% |numerics.conRandMatrix(cols, rows, A, b, Aeq, beq)|
%
%%
% @param |beq| : double column vector of the equality constraint $A_{eq} \cdot
% x = b_{eq}$. Must have same number of rows as |Aeq|. 
%
%%
% |numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB)|
%
%%
% @param |LB| : lower bound of the space the points are lying in, double
% row vector. Must have |cols| elements. 
%
%%
% |numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB, UB)|
%
%%
% @param |UB| : upper bound of the space the points are lying in, double
% row vector. Must have |cols| elements. 
%
%%
% |numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB, UB, nonlcon)|
%
%%
% @param |nonlcon| : <matlab:doc('function_handle') function_handle>
% defining a nonlinear (in-)equality constraint function. 
%
%%
% |numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB, UB, nonlcon,
% fitness)|
%
%%
% |numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB, UB, nonlcon,
% fitness, solverlist1)|
%
%%
% @param |solverlist1| : <matlab:doc('cellstr') cellstring> with solvers
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
% |numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB, UB, nonlcon,
% fitness, solverlist1, solverlist2)|
%
%%
% @param |solverlist2| : <matlab:doc('cellstr') cellstring> with solvers
% which solve one after 
% another the problem changing the set of points such that they satisfy the
% given constraints and have the given distribution. At the moment possible
% solvers are 
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
% e.g. {'PS', 'ISRES', 'GA'}
%
%%
% |numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB, UB, nonlcon,
% fitness, solverlist1, solverlist2, parallel)|
%
%% <<parallel/>>
%%
% |numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB, UB, nonlcon,
% fitness, solverlist1, solverlist2, parallel, nWorker)|
%
%% <<nWorker/>>
%%
% |numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB, UB, nonlcon,
% fitness, solverlist1, solverlist2, parallel, nWorker, data)|
%
%%
% @param |data| : data which is used as e.g. initial population for the to
% be solved optimization problem that the data should satisfy the
% constraints. the rows in |data| satisfying the constraints already, are
% not changed, the data not yet satisfying the constraints are changed as
% wanted.
%
%%
% |numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB, UB, nonlcon,
% fitness, solverlist1, solverlist2, parallel, nWorker, data,
% dispValidBounds)| 
%
%%
% @param |dispValidBounds| : integer, scalar
% 
% * 0 : If boundaries hold then no message is returned. Default. 
% * 1 : for each boundary that holds a message is returned. 
%
%%
% |numerics.conRandMatrix(cols, rows, A, b, Aeq, beq, LB, UB, nonlcon,
% fitness, solverlist1, solverlist2, parallel, nWorker, data,
% dispValidBounds, plotnonlcon)| 
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
% <a href="conrandmatrix_samples1d.html">
% 1-D Examples</a>
% </html>
%
%% 2-D Examples
% 
% <html>
% <a href="conrandmatrix_samples2d.html">
% 2-D Examples</a>
% </html>
%
%% 3-D Examples
% 
% <html>
% <a href="conrandmatrix_samples3d.html">
% 3-D Examples</a>
% </html>
%                        
%% 4-D Examples
%
% <html>
% <a href="conrandmatrix_samples4d.html">
% 4-D Examples</a>
% </html>
%                               
%% 5-D Examples
% 
% <html>
% <a href="conrandmatrix_samples5d.html">
% 5-D Examples</a>
% </html>
%    
%% Dependencies
%
% The constructor of this class calls:
%
% <html>
% <a href="getoptimalpopulation.html">
% numerics.conSetOfPoints.private.getOptimalPopulation</a>
% </html>
% ,
% <html>
% <a href="..\consetofpoints\consetofpoints.html">
% numerics.conSetOfPoints</a>
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
% <a href="matlab:doc('optimization_tool/conpopulation')">
% optimization_tool/optimization.conPopulation</a>
% </html>
%
%% See Also
%
% <html>
% <a href="..\consetofpoints\getconstrainedspace.html">
% numerics.conSetOfPoints.private.getConstrainedSpace</a>
% </html>
%
%% TODOs
% # improve documentation and code
%
%% <<AuthorTag_DG/>>


