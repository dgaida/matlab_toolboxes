%% Syntax
%       numerics.conRandMatrix.setParams(obj, cols, rows)
%       numerics.conRandMatrix.setParams(obj, cols, rows, LB)
%       numerics.conRandMatrix.setParams(obj, cols, rows, LB, UB)
%       numerics.conRandMatrix.setParams(obj, cols, rows, LB, UB, A)
%       numerics.conRandMatrix.setParams(obj, cols, rows, LB, UB, A, b)
%       numerics.conRandMatrix.setParams(obj, cols, rows, LB, UB, A, b, Aeq)
%       setParams(obj, cols, rows, LB, UB, A, b, Aeq, beq)
%       setParams(obj, cols, rows, LB, UB, A, b, Aeq, beq, nonlcon)
%       setParams(obj, cols, rows, LB, UB, A, b, Aeq, beq, nonlcon, data)
%       setParams(obj, cols, rows, LB, UB, A, b, Aeq, beq, nonlcon, data,
%       fitness) 
%
%% Description
% |setParams(obj, cols, rows)| sets the number of columns and rows of the
% matrix.
%
%%
% @param |obj| : object of the class <conrandmatrix.html
% |numerics.conRandMatrix|>.
%
%%
% @param |cols| : dimension of the space, double scalar, integer
%
%%
% @param |rows| : number of points in the set, double scalar, integer
%
%%
% |setParams(obj, cols, rows, LB)| sets the lower bound |LB| of the random
% matrix. 
%
%%
% @param |LB| : lower bound of the random matrix. double row- or
% column-vector with |cols| elements. 
%
%%
% |setParams(obj, cols, rows, LB, UB)| sets the upper bound |UB| of the random
% matrix. 
%
%%
% @param |UB| : upper bound of the random matrix. double row- or
% column-vector with |cols| elements. 
%
%%
% |setParams(obj, cols, rows, LB, UB, A)| sets the linear inequality matrix
% |A|.
%
%%
% @param |A| : linear inequality constraint matrix $A$ of the
% constrained set. double matrix with |cols| columns, number of rows
% define the number of constraints. Or empty.
%
%%
% |setParams(obj, cols, rows, LB, UB, A, b)| sets the linear inequality
% vector |b|, right side.
%
%%
% @param |b| : linear inequality constraint vector $\vec{b}$, right
% side, of the random matrix. double column vector with as many rows as |A|
% or empty.  
%
%%
% |setParams(obj, cols, rows, LB, UB, A, b, Aeq)| sets the linear equality
% matrix $A_{eq}$.
%
%%
% |setParams(obj, cols, rows, LB, UB, A, b, Aeq, beq)| sets the linear
% equality vector $\vec{b}_{eq}$.
%
%%
% |setParams(obj, cols, rows, LB, UB, A, b, Aeq, beq, nonlcon)| sets the
% function handle with nonlinear (in-)equality constraints.
%
%%
% @param |nonlcon| : <matlab:doc('function_handle') function_handle> of the
% nonlinear (in-)equality constraints.
%
%%
% |setParams(obj, cols, rows, LB, UB, A, b, Aeq, beq, nonlcon, data)| the
% data of the matrix, respectively the matrix itself.
%
%%
% |setParams(obj, cols, rows, LB, UB, A, b, Aeq, beq, nonlcon, data,
% fitness)| sets the fitness of the determined data with respect to
% the fitness function.
%
%% Example
%
%
%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
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
% <a href="matlab:doc('biogas_optimization/popbiogas')">
% biogas_optimization/biogasM.optimization.popBiogas</a>
% </html>
%
%% See Also
%
% <html>
% <a href="conrandmatrix.html">
% numerics.conRandMatrix</a>
% </html>
%
%% TODOs
% # improve code and documentation
% # check parameters a bit better
%
%% <<AuthorTag_DG/>>


