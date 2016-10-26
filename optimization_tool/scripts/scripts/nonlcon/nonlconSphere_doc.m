%% Syntax
%       [c, ceq]= nonlconSphere(r)
%       [c, ceq]= nonlconSphere(r, radius)
%       [c, ceq]= nonlconSphere(r, radius, center)
%       [c, ceq]= nonlconSphere(r, radius, center, ineq)
%       [c, ceq]= nonlconSphere(r, radius, center, ineq, eq)
%       
%% Description
% |[c, ceq]= nonlconSphere(r)| implements a nonlinear inequality constraint
% in form of a sphere with radius 2 around the zero vector with the
% dimension of the vector |r|. The function returns the evaluated value at
% |r|, which is zero on the sphereplane, smaller zero inside the sphere and
% greater outside.
%
% The formula of the sphere is:
%
% $$\sqrt{ \left( \vec{r} - \vec{center} \right)' \cdot 
%          \left( \vec{r} - \vec{center} \right)} - radius$$
%
%%
% @param |r| : scalar or vector where the function shall be evaluated. It
% also defines the dimension of the space in which the sphere lies and also
% has.
%
%%
% @return |c| : nonlinear inequality constraint evaluated at |r|, which is 
% zero on the sphereplane, smaller zero inside the sphere and greater
% outside. 
%
%%
% @return |ceq| : [] in this case. Because per default the function is
% implemented as a nonlinear inequality constraint function, see params
% |ineq| and |eq|.
%
%%
% |[c, ceq]= nonlconSphere(r, radius)| implements the sphere with the
% radius |radius|.
%
%%
% @param |radius| : double scalar value defining the radius of the sphere.
%
%%
% |[c, ceq]= nonlconSphere(r, radius, center)| draws the sphere around the
% given |center|.
%
%%
% @param |center| : double scalar or vector in the dimension of |r|. If it
% is a scalar, then each dimension gets the scalar value.
%
%%
% |[c, ceq]= nonlconSphere(r, radius, center, ineq)|
%
%%
% @param |ineq| : if 1, then the constraint is implemented as a nonlinear
% inequality constraint, else |c= []|
%
%%
% |[c, ceq]= nonlconSphere(r, radius, center, ineq, eq)|
%
%%
% @param |eq| : if 1, then the constraint is implemented as a nonlinear
% equality constraint, else |ceq= []|. The parameters |eq| and |ineq| could
% be 0 or 1 both at the same time. So the constraint function can be an in-
% and an equality constraint at the same time or nothing, if both
% parameters are 0. 
%
%%
% @return |c| : nonlinear inequality constraint evaluated at |r|.
%
%%
% @return |ceq| : nonlinear equality constraint evaluated at |r|.
%
%% Example
%
% draw a circle. we see the behaviour of the function. Insie the circle we
% have negative values, outside positive and on the surface we have 0. 

[X, Y]= meshgrid(-1:0.02:1, -1:0.02:1);

Z= zeros(size(X));

for icol= 1:size(X,2)
  for irow= 1:size(X,1)
    Z(irow, icol)= nonlconSphere([X(irow, icol), Y(irow, icol)], 1, 0);
  end
end

surf(X, Y, Z)

%%
% if we set the boundaries close to 0 we see the circle

zlim([-0.01, 0.01])
view(2)

%%
% use it in an optimization problem

numerics.conRandMatrix(1, 10, [], [], [], [], 0, 10, ...
                       @(r)nonlconSphere(r, 1, 3, 1, 0), ...
                       [], [], [], [], [], [], 0, 1)

%%
% For further examples see <matlab:doc('numerics_tool/consetofpoints') 
% numerics_tool/numerics.conSetOfPoints> and
% <matlab:doc('numerics_tool/conrandmatrix')
% numerics_tool/numerics.conRandMatrix>. 
%                     
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
%
% <html>
% <a href="matlab:doc('numerics_tool/consetofpoints')">
% numerics_tool/numerics.conSetOfPoints</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('numerics_tool/conrandmatrix')">
% numerics_tool/numerics.conRandMatrix</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


