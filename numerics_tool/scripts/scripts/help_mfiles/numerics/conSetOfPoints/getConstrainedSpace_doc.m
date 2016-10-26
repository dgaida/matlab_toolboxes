%% Syntax
%       obj= numerics.conSetOfPoints.getConstrainedSpace(obj)
%       
%% Description
% |obj= numerics.conSetOfPoints.getConstrainedSpace(obj)| calculates the
% reduced vector space $Z \in R^z$ out of the vector space given by the
% object |obj| of the class <consetofpoints.html
% |numerics.conSetOfPoints|>. This new vector space $Z$ is a subset of the
% original space which is defined by linear equality constraints $A_{eq}
% \cdot \vec{x} = \vec{b}_{eq}$. 
%
%% 
% @param |obj| : configured object of the class <consetofpoints.html
% |numerics.conSetOfPoints|>. The parameters needed in this function are
% |Aeq|, |beq|, |A|, |b|, |LB| and |UB|. 
%
%%
% Having a set of vectors, one of them is $\vec{x} \in X$, $X \subseteq
% R^n$, which is constrained by linear equality 
% constraints $A_{eq} \cdot \vec{x} = \vec{b}_{eq}$, a subset of vectors, 
% one of them is $\vec{\alpha} \in Z$, $Z \subseteq
% R^z$, $z \leq n$, can be determined for which these linear equality
% constraints always hold. E.g. having 3-dimensional vectors $\vec{x}$ one
% linear equality constraint defines a plane, that is a 2-dimensional
% space. The $\vec{\alpha}$ s are defined such that they live in this 2-dim
% space, the plane. Having a further linear quality constraint, we have two
% planes where the $\vec{\alpha}$ s live in a one-dimensional space, the
% cutting line of the two planes, if it exists, else in the empty space.
% 
% Defining $\vec{x} := \vec{x}_h + \vec{x}_p$ with the particular solution
% $A_{eq} \cdot \vec{x}_p := \vec{b}_{eq}$ and the homogeneous solution
% $A_{eq} \cdot \vec{x}_h = \vec{0}$ we get the least squares solution for
% $\vec{x}$ as 
%
% $$\vec{x}= V \cdot \vec{\alpha} + A_{eq} \backslash \vec{b}_{eq}$$
%
% with $V:= null(A_{eq})$. 
%
% The linear inequality constraint $A \cdot \vec{x} \leq \vec{b}$ can then
% be formulated as 
%
% $$A \cdot \left( V \cdot \vec{\alpha} + A_{eq} \backslash \vec{b}_{eq}
% \right) \leq \vec{b}$$ 
%
% $$\underbrace{A \cdot V}_{=:A_V} \cdot \vec{\alpha} \leq
% \underbrace{\vec{b} - A \cdot \left( A_{eq} 
% \backslash \vec{b}_{eq} \right)}_{=:\vec{a}_v}$$
%
% ->
%
% $$A_V \cdot \vec{\alpha} \leq \vec{a}_v$$
%
%%
% At the end of the function <getscalingtransformation.html
% numerics.conSetOfPoints.getScalingTransformation> is called, which scales
% the original problem between the boundaries 0 and 10. 
%
%%
% @return |obj| : returns the given object with the added parameters
% |conAeq|, |conbeq|, |conA|, |conb|, |conLB|, |conUB|, |conDim| and |V|.
%
% |conAeq| and |conbeq| are always empty. |conA| is set to $A_V$ and |conb|
% is set to $\vec{a}_v$. 
%
%% Example
%
%
%% Dependencies
%
% This method calls:
%
% <html>
% <a href="..\math\calcnullspace.html">
% numerics.math.calcNullspace</a>
% </html>
% ,
% <html>
% <a href="getscalingtransformation.html">
% numerics.conSetOfPoints.getScalingTransformation</a>
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
% <a href="matlab:doc fmincon">
% fmincon</a>
% </html>
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


