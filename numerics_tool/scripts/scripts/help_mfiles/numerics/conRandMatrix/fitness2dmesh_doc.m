%% Syntax
%       [fitness]= fitness2dmesh(obj, u, popSize, fh, LB, UB)
%       [fitness]= fitness2dmesh(obj, u, popSize, fh, LB, UB, nonlcon)
%       [fitness]= fitness2dmesh(obj, u, popSize, fh, LB, UB, nonlcon, A,
%       b) 
%       [fitness, linconstraints]= fitness2dmesh(...)
%
%% Description
% |[fitness]= fitness2dmesh(obj, u, popSize, fh, LB, UB)| evaluates a
% 2d-mesh. Tries to maximize distance between vectors stacked together in
% |u|, each of these vectors have the size |numel(u)/popSize|. Therefore it
% maximizes the distance over two dimensions. At the same 
% time all boundaries must hold. Boundaries are lower and upper bounds
% (|LB| and |UB|), nonlinear (in-)equality constraints |nonlcon| and linear
% inequality constraints (|A|, |b|). 
% 
% If the points in the row vector |u| create a volume, then the 2
% dimensional distance between the points is maximized. If the volume is 0,
% then <fitness1dmesh.html numerics.conRandMatrix.fitness1dmesh> is called
% to maximize the 1d-distance. The volume of the dataset is estimated
% calculating the product of the <matlab:doc('svd') singular values> of the
% points in |u|. 
%
% A constraint that fails is penalized with |1e4| and the |fitness| value
% is the sum of all failed constraints. 
%
%%
% @param |obj| : object of the class <..\consetofpoints\consetofpoints.html
% |numerics.conSetOfPoints|>.  
%
%%
% @param |u| : the individual, which is assumed to be
% representing a set of row vectors, which are concatenated to one row
% vector. So |numel(u)|/|popSize| defines the dimension of each one of these
% vectors. Number of elements of |u| must be a multiple of |popSize|. |u|
% may also be a matrix, where the row vectors are concatenated row by row. 
%
%%
% @param |fh| : scaled edge length function h(x,y), which may depend on the
% data 'p', <matlab:doc('function_handle') function_handle>
%
% * inline('min(4*sqrt(sum(p.^2,2))-1,2)','p')
% * <matlab:doc('hgaussian') @hgaussian>
% * <matlab:doc('huniform') @huniform>
% * <matlab:doc('hlhsamp') @hlhsamp>
%
%%
% @param |LB| : lower bound for each vector in the set, so a 1-by-dimension
% of the space (|numel(u)/popSize|) of the set
%
%%
% @param |UB| : upper bound for each vector in the set, so a 1-by-dimension
% of the space (|numel(u)/popSize|) of the set
%
%%
% |[fitness]= fitness2dmesh(obj, u, popSize, fh, LB, UB, nonlcon)| lets you
% specify additional nonlinear (in-)equality constraints
%
%%
% @param |nonlcon| : <matlab:doc('function_handle') function_handle> with
% nonlinear (in-)equality constraints. The first returned value is the
% inequality and the second the equality constraint. 
%
%%
% |[fitness]= fitness2dmesh(obj, u, popSize, fh, LB, UB, nonlcon, A, b)|
% lets you specify linear inequality constraints $A \cdot \vec{u} \leq 
% \vec{b}$. 
%
%%
% @param |A| : matrix of linear inequality constraints for u, so its column
% number is equal to |u|'s column number.
%
%%
% @param |b| : double column vector of linear inequality constraints. Must
% have same number of rows as |A|. 
%
%%
% |[fitness, linconstraints]= fitness2dmesh(...)|
%
%%
% @return |linconstraints| : evaluated linear inequality constraints. These
% are used by some optimization methods. When they are returned the
% evaluated linear inequality constraints are not put into the fitness
% value. |linconstraints| is a column vector with the same number of
% elements, as has |u| has rows.
%
%% Example
%
%
%% Dependencies
%
% This method calls:
%
% <html>
% <a href="..\consetofpoints\getpointsinfulldimension.html">
% numerics.conSetOfPoints.getPointsInFullDimension</a>
% </html>
% ,
% <html>
% <a href="fitness1dmesh.html">
% numerics.conRandMatrix.private.fitness1dmesh</a>
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
% <a href="matlab:doc('matlab/convhulln')">
% matlab/convhulln</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/svd')">
% matlab/svd</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/delaunayn')">
% matlab/delaunayn</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="getoptimalpopulation.html">
% numerics.conRandMatrix.private.getOptimalPopulation</a>
% </html>
%
%% See Also
%
% <html>
% <a href="conrandmatrix.html">
% numerics.conRandMatrix</a>
% </html>
% ,
% <html>
% <a href="..\consetofpoints\consetofpoints.html">
% numerics.conSetOfPoints</a>
% </html>
% ,
% <html>
% <a href="fitnessndmesh.html">
% numerics.conRandMatrix.private.fitnessndmesh</a>
% </html>
%
%% TODOs
% # check link to pdf
% # improve documentation a little
% # document and understand code better
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% Persson, Per-Olof: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\04 Mesh Generation for Implicit Geometries.pdf'', 
% numerics_tool.getHelpPath())'))">
% Mesh Generation for Implicit Geometries</a>, 
% Submitted to the Department of Mathematics in partial fulfillment of the
% requirements for the degree of Doctor of Philosophy at the MASSACHUSETTS
% INSTITUTE OF TECHNOLOGY, 2004
% </li>
% </ol>
% </html>
%


