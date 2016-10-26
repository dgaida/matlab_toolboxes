%% ADode6_vars
% Calculates variables of ADode6 model for a particular state and input
%
function [Y_a, D_a, Y_m, D_m, k_g, r_g, cH, H_a, f_a, f_m]= ADode6_vars(x, u, p)
%% Release: 1.6

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 10, nargout, 'struct') );

%%

isRn(x, 'x', 1);
isRn(u, 'u', 2);
checkArgument(p, 'p', 'struct', '3rd');

%% 
% parameters
%
% $$\mu_{max}^a$$
mu_max_a= p.mu_max_a; 

k_sa= p.k_sa; 
k_da= p.k_da; 
mu_max_m= p.mu_max_m; 
k_sm= p.k_sm; 
k_im= p.k_im; 
k_dm= p.k_dm; 
y_s_a= p.y_s_a; 
y_vf_a= p.y_vf_a; 
y_co2_a= p.y_co2_a; 
y_s_m= p.y_s_m; 
y_ch4_m= p.y_ch4_m; 
y_co2_m= p.y_co2_m; 
k_w= p.k_w; 
k_co2= p.k_co2; 
k_h= p.k_h; 
k_a= p.k_a; 
S_v= p.S_v; 
C_co2= p.C_co2;
C_ch4= p.C_ch4; 
delta= p.delta; 
D= p.D;
V= p.V; 
V_g= p.V_g; 


%% variables
%
% equations on page 394 of the reference paper
%
% $$Y_a := y_{vf}^a + y_{co2}^a + \frac{1}{y_s^a}$$
%
Y_a= y_vf_a + y_co2_a + 1 / y_s_a;

%%
% $$D_a := \delta \cdot D + k_{da}$$
%
D_a= delta * D + k_da;

%%
% $$Y_m := y_{ch4}^m + y_{co2}^m + \frac{1}{y_s^m}$$
%
Y_m= y_ch4_m + y_co2_m + 1 / y_s_m;

%%
% $$D_m := \delta \cdot D + k_{dm}$$
%
D_m= delta * D + k_dm;

%%
% $$k_g := \frac{ S_v \cdot V }{ C_{co2} \cdot V_g }$$
%
k_g= S_v * V / ( C_co2 * V_g );

%%
% $$r_g := \frac { C_{co2} }{ C_{ch4} }$$
%
r_g= C_co2 / C_ch4;

%%
% eq. 2.13 [mg/l] Cation ions concentration
%
% $$
% \left( \left[ H^+(t) \right] \right)^3 + \left( k_a + B_{ic}(t) \right)
% \cdot \left(
% \left[ H^+(t) \right] \right)^2 - \left[ 
% k_a \cdot \left( V_a(t) - B_{ic}(t) \right) + k_w + k_h \cdot k_{co2}
% \cdot P_c(t)
% \right] \cdot \left[ H^+(t) \right] = 
% k_a \cdot \left( k_w + k_h \cdot k_{co2} \cdot P_c(t) \right)
% $$
%
cH= max( roots( [1, k_a + u(2), ...
                - ( k_a * ( x(3) - u(2) ) + k_w + k_h * k_co2 * x(6) ) , ...
                  - k_a * ( k_w + k_h * k_co2 * x(6) ) ] ) );

%%
% eq. 2.12 [mg/l] Undissociated fraction of Va
%
% $$H_a(t)= \frac{ V_a(t) \cdot \left[ H^+ \right] }{ k_a + \left[ H^+ \right]
% }$$
%
H_a= x(3) * cH / ( k_a + cH );

%%
% eq. 2.10
%
% $$f_a \left( S(t), S_i(t) \right) = \frac{ \mu_{max}^a \cdot S(t) }{ k_{sa}
% + S(t) } \cdot \frac{ k_{sa} + S_i(t) }{ S_i(t) }$$
%
f_a= mu_max_a * x(1) / ( k_sa + x(1) ) * ( k_sa + u(1) ) / u(1);

%%
% eq. 2.11
%
% $$f_m \left(  V_a(t) \right) = \frac{ \mu_{max}^m \cdot H_a(t) }{ H_a(t)
% + k_{sm} + \frac{H_a(t)^2}{k_{im}} }$$
%
f_m= mu_max_m * H_a / ( H_a + k_sm + H_a^2 / k_im );
     
%%


