%% ADode6
% AD model containing 6 ODE
%
function [xdot]= ADode6(t, x, u, deltatk, p)
%% Release: 1.7

%%

error( nargchk(5, 5, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

isR(t, 't', 1, '+');
isRn(x, 'x', 2);%, '+');
checkArgument(u, 'u', 'double', '3rd');
isR(deltatk, 'deltatk', 4, '+');
checkArgument(p, 'p', 'struct', 5);

%% 
% parameters
%
% $$y_{vf}^a$$
y_vf_a= p.y_vf_a; 
%%
% $$y_{co2}^a$$
y_co2_a= p.y_co2_a; 
%%
% $$y_{ch4}^m$$
y_ch4_m= p.y_ch4_m;
%%
% $$y_{co2}^m$$
y_co2_m= p.y_co2_m;
%%
% $$k_h$$
k_h= p.k_h; 
%%
% $$k_{la}$$
k_la= p.k_la;

%%
% Dilution rate: 
%
% $$D$$
D= p.D; 

%% 
% t ist 0 basiert, c_time ist 1 basiert, deshalb + 0.5
c_time= round(t/deltatk + 0.5);

%%
% constraint on x, x must be positive
x= max(x, 0);


%% 
% variables
%
% $$Y_{a}, D_{a}, Y_{m}, D_{m}, k_{g}, r_{g}, [H^+], H_{a}, f_{a}, f_{m}$$
[Y_a, D_a, Y_m, D_m, k_g, r_g, cH, H_a, f_a, f_m]= ADode6_vars(x, u(c_time, :), p);
    
% input of V_a
V_ai= 0;  
   
%%
% $$
% S'(t)= D \cdot \left( S_i(t) - S(t) \right) - f_a \left( S(t), S_i(t)
% \right) \cdot X_a(t) \cdot Y_a
% $$
%
Sdot= D * ( u(c_time, 1) - x(1) ) - f_a * x(2) * Y_a;

%%
% $$
% X_a'(t)= \left( f_a \left( S(t), S_i(t) \right) - D_a \right) \cdot X_a(t)
% $$
%
X_adot= ( f_a - D_a ) * x(2);

%%
% $$
% V_a'(t)= D \cdot \left( V_{a,i}(t) - V_a(t) \right) + f_a \left( S(t), S_i(t)
% \right) \cdot X_a(t) \cdot y_{vf}^a - f_m \left( V_a(t) \right) \cdot
% X_m(t) \cdot Y_m
% $$
%
V_adot= D * V_ai - D * x(3) + f_a * x(2) * y_vf_a - f_m * x(4) * Y_m;

%%
% $$
% X_m'(t)= \left( f_m \left( V_a(t) \right) - D_m \right) \cdot X_m(t)
% $$
%
X_mdot= ( f_m - D_m ) * x(4);

%%
% $$
% C'(t)= -D \cdot C(t) + f_a \left( S(t), S_i(t)
% \right) \cdot X_a(t) \cdot y_{co2}^a + f_m \left( V_a(t) \right) \cdot
% X_m(t) \cdot y_{co2}^m - k_{la} \cdot \left( C(t) - k_h \cdot P_c(t) \right)
% $$
%
Cdot= -D * x(5) + f_a * x(2) * y_co2_a + f_m * x(4) * y_co2_m - k_la * ( x(5) - k_h * x(6) );

%%
% $$
% P_c'(t)= k_g \left[ k_{la} \left( 1 - P_c(t) \right) \cdot \left( C(t) -
% k_h \cdot P_c(t) \right) - r_g \cdot P_c(t) \cdot
% f_m \left( V_a(t) \right) \cdot X_m(t) \cdot y_{ch4}^m \right]
% $$
%
P_cdot= k_g * ( k_la * ( 1 - x(6) ) * ( x(5) - k_h * x(6) ) - r_g * x(6) * f_m * x(4) * y_ch4_m );

%%
% $$\vec{x}'(t)= \left( S'(t), X_a'(t), V_a'(t), X_m'(t), C'(t), P_c'(t) \right)^T$$
%
xdot= [Sdot; X_adot; V_adot; X_mdot; Cdot; P_cdot];

%% 
% constraint
%
% wenn x == 0, dann setze xdot auf null, allerdings nur für die betreffende
% Zustandsvektorkomponente.
%
xdot= xdot - ( ( x <= 0 ) & ( xdot < 0 ) ) .* xdot; 

%%


