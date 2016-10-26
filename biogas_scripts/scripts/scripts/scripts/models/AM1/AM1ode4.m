%% AM1ode4
% Implementation of the anaerobic digestion model AM1 containing 4 ODEs
%
function [xdot]= AM1ode4(t, x, u, deltatk, p)
%% Release: 1.6

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

k1= p.k1;           
k2= p.k2;
k3= p.k3;
alpha= p.alpha;

%%
% Dilution rate: 
D= p.D; 

%% 

c_time= round(t/deltatk + 0.5);

%%
% state variables

% constraint on x, x must be positive
x= max(x, 0);

% units, symbols and equations are as in ref. 3: Rincon et al. 
S1= x(1);       % concentration of COD [g/l]
X1= x(2);       % concentration of acidogenic biomass [g/l]
S2= x(3);       % concentration of VFA [mmol/l]
X2= x(4);       % concentration of methanogenic biomass [g/l]

%% 
% variables
%

[mu1, mu2]= AM1ode4_vars(x, p);

%%
% $$
% S'(t)= D \cdot \left( S1_in(t) - S1(t) \right) - ...
% $$
%
% [d^-1 * ( g/l - g/l ) - g/g * g/l * d^-1] = g/l/d
%
S1dot= D * ( u(c_time, 1) - S1 ) - k1 * X1 * mu1;

%%
% $$
% 
% $$
%
% [( d^-1 - d^-1 ) * g/l] = g/l/d
%
X1dot= ( mu1 - D * alpha ) * X1;

%%
% $$
% 
% $$
%
% [d^-1 * ( mmol/l - mmol/l ) - mmol/g * d^-1 * g/l + mmol/g * d^-1 * g/l]
% = mmol/l/d
%
S2dot= D * ( u(c_time, 2) - S2 ) - k3 * mu2 * X2 + k2 * mu1 * X1;

%%
% $$
% 
% $$
%
% [( d^-1 - d^-1 ) * g/l] = g/l/d
%
X2dot= ( mu2 - D * alpha ) * X2;

%%
% $$\vec{x}'(t)= \left( S1'(t), X1'(t), S2'(t), X2'(t) \right)^T$$
%
xdot= [S1dot; X1dot; S2dot; X2dot];

%% 
% constraint
%
% wenn x <= 0, dann setze xdot auf null, allerdings nur für die betreffende
% Zustandsvektorkomponente.
%
xdot= xdot - ( ( x <= 0 ) & ( xdot < 0 ) ) .* xdot; 

%%


