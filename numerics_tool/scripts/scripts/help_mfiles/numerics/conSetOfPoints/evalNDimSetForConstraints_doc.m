%% Syntax
%       success= numerics.conSetOfPoints.evalNDimSetForConstraints(x)
%       numerics.conSetOfPoints.evalNDimSetForConstraints(x, A, b)
%       numerics.conSetOfPoints.evalNDimSetForConstraints(x, A, b, Aeq,
%       beq) 
%       numerics.conSetOfPoints.evalNDimSetForConstraints(x, A, b, Aeq,
%       beq, LB) 
%       numerics.conSetOfPoints.evalNDimSetForConstraints(x, A, b, Aeq,
%       beq, LB, UB) 
%       numerics.conSetOfPoints.evalNDimSetForConstraints(x, A, b, Aeq,
%       beq, LB, UB, nonlcon) 
%       numerics.conSetOfPoints.evalNDimSetForConstraints(x, A, b, Aeq,
%       beq, LB, UB, nonlcon, dispValidBounds) 
%       
%% Description
% |success= numerics.conSetOfPoints.evalNDimSetForConstraints(x)| evaluates
% the dataset |x| with the number 
% of columns equal to the dimension of the space and the number of rows of
% |x| equal to the number of points in the set. This call actually does
% nothing, because no constraints are given which could be checked. At the
% moment no error is thrown when you call the function like this. TODO:
% maybe in the future. 
%
%%
% @return |success| : returns 1, if all constraints hold, else 0.
%
%%
% |numerics.conSetOfPoints.evalNDimSetForConstraints(x, A, b)| checks each
% row of |x|, denoted by $\vec{x}$, for the 
% linear inequality constraint: $A \cdot \vec{x} \leq \vec{b}$. If there
% are no inequality constraints, then |A| and |b| must be empty. If any 
% boundary does not hold, then a warning is thrown. This is also true for
% the following calls. 
%
%%
% @param |A| : |A| is the matrix defining the linear inequality constraint
% $A \cdot \vec{x} \leq \vec{b}$. The number of columns of |A| must be
% equal to the number of rows of |x|. The number of rows of |A| define the
% number of constraints defined by |A|. 
%
%%
% @param |b| : |b| is the vector defining the linear inequality constraint
% $A \cdot \vec{x} \leq \vec{b}$. |b| must be a column vector with number
% of rows equal to row size of |A|. 
%
%%
% |evalNDimSetForConstraints(x, A, b, Aeq, beq)| additionally checks each
% row of |x| for the linear equality constrainta: $A_{eq} \cdot \vec{x} \leq
% \vec{b}_{eq}$. If there are no equality constraints, then |Aeq| and |beq|
% must be empty. 
%
%%
% @param |Aeq| : |Aeq| is the matrix defining the linear equality
% constraint $A_{eq} \cdot \vec{x} \leq \vec{b}_{eq}$. The number of
% columns of |Aeq| must be equal to the number of rows of |x|. The number
% of rows of |Aeq| define the number of constraints defined by |Aeq|. 
%
%%
% @param |beq| : |beq| is the vector defining the linear equality
% constraint $A_{eq} \cdot \vec{x} \leq \vec{b}_{eq}$. |beq| must be a
% column vector with number of rows equal to row size of |Aeq|. 
%
%%
% |evalNDimSetForConstraints(x, A, b, Aeq, beq, LB)| checks for the lower
% boundaries |LB|. 
%
%% 
% @param |LB| : |LB| is a row or column vector with the lower bounds of the
% set. Must have as many elements as |x| has columns. 
%
%%
% |evalNDimSetForConstraints(x, A, b, Aeq, beq, LB, UB)| checks for the
% upper boundaries |UB|. 
%
%% 
% @param |UB| : |UB| is a row or column vector with the upper bounds of the
% set. Must have as many elements as |x| has columns. 
%
%%
% |evalNDimSetForConstraints(x, A, b, Aeq, beq, LB, UB, nonlcon)|
% evualuates |x| with respect to the <matlab:doc('function_handle')
% function_handle> |nonlcon| containing a function with nonlinear
% (in-)equality constraints. 
%
%%
% @param |nonlcon| : <matlab:doc('function_handle') function_handle>
% defining nonlinear (in-)equality constraints. The first value returned by
% the function defines the inequality constraint, the second value the
% equality constraint. 
%
%%
% |evalNDimSetForConstraints(x, A, b, Aeq, beq, LB, UB, nonlcon,
% dispValidBounds)| lets you specify whether for every valid boundary a
% message should be returned. This does not affect the warnings thrown,
% when a boundary does not hold. 
%
%%
% @param |dispValidBounds| : integer, scalar
% 
% * 0 : If boundaries hold then no message is returned. Default. 
% * 1 : for each boundary that holds a message is returned. 
%
%% Example
%
%
%% Dependencies
%
% This method calls:
%
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
% ,
% <html>
% <a href="matlab:doc('matlab/feval')">
% matlab/feval</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="validatesetforconstraints.html">
% numerics.conSetOfPoints.validateSetForConstraints</a>
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
% <a href="getpointsinconstraineddimension.html">
% numerics.conSetOfPoints.getPointsInConstrainedDimension</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


