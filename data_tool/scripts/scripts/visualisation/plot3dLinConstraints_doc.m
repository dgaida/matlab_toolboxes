%% Syntax
%       [X, Y, Z]= plot3dLinConstraints(A, b, LB, UB) 
%       [X, Y, Z]= plot3dLinConstraints(A, b, LB, UB, alpha) 
%       [X, Y, Z]= plot3dLinConstraints(A, b, LB, UB, alpha, noPoints) 
%       [X, Y, Z]= plot3dLinConstraints(A, b, LB, UB, alpha, noPoints,
%       color) 
%       
%% Description
% |[X, Y, Z]= plot3dLinConstraints(A, b, LB, UB)|
% draws the 3-dimensional boundary as a surface using <matlab:doc('surf')
% |surf|>. 
%
%%
% @param |A| : The matrix describing the linear (in-)equality constraint
% $A_{eq}
% \cdot \vec{x} = \vec{b}_{eq}$ resp. $A \cdot \vec{x} \leq \vec{b}$. You 
% must provide |A| row by row, so here |A| is just a 3-dimensional row
% vector. 
%
%% 
% @param |b| : The vector describing the linear (in-)equality constraint. 
% You must provide |b| row by row, so here |b| is just a scalar.
%
%%
% @param |LB| : Lower Bound of the 3-dim space, so a 3-dimensional row
% or column vector.
%
%%
% @param |UB| : Upper Bound of the 3-dim space, so a 3-dimensional row
% or column vector 
%
%%
% @return |X| : median value of the surface, is inside the center of the
% surface. 
%
%%
% @return |Y| : median value of the surface, is inside the center of the
% surface. 
%
%%
% @return |Z| : median value of the surface, is inside the center of the
% surface. 
%
%%
% Derivation of the formula used in this method:
%
% $$A \cdot \vec{x} \leq \vec{b}$$
%
% $$\vec{x} := \left( x_1, x_2, x_3 \right)^T \in R^3, \vec{b} \in R^3, A
% := \left( \vec{a}_1, \vec{a}_2, \vec{a}_3 \right)$$ 
%
% $$\left( \vec{a}_1, \vec{a}_2, \vec{a}_3 \right) \cdot \left( x_1, x_2,
% x_3 \right)^T \leq \vec{b}$$ 
%
% $$x_1 \cdot \vec{a}_1 + x_2 \cdot \vec{a}_2 + x_3 \cdot \vec{a}_3 \leq
% \vec{b}$$ 
%
% Exemplary transformation:
%
% $$x_3 \cdot \vec{a}_3 \leq
% \vec{b} - x_1 \cdot \vec{a}_1 - x_2 \cdot \vec{a}_2$$ 
%
% $$\vec{a}_3^T \cdot \vec{a}_3 \cdot x_3 \leq
% \vec{a}_3^T \cdot \left( \vec{b} - x_1 \cdot \vec{a}_1 - x_2 \cdot
% \vec{a}_2 \right)$$  
%
% $$x_3 \leq \frac{1}{\vec{a}_3^T \cdot \vec{a}_3} \cdot 
% \vec{a}_3^T \cdot \left( \vec{b} - x_1 \cdot \vec{a}_1 - x_2 \cdot
% \vec{a}_2 \right)$$  
%
% If $\vec{a}_3$ is the zero-vector, then do the transformation towards
% $\vec{a}_1$ or $\vec{a}_2$. 
%
% In this exemplary transformation a <matlab:doc('meshgrid') meshgrid> over
% the x and y space is generated. Over this grid the equation above is
% evaluated, which generates a 2dim. plane plotted with <matlab:doc('surf')
% surf>. 
% 
%%
% |[X, Y, Z]= plot3dLinConstraints(A, b, LB, UB,
% alpha)| sets the alpha channel of the surface. 
%
%%
% @param |alpha| : The surface is drawn as a grid surface, where the edges
% are drawn using the alpha channel. |alpha| must be a scalar between 0 and
% 1. 
%
%%
% |[X, Y, Z]= plot3dLinConstraints(A, b, LB, UB,
% alpha, noPoints)| sets the number of knots of the grid. 
%
%%
% @param |noPoints| : number of knots of the grid. scalar integer
%
%%
% |[X, Y, Z]= plot3dLinConstraints(A, b, LB, UB,
% alpha, noPoints, color)| sets the color of the surface. 
%
%%
% @param |color| : color of the drawn grid specified as char letter, see
% <matlab:doc('ColorSpec') ColorSpec>. 
%
%% Example
%
%

data= load_file('data_to_plot.mat');

inputs= [double(data(:, 2:3)), double(data(:,8))];

outputs= double(data(:, end));

xlabel('x_1')  
ylabel('x_2')  
zlabel('x_3')  

%%
% x3= -x2 + 30
% x3 + x2 = 30
% x2 + x3 = 30
% A= [0 1 1]
% b= 30

plot3views( @()testplot(inputs, outputs) );

rotate3d on

%%

figure;

a= [1;0;0];     % this is the normal vector to the plane x= 0
b= [0;1;0];     % this is the normal vector to the plane y= 0
c= numerics.math.crossND(a,b);

% to this function we have to pass the normal vector, which is the
% constraint at the same time. A linear transformation which projects on
% the plane is a vector which is rectangular to a, thus b= [0, 1, 0] and c=
% [0, 0, 1]
plot3dLinConstraints(a', 0, [0, 0, 0], [1, 1, 1]);

%% 
% 

plot3dLinConstraints(a', 0, [0, 0, 0], [1, 1, 1]);
hold on;
plot3dLinConstraints(b', 0, [0, 0, 0], [1, 1, 1]);
plot3dLinConstraints(c', 0, [0, 0, 0], [1, 1, 1]);
hold off;

daspect([1 1 1]);

%%

figure;

arrow([0, 0, 0], a);
hold on;
arrow([0, 0, 0], b);
arrow([0, 0, 0], 6.*c);
hold off;

daspect([1 1 1]);

%% Dependencies
%
% This method calls:
%
% <html>
% <a href=matlab:doc('surf')>
% matlab/surf</a>
% </html>
% ,
% <html>
% <a href=matlab:doc('meshgrid')>
% matlab/meshgrid</a>
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
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('numerics_tool/plotconstraints')">
% numerics_tool/numerics.conSetOfPoints.private.plotConstraints</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc('numerics_tool/consetofpoints')">
% numerics_tool/numerics.conSetOfPoints</a>
% </html>
% ,
% <html>
% <a href="plot1dlinconstraints.html">
% plot1dLinConstraints</a>
% </html>
% ,
% <html>
% <a href="plot2dlinconstraints.html">
% plot2dLinConstraints</a>
% </html>
% ,
% <html>
% <a href="plot4dlinconstraints.html">
% plot4dLinConstraints</a>
% </html>
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


