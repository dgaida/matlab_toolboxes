%% AM1ode4_discrete
% Discrete implementation of the anaerobic digestion model AM1 containing 4
% ODEs 
%
function [xkp1]= AM1ode4_discrete(tk, xk, uk, deltatk, p)
%% Release: 1.2

%%

error( nargchk(5, 5, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

isR(tk, 'tk', 1, '+');  % t_k
isRn(xk, 'xk', 2);%, '+'); % x(k)
isRn(uk, 'uk', 3);      % just u at the current iteration u(k)
isR(deltatk, 'deltatk', 4, '+');    % t_{k+1} - t_k
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
% state variables

% constraint on x, x must be positive
xk= max(xk, 0);

S1= xk(1);       % concentration of COD [g/l]
X1= xk(2);       % concentration of acidogenic biomass [g/l]
S2= xk(3);       % concentration of VFA [mmol/l]
X2= xk(4);       % concentration of methanogenic biomass [g/l]

%% 
% variables
%

[mu1, mu2]= AM1ode4_vars(xk, p);

%%
% $$
% S'(t)= D \cdot \left( S1_in(t) - S1(t) \right) - ...
% $$
%
% [d^-1 * ( g/l - g/l ) - g/g * g/l * d^-1] = g/l/d
%
S1kp1= deltatk * D * uk(1) + S1 * ( 1 - deltatk * D ) - k1 * deltatk * X1 * mu1;

%%
% $$
% 
% $$
%
% [( d^-1 - d^-1 ) * g/l] = g/l/d
%
X1kp1= ( 1 + deltatk * ( mu1 - D * alpha ) ) * X1;

%%
% $$
% 
% $$
%
% [d^-1 * ( mmol/l - mmol/l ) - mmol/g * d^-1 * g/l + mmol/g * d^-1 * g/l]
% = mmol/l/d
%
S2kp1= deltatk * D * uk(2) + S2 * ( 1 - deltatk * D ) - ...
       k3 * deltatk * mu2 * X2 + k2 * deltatk * mu1 * X1;

%%
% $$
% 
% $$
%
% [( d^-1 - d^-1 ) * g/l] = g/l/d
%
X2kp1= ( 1 + deltatk * ( mu2 - D * alpha ) ) * X2;

%%
% $$\vec{x}'(t)= \left( S1'(t), X1'(t), S2'(t), X2'(t) \right)^T$$
%
xkp1= [S1kp1; X1kp1; S2kp1; X2kp1];

%% constraint
%
% wenn x <= 0, dann setze xdot auf null, allerdings nur für die betreffende
% Zustandsvektorkomponente.
%
%xkp1= xkp1 - ( ( xk <= 0 ) & ( xkp1 < 0 ) ) .* xkp1; 

%%


