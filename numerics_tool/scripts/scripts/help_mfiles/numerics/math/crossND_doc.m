%% Syntax
%       c= numerics.math.crossND(a)
%       c= numerics.math.crossND(a, b)
%       c= numerics.math.crossND(a, b, d, ...)
%
%% Description
% |c= crossND(a)| calculates a 2-dim. vector c, for which $a \cdot c = 0$
% holds, which means that |c| is orthogonal to |a|.
%
%% 
% @param |a| : 2-dim. double vector
%
%%
% @return |c| : 2-dim. double vector
%
%%
% |c= crossND(a, b)| calculates a 3-dim. vector c, for which $a \cdot c = 0$
% and $b \cdot c = 0$ hold, which means that |c| is orthogonal to |a| and
% |b|. If |a| and |b| are linearly dependent, two vectors are then colinear
% (parallel or anti-parallel), then |c| is the null-vector.
%
%%
% @param |a|, |b| : 3-dim. double vectors
%
%%
% @return |c| : 3-dim. double vector
%
%%
% |c= crossND(a, b, d, ...)| calculates a (nargin+1)-dim. vector c, for
% which $a \cdot c = 0$, $b \cdot c = 0$, $d \cdot c = 0$, etc. hold, which
% means that |c| is orthogonal to |a|, |b|, |d|, etc.
%
%%
% @param |a|, |b|, |d|, ... : (nargin+1)-dim. vectors
%
%%
% @return |c| : (nargin+1)-dim. vector
%
%%
% It is well known, that 
%
% $$\vec{c}= \vec{a} \times \vec{b} = 
% \left| { \matrix{ e_1 & e_2 & e_3 \cr 
%                   a_1 & a_2 & a_3 \cr
%                   b_1 & b_2 & b_3 \cr
%                 } } \right|
% $$
%
% where $\left| \cdot \right|$ calculates the determinant and 
% $\vec{a} := \left( a_1, a_2, a_3 \right)^T$, 
% $\vec{b} := \left( b_1, b_2, b_3 \right)^T$ and $e_i, i= 1,2,3$ stand as
% symbol for the orthormal basis, spanned by the set of orthonormal vectors
% $\vec{e}_i, i= 1,2,3$.
%
% Since $\left| A \right|= \left| A^T \right|$ we furthermore can write
%
% $$\vec{c}= \vec{a} \times \vec{b} = 
% \left| { \matrix{ e_1 & a_1 & b_1 \cr 
%                   e_2 & a_2 & b_2 \cr
%                   e_3 & a_3 & b_3 \cr
%                 } } \right|
% $$
%
% and
%
% $$c_i= \left| \left[ \vec{e}_i, \vec{a}, \vec{b} \right] \right|, i= 1,2,3$$
%
% where $\vec{c} := \left( c_1, c_2, c_3 \right)^T$
%
% This form is extended to n-1 n-dimensional vectors $\vec{a}, \vec{b},
% \vec{d}, ... \in R^n$ as 
%
% $$c_i= \left| \vec{e}_i, \vec{a}, \vec{b}, \vec{d}, \dots \right|$$
%
%% Examples
%
% # As the three vectors are linearly dependent, the resulting vector is
% almost the null vector. 

a= [1;2;5;3];
b= [2;7;3;1];
d= a + b;
numerics.math.crossND(a,b,d)

%%
%
% # <matlab:doc('cross') cross> does the same as this method for the
% 3-dimensional case. 

a= [1;2;5];
b= [2;7;3];
numerics.math.crossND(a,b)
cross(a,b)

%%
%
% # both vectors are linearly dependent

a= [1;2;3];
b= [2;4;6];
cross(a,b) 

%%
%
% 

figure;

a= [1;0;0];     % this is the normal vector to the plane x= 0
b= [0;1;0];     % this is the normal vector to the plane y= 0
numerics.math.crossND(a,b)

% to this function we have to pass the normal vector, which is the
% constraint at the same time. A linear transformation which projects on
% the plane is a vector which is rectangular to a, thus b= [0, 1, 0] and c=
% [0, 0, 1]
plot3dLinConstraints(a', 0, [0, 0, 0], [1, 1, 1]);
hold on;
%plot3dLinConstraints(b', 0, [0, 0, 0], [1, 1, 1]);
%plot3dLinConstraints(c', 0, [0, 0, 0], [1, 1, 1]);
hold off;

daspect([1 1 1]);

%%

a= [0.5;0.25;0];     % this is the normal vector to the plane x= 0
b= [0;0;0.1];     % this is the normal vector to the plane y= 0
c= numerics.math.crossND(a,b);

% to this function we have to pass the normal vector, which is the
% constraint at the same time. A linear transformation which projects on
% the plane is a vector which is rectangular to a, thus b= [0, 1, 0] and c=
% [0, 0, 1]
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

%% 
% 

figure;

a= [1 0.5];

arrow([0, 0], a);
hold on;
arrow([0, 0], numerics.math.crossND(a));
hold off;

daspect([1 1 1]);

%%

figure;

c= [0.1642; -0.2507];

arrow([0, 0], c);
hold on;
arrow([0, 0], numerics.math.crossND(c));
hold off;
daspect([1 1 1]);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc det">
% matlab/det</a>
% </html>
% ,
% <html>
% <a href="matlab:doc cellfun">
% matlab/cellfun</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% <html>
% <a href="matlab:doc cross">
% matlab/cross</a>
% </html>
% ,
% <html>
% <a href="matlab:doc math">
% numerics.math</a>
% </html>
%
%% TODOs
% # check appearance of formulas in documentation
%
%% <<AuthorTag_DG/>>


