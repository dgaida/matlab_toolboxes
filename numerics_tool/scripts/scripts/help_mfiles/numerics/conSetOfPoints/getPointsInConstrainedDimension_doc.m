%% Syntax
%       p= numerics.conSetOfPoints.getPointsInConstrainedDimension(obj, x)
%       
%% Description
% |p= getPointsInConstrainedDimension(obj, x)| transforms the data |x| into
% the contrained dimension defined by |obj| and returns the data |p| in the
% contrained dimension. As the points |p| are inside the nullspace of the
% linear equality constraints the dataset |x| is first split into a
% homogeneous and a particular solution of the equation $A_{eq} \cdot
% \vec{x} = \vec{b}_{eq}$. The particular solution is: 
%
% $$x_p := A_{eq} \backslash \vec{b}_{eq}$$
%
% |p| then becomes 
%
% $$p = \left( V^T \cdot V \right)^{-1} \cdot V^T \cdot \left( x^T -
% A_{eq} \backslash \vec{b}_{eq} \right)$$ 
%
% Due to a linear transformation, which scales |p| between 0 and 10 (see
% <getscalingtransformation.html
% numerics.conSetOfPoints.getScalingTransformation>), at the end of this
% function this linear transformation is applied: 
%
% $$p= C \cdot \left( V \backslash \left( x^T -
% A_{eq} \backslash \vec{b}_{eq} \right) - d \right) $$
%
%%
% @param |obj| : object of the class <consetofpoints.html
% |numerics.conSetOfPoints|> 
%
%%
% @param |x| : double matrix of data in the full dimension. Number of
% columns defines the dimension of the space, number of rows the number of
% points.
%
%%
% @return |p| : data |x| measured in the constrained dimension. Number of
% columns defines the dimension of the constrained space, number of rows
% the number of points.
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
% because we have defined one linear equality constraint the constrained
% space is a 2-dimensional space:
%

disp( mySet.getPointsInConstrainedDimension(mySet.data) )


%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_optimization/getindividualfromequilibrium')">
% biogas_optimization/biogasM.optimization.popBiogas.getIndividualFromEquilibrium</a>
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
% <a href="getpointsinfulldimension.html">
% numerics.conSetOfPoints.getPointsInFullDimension</a>
% </html>
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


