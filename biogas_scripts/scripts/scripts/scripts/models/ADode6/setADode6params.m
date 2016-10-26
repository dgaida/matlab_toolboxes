%% setADode6params
% Set the params of the ADode6 model to default values
%
function [params]= setADode6params(D)
%% Release: 1.8

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

isR(D, 'D', 1, '+');    % D is given in d^-1

%%
% $$\mu_{max}^a$$
%
% Maximum growth rate of acidogenic bacteria [h^-1]
params.mu_max_a= 0.5033;

%%
% $$k_{sa}$$
%
% [mg/l] Acidogenic bacteria half-velocity
params.k_sa= 238.1;

%%
% $$k_{da}$$
%
% [h^-1] Acidogenic bacteria decay rate
params.k_da= 3.1*10^-2;

%%
% $$\mu_{max}^m$$
%
% [h^-1] Maximum growth rate of methanogenic bacteria
params.mu_max_m= 2.27*10^-3;

%%
% $$k_{sm}$$
%
% [mg/l] Methanogenic bacteria half-velocity
params.k_sm= 1.45*10^-2;

%%
% $$k_{im}$$
%
% [mg/l] Methanogenic bacteria inhibition concentration
params.k_im= 35.47;

%%
% $$k_{dm}$$
%
% [h^-1] Methanogenic bacteria decay rate
params.k_dm= 8*10^-4;

%%
% $$y_{s}^a$$
%
% Yield coefficient (substrate to acidogenic bacteria)
params.y_s_a= 0.688;

%%
% $$y_{vf}^a$$
%
% Yield coefficient (substrate to acetic acid)
params.y_vf_a= 0.6427;

%%
% $$y_{co2}^a$$
%
% Yield coefficient (substrate to CO2)
params.y_co2_a= 0.5;

%%
% $$y_{s}^m$$
%
% Yield coefficient (acetic acid to methanogenic bacteria)
params.y_s_m= 3.27;

%%
% $$y_{ch4}^m$$
%
% Yield coefficient (acetic acid to CH4)
params.y_ch4_m= 20.732;

%%
% $$y_{co2}^m$$
%
% Yield coefficient (acetic acid to CO2)
params.y_co2_m= 5.174;

%%
% $$k_w$$
%
% Water dissociation constant
params.k_w= 10^-14;

%%
% $$k_{co2}$$
%
% Carbonic acid dissociation constant
params.k_co2= 4.5*10^-7;

%%
% $$k_h$$
%
% Henry’s law constant
params.k_h= 1.08*10^3;

%%
% $$k_a$$
%
% Weak acid dissociation constant
params.k_a= 1.85*10^-5;

%%
% $$k_{la}$$
%
% CO2 mass transfer rate coefficient
params.k_la= 6.832;

%%
% $$S_v$$
%
% Avogadro’s constant
params.S_v= 22.4;

%%
% $$C_{co2}$$
%
% mole to [mg/l] conv const for CO2
params.C_co2= 4.4*10^4;

%%
% $$C_{ch4}$$
%
% mole to [mg/l] conv const for Ch4
params.C_ch4= 1.6*10^4;

%%
% $$\delta$$
%
% Liquid/solid dilution rate ratio
params.delta= 0.01667;

%%
% $$D$$
% D is given in d^-1
% [h^-1] Dilution rate
params.D= D / 24; %0.042;

%%
% $$V$$
%
% [l] Liquid phase volume
params.V= 30;

%%
% $$V_g$$
%
% [l] Gas phase volume
params.V_g= 5;

%%
% $$P_t$$
%
% [atm] Total pressure in the gas phase
params.P_t= 1;



% $$params := \left(  
% \mu_{max}^a, k_{sa}, k_{da}, \mu_{max}^m, k_{sm}, k_{im}, k_{dm}, y_s^a,
% y_{vf}^a, y_{co2}^a, y_s^m, y_{ch4}^m, y_{co2}^m, k_w, k_{co2}, k_h, k_a,
% k_{la}, S_v, C_{co2}, C_{ch4}, \delta, D, V, V_g, P_t
% \right)$$
%
%params= [mu_max_a; k_sa; k_da; mu_max_m; k_sm; k_im; k_dm; y_s_a; y_vf_a; ...
%         y_co2_a; y_s_m; y_ch4_m; y_co2_m; k_w; k_co2; k_h; k_a; k_la; ...
%         S_v; C_co2; C_ch4; delta; D; V; V_g; P_t];
     
     
     