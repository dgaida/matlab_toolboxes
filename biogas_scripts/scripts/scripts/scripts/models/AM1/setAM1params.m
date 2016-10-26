%% setAM1params
% Set default parameter values of AM1 model
% 
function [params]= setAM1params(D)
%% Release: 1.8

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

isR(D, 'D', 1, '+');

%%
% Maximum growth rate of acidogenic bacteria [d^-1], in ref. 3: \mu_max
params.mu1max= 1.2;

%%
% half-saturation constant for the acidogenesis [g/l]
params.KS1= 7.1;

%%
% Maximum growth rate of methanogenic bacteria [d^-1], in ref. 3: \mu_0
params.mu2max= 0.74;

%%
% half-saturation constant for the methanogenesis [mmol/l] 
params.KS2= 9.28;

%%
% Methanogenic bacteria inhibition concentration [mmol/l]^(1/2)
params.KI2= 16; % in ref. 3: K_I

%%
% yield coefficient for substrate degradation [g/g]
params.k1= 10.53;   % in ref. 1, table 5, page 22: 42.14 g/g

%%
% Yield coefficient for VFA production [mmol/g]
params.k2= 28.6;    % in ref. 1, table 5, page 22: 116.5 mmol/g

%%
% Yield coefficient for VFA consumption [mmol/g]
params.k3= 1074;    % in ref. 1, table 5, page 22: 268 mmol/g

%%
% Yield coefficient for methane production [mmol/g]
params.k4= 453;   % ref. 1, table 5, page 22

%%
% fraction of the biomass which is not retained in the digester
params.alpha= 0.5;

%%
% dilution rate [d^-1]
params.D= D;

%% TODO
% not used at the moment
%
% Liquid phase volume [l]
params.V= 30; % Quelle finde ich gerade nicht

%%


