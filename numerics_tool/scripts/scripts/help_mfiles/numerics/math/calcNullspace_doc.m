%% Syntax
%       V= numerics.math.calcNullspace(A)
%       
%% Description
% |V= calcNullspace(A)| calculates the null space (or nullspace) of matrix 
% |A| and returns it as matrix |V|. Additionally it rearranges the columns 
% of |V| such that |V| looks best possible like an <matlab:doc('eye') eye>
% matrix. The rearrangements preserve that |V| is still the nullspace of
% |A|. 
%
%%
% @param |A| : double matrix, whose null space is calculated and returned.
%
%%
% @return |V| : nullspace of |A|, double matrix
%
% The nullspace is defined as 
%
% $$V := \left[ \vec{v}_1, \dots, \vec{v}_z \right] \in R^{n \times
% z}$$ 
%
% Here the set of orthonormal vectors
%
% $$\left\{ \vec{v}_1, \dots, \vec{v}_z \right\}, \vec{v}_i \in R^n, i= 1,
% \dots, z$$ 
%
% span up the, by the constraints $A \cdot \vec{x} = \vec{0}$,
% reduced space containing the vectors $\vec{\alpha} \in R^z$, $A \in R^{N
% \times N}$ and $\vec{x} \in R^N$. 
%
%% Example
% 
% # Example: the result is the same as shown in
% <http://en.wikipedia.org/wiki/Kernel_%28matrix%29> 

A= [2 3 5; -4 2 3];

disp(A)

numerics.math.calcNullspace(A)


%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('null')">
% matlab/null</a>
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
% <a href="..\consetofpoints\getconstrainedspace.html">
% numerics.conSetOfPoints.private.getConstrainedSpace</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/popbiogas')">
% biogas_optimization/biogasM.optimization.popBiogas</a>
% </html>
%
%% See also
% 
% <html>
% <a href="math.html">
% numerics.math</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>
%% References
% <http://en.wikipedia.org/wiki/Kernel_%28matrix%29>
%


