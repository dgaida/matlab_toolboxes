%% Syntax
%       x= numerics.conSetOfPoints.getPointsInFullDimension(obj, p)
%       
%% Description
% |x= getPointsInFullDimension(obj, p)| returns, given the points
% |p| living in the constrained space of |obj|, the corresponding points
% |x| living in the full space of the object |obj|. 
%
% 1st: the scaling transformation is calculated out of the data |p|. 
%
% $$\vec{p}_0 = C^{-1} \cdot \vec{p} + \vec{d}$$
%
% 2nd: the particular solution is calculated: 
%
% $$x_p := A_{eq} \backslash \vec{b}_{eq}$$
%
% 3rd: The vectors $\vec{p}_0$ are in the nullspace of the linear equality
% constraint matrix $A_{eq}$. The homogeneous solution then is calculated:
%
% $$\vec{x}_h= V \cdot \vec{p}_0$$
%
% 4th: 
%
% $$\vec{x} := \vec{x}_h + \vec{x}_p$$
%
%%
% @param |obj| : object of the class <consetofpoints.html
% |numerics.conSetOfPoints|>
%
%%
% @param |p| : points living in the constrained space of the object. They
% have to be given as row vectors, so the number of columns have to be the
% same as the dimension of the constrained space. double array
%
%%
% @return |x| : the corresponding points of |p| living the the full space
% of the object |obj|. 
%
%% Example
%
% Create a set containing ten 3-dimensional points satisfying the given 
% boundaries and the linear equality constraint

mySet= numerics.conSetOfPoints(3, 10, [], [], [1 1 0], 2, [0, 0, 1], [5, 5, 10]);

%%
% this is the set

disp(mySet)

%%
%

disp( mySet.getPointsInFullDimension(mySet.conData) )


%% Dependencies
%
% The method calls:
%
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('fitnessfindoptimalequilibrium')">
% fitnessFindOptimalEquilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/getadm1paramsfromindividual')">
% biogas_optimization/biogasM.optimization.popBiogas.getADM1ParamsFromIndividual</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/getequilibriumfromindividual')">
% biogas_optimization/biogasM.optimization.popBiogas.getEquilibriumFromIndividual</a>
% </html>
% ,
% <html>
% ...
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
% ,
% <html>
% <a href="getpointsinconstraineddimension.html">
% numerics.conSetOfPoints.getPointsInConstrainedDimension</a>
% </html>
%
%% TODOs
% # check mathematical documentation
%
%% <<AuthorTag_DG/>>


