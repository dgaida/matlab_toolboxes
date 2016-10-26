%% calcADM1LinearizedDeriv
% Calculate x'(t) of the linearized ADM1 model.
%
function [c, c_prime, y, Psi_r]= calcADM1Measurements(x, ...
                                            fermenter_id, plant)
%% Release: 0.6

%%
% read out varargin



%%
% check input parameters

if ~isa(x, 'double') || numel(x) ~= 37
    error('The 2nd parameter x is not a 37-dim double vector!');
else
    x= x(:);
end

if ~ischar(fermenter_id)
    error('The 4th parameter fermenter_id is not of type char!');
end

if ~isa(plant, 'biogas.plant')
    error('The 5th parameter plant is not of type struct!'); 
end


%%
% Volume fluid phase [m^3]
%
Vliq= plant.fermenter.(fermenter_id).Vliq;

%%
% T [°C]
%
T_deg= plant.fermenter.(fermenter_id).T;

%%
%

%%
% Kw - [-]    
%
% Berechnung: exp ( 55900 / ( R * 100) * ( 1 / T_base - 1 / T_op ) ) * 10^{-14}
% T_base= 298.15 K
% R= 0.083145
% T_op= T + 273.15;
% bei 40 °C stimmt der Wert offensichtlich nicht genau, genau wäre 2.94 *
% 10^-14
%

Kw= 2.08e-14;             


%%

[c, c_prime, y, Psi_r]= getADM1Measurements(x, Vliq, T_deg, Kw);

%%


