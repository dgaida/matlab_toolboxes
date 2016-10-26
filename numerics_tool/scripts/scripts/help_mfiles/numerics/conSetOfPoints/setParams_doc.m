%% Syntax
%       numerics.conSetOfPoints.setParams(obj, conDim, rows)
%       setParams(obj, conDim, rows, conLB)
%       setParams(obj, conDim, rows, conLB, conUB)
%       setParams(obj, conDim, rows, conLB, conUB, conA)
%       setParams(obj, conDim, rows, conLB, conUB, conA, conb)
%       setParams(obj, conDim, rows, conLB, conUB, conA, conb, conAeq)
%       setParams(obj, conDim, rows, conLB, conUB, conA, conb, conAeq,
%       conbeq) 
%       setParams(obj, conDim, rows, conLB, conUB, conA, conb, conAeq,
%       conbeq, nonlcon) 
%       setParams(obj, conDim, rows, conLB, conUB, conA, conb, conAeq,
%       conbeq, nonlcon, conData) 
%       setParams(obj, conDim, rows, conLB, conUB, conA, conb, conAeq,
%       conbeq, nonlcon, conData, V) 
%       setParams(obj, conDim, rows, conLB, conUB, conA, conb, conAeq,
%       conbeq, nonlcon, conData, V, A) 
%       setParams(obj, conDim, rows, conLB, conUB, conA, conb, conAeq,
%       conbeq, nonlcon, conData, V, A, b) 
%       setParams(obj, conDim, rows, conLB, conUB, conA, conb, conAeq,
%       conbeq, nonlcon, conData, V, A, b, Aeq) 
%       setParams(obj, conDim, rows, conLB, conUB, conA, conb, conAeq,
%       conbeq, nonlcon, conData, V, A, b, Aeq, beq) 
%       setParams(obj, conDim, rows, conLB, conUB, conA, conb, conAeq,
%       conbeq, nonlcon, conData, V, A, b, Aeq, beq, C) 
%       setParams(obj, conDim, rows, conLB, conUB, conA, conb, conAeq,
%       conbeq, nonlcon, conData, V, A, b, Aeq, beq, C, Cinv) 
%       setParams(obj, conDim, rows, conLB, conUB, conA, conb, conAeq,
%       conbeq, nonlcon, conData, V, A, b, Aeq, beq, C, Cinv, d) 
%
%% Description
% |setParams(obj, conDim, rows)| sets the dimension of the constrained
% space |conDim| and the number of points in the set, number of |rows|.
%
%%
% @param |conDim| : dimension of the constrained space, double scalar,
% integer
%
%%
% @param |rows| : number of points in the set, double scalar, integer
%
%%
% |setParams(obj, conDim, rows, conLB)| sets the lower bound |conLB| of the
% constrained set.
%
%%
% @param |conLB| : lower bound of the constrained set. double row- or
% column-vector with |conDim| elements. 
%
%%
% |setParams(obj, conDim, rows, conLB, conUB)| sets the upper bound of the
% constrained set.
%
%%
% @param |conUB| : upper bound of the constrained set. double row- or
% column-vector with |conDim| elements. 
%
%%
% |setParams(obj, conDim, rows, conLB, conUB, conA)| sets the linear
% inequality constraint matrix $A$ of the constrained set.
%
%%
% @param |conA| : linear inequality constraint matrix $A$ of the
% constrained set. double matrix with |conDim| columns, number of rows
% define the number of constraints. Or empty.
%
%%
% |setParams(obj, conDim, rows, conLB, conUB, conA, conb)| sets the linear
% inequality constraint vector $\vec{b}$, right side, of the constrained
% set. 
%
%%
% @param |conb| : linear inequality constraint vector $\vec{b}$, right
% side, of the constrained set. double column vector with as many rows as
% |conA| or empty. 
%
%%
% |setParams(obj, conDim, rows, conLB, conUB, conA, conb, conAeq)| sets the
% linear equality constraint matrix $A_{eq}$ of the constrained set.
%
%%
% @param |conAeq| : linear equality constraint matrix $A_{eq}$ of the
% constrained set. Always []. 
%
%%
% |setParams(obj, conDim, rows, conLB, conUB, conA, conb, conAeq, conbeq)|
% sets the linear equality constraint vector $\vec{b}_{eq}$, right side, of
% the constrained set. 
%
%%
% @param |conbeq| : linear equality constraint vector $\vec{b}_{eq}$, right
% side, of the constrained set. Always []. 
%
%%
% |setParams(obj, conDim, rows, conLB, conUB, conA, conb, conAeq, conbeq,
% nonlcon)| sets the <matlab:doc('function_handle') function_handle> of the
% nonlinear (in-)equality constraints.
%
%%
% @param |nonlcon| : <matlab:doc('function_handle') function_handle> of the
% nonlinear (in-)equality constraints.
%
%%
% |setParams(obj, conDim, rows, conLB, conUB, conA, conb, conAeq, conbeq,
% nonlcon, conData)| sets the points of the constrained space. |conData| is
% a matrix with |conDim| columns and |rows| rows.
%
%%
% @param |conData| : points of the constrained space. |conData| is
% a matrix with |conDim| columns and |rows| rows.
%
%%
% |setParams(obj, conDim, rows, conLB, conUB, conA, conb, conAeq, conbeq,
% nonlcon, conData, V)| sets the transformation matrix to a possible higher
% dimensional set, which is connected to this one via the linear equality
% constraints, see <getconstrainedspace.html
% numerics.conSetOfPoints.private.getConstrainedSpace>.
%
%%
% @param |V| : $V := null(A_{eq})$
%
%%
% |setParams(obj, conDim, rows, conLB, conUB, conA, conb, conAeq, conbeq,
% nonlcon, conData, V, A)| sets the linear inequality constraints in the
% named possible higher dimensional set, which have to be the same as the
% constraint $conA$, just formulated in the higher dimensional space.
%
%%
% @param |A| : linear inequality constraints in the named possible higher
% dimensional space
%
%%
% |setParams(obj, conDim, rows, conLB, conUB, conA, conb, conAeq, conbeq,
% nonlcon, conData, V, A, b)| sets the linear inequality constraints in the
% named possible higher dimensional set, which have to be the same as the
% constraint $conb$, just formulated in the higher dimensional space.
%
%%
% @param |b| : linear inequality constraints in the named possible higher
% dimensional space
%
%%
% |setParams(obj, conDim, rows, conLB, conUB, conA, conb, conAeq, conbeq,
% nonlcon, conData, V, A, b, Aeq)| sets the linear equality constraints in
% the named possible higher dimensional set, they have to hold the
% definition $V := null(A_{eq})$. Since they define the constrained set, they
% disappear in the constrained set, so |conAeq| then is empty.
%
%%
% @param |Aeq| : linear equality constraints in the named possible higher
% dimensional space
%
%%
% |setParams(obj, conDim, rows, conLB, conUB, conA, conb, conAeq, conbeq,
% nonlcon, conData, V, A, b, Aeq, beq)| sets the linear equality
% constraints in the named possible higher dimensional set. Since |Aeq|
% define the constrained set, |beq| disappears in the constrained set, so
% |conbeq| then is empty. 
%
%%
% @param |beq| : linear equality constraints in the named possible higher
% dimensional space
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
% <a href="consetofpoints.html">
% numerics.conSetOfPoints</a>
% </html>
% ,
% <html>
% <a href="getconstrainedspace.html">
% numerics.conSetOfPoints.private.getConstrainedSpace</a>
% </html>
%
%% TODOs
% # check appearance of documentation
% # check parameters of method, see todo inside the file
%
%% <<AuthorTag_DG/>>


