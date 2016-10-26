%% Syntax
%       [LB, UB, A, b, C, Cinv, d]= getScalingTransformation(LB, UB)
%       [LB, UB, A, b, C, Cinv, d]= getScalingTransformation(LB, UB, A, b)
%       
%% Description
% |[LB, UB, A, b, C, Cinv, d]= getScalingTransformation(LB, UB)| scales the
% original space defined by lower |LB| and upper boundaries |UB| to a space
% between the zero vector (returned as |LB|) and 10 in all dimensions
% (returned as |UB|). 
%
%% 
% @param |LB| : lower bounds of the original space, double row or column
% vector 
%
%% 
% @param |UB| : upper bounds of the original space, double row or column
% vector 
%
%%
% @return |LB| : lower bound vector, here vector of zeros, row vector
%
%%
% @return |UB| : upper bound vector, here vector of 10s, row vector
%
%%
% @return |A| : linear inequality constraint matrix defined in the scaled
% space: $A \cdot \vec{x} \leq \vec{b}$. Here it is just the empty matrix,
% but if you use the other call, then the returned |A| is equal to $A \cdot
% C{-1}$. 
%
%%
% @return |b| : linear inequality constraint vector defined in the scaled
% space, column vector. Here it is just empty, but if you use the other
% call, then the returned |b| is equal to $\vec{b} - A \cdot \vec{d}$. 
%
%%
% @return |C| : linear scaling matrix defined as:
%
% $$C := diag \left( 10 ./ ( UB - LB ) \right)$$
%
%%
% @return |Cinv| : inverse of the linear scaling matrix, thus $C^{-1}$. It
% is: $C^{-1} = diag \left( ( UB - LB ) ./ 10 \right)$
%
%%
% @return |d| : offset vector, equal to given |LB| vector. column vector
%
%%
% |[LB, UB, A, b, C, Cinv, d]= getScalingTransformation(LB, UB, A, b)| also
% scales the linear inequality constraint $A \cdot \vec{x} \leq \vec{b}$ to
% the new space. 
%
%% 
% @param |A| : linear inequality constraint matrix defined in the original
% space, double matrix
%
%% 
% @param |b| : linear inequality constraint vector defined in the original
% space, double vector
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
% <a href="matlab:doc('matlab/diag')">
% matlab/diag</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="getconstrainedspace.html">
% numerics.conSetOfPoints.private.getConstrainedSpace</a>
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
% <a href="..\math\calcnullspace.html">
% numerics.math.calcNullspace</a>
% </html>
% ,
% <html>
% <a href="getpointsinfulldimension.html">
% numerics.conSetOfPoints.getPointsInFullDimension</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


