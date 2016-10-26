%% nonlcon_substrate
% Create nonlinear (in-)equality constraints on the substrates.
%
function [c, ceq, varargout]= nonlcon_substrate(u, plant, substrate, ...
                                popBiogas, varargin)
%% Release: 1.3

%%

error( nargchk(4, 6, nargin, 'struct') );
error( nargoutchk(0, 4, nargout, 'struct') );

%%
% read out varargin

if nargin >= 5 && ~isempty(varargin{1}), 
  TS_max= varargin{1}; 
else
  TS_max= 30; 
end

%%
%
% Raumbelastung $B_R \left[ \frac{kg}{d \cdot m^3} \right]$:
%
% Eine Raumbelastung von $B_R= 5 \left[ \frac{kg}{d \cdot m^3} \right]$
% bedeutet Hochlast, kleiner 2 -> Schwachlast. Normal ist 2 - 5.
%
if nargin >= 6 && ~isempty(varargin{2}), 
  OLR_max= varargin{2}; 
else
  OLR_max= 5; 
end


%%
% check parameters

validateattributes(u, {'double'}, {'2d'}, mfilename, 'individual',  1);

is_plant(plant, '2nd');
is_substrate(substrate, '3rd');
checkArgument(popBiogas, 'popBiogas', 'biogasM.optimization.popBiogas', 4);

%%

if ~isnumeric(TS_max)
  error('TS_max is not numeric, but %s!', class(TS_max));
end

if TS_max < 0 || TS_max > 100
  error('TS_max < 0 || TS_max > 100 : %.2f', TS_max);
end

if ~isnumeric(OLR_max)
  error('OLR_max is not numeric, but %s!', class(OLR_max));
end

if OLR_max < 0 || OLR_max > 10
  error('OLR_max < 0 || OLR_max > 10 : %.2f', OLR_max);
end


%% TODO
% Attention!!!! the last parameter should be plant_network, but as here
% only the substrate part of the individual matters and not the sludge
% part, it is ok here to pass plant_network_max instead. in line 92 you can
% see, that the sludge part of the individual is cut away
% evtl. sollte man gleich diese methode in zwei methoden unterteilen, so
% dass hier nur die erste methode welche sich um die substrate kümmert
% aufgerufen wird
[networkFlux]= getNetworkFluxFromIndividual(popBiogas, u, ...
                                            plant, substrate, ...
                                          popBiogas.pop_plant.plant_network_max);

lenGenomSubstrate= popBiogas.pop_substrate.lenGenom;

%%
%

n_fermenter= plant.getNumDigestersD();
n_substrate= substrate.getNumSubstratesD();


%%
%
% $$\vec{u} := \left(u_1, \dots, u_m \right)^T$$
%
% $$\left[ u_i \right] = \frac{m^3}{d}$$
%
u= networkFlux(:);
u= u(1:n_fermenter*n_substrate*lenGenomSubstrate, 1);


%%
% $$Q_{ges} := \sum_{i=1}^m u_i$$
%
Qges= sum(u);

%% TODO
% aktuell ist das hier der TS Gehalt des gesamten Substratmixes und nicht
% des mixes der feststoffe, d.h. ohne gülle. eigentlich sollte das hier der
% ts der substrate sein, welche durch den feststoffwolf gefüttert werden.
% evtl. macht gesamter TS auch sinn, keine ahnung
% Da TS im Fermenter berechnet wird, sollte es einen zweiten TS Parameter
% geben, welcher TS im fermenter begrenzt, s. nonlcon_digester
%

TS= zeros(1,size(u,1));

for isubstrate= 1:n_substrate

  substrate_name= char( substrate.getID(isubstrate) );

  TS(1,isubstrate + (0:1:n_fermenter - 1)*n_substrate*lenGenomSubstrate)= ...
               substrate.get_param_of(substrate_name, 'TS');
  
end


%%
% $$A:= \left[ \frac{TS_1}{Q_{ges}}, \dots, \frac{TS_m}{Q_{ges}}
% \right]$$ 
%
A= TS ./ Qges;


%%
%
% $$c(x) \leq 0$$
%
% $$A \cdot \vec{u} \leq TS_{max}$$
%
% ->
%
% $$A \cdot \vec{u} - TS_{max} \leq 0$$
%
c= A * u - TS_max;


%%
% Berechne Raumbelastung (volumetric loading)

OLR= zeros(1,n_fermenter);

for ifermenter= 1:n_fermenter

%   fermenter_id= char( plant.getDigesterID(ifermenter) );
% 
%   uf= u(1 + (ifermenter-1)*n_substrate:ifermenter*n_substrate, 1);


  %% TODO
  % calc OLR
  OLR(1,ifermenter)= 1;%...
      %calcOLR(uf, substrate, plant, fermenter_id);

end

%%
%
% $$c(x) \leq 0$$
%
% $$B_R \leq BR_{max}$$
%
% ->
%
% $$B_R - BR_{max} \leq 0$$
%
c= [c, OLR - OLR_max];


%% TODO
% Berechne hydraulische Verweilzeit (Hydraulic Retention Time)
%
%%
% Volume fluid phase [m^3]
%
%Vliq= plant.fermenter.(fermenter_id).Vliq;

%% References
%
% # Handreichung Biogasgewinnung und -nutzung: Grundlagen der anaeroben
% Fermentation, S. 29.
%
% $$HRT [d] := \frac{V_{liq} \left[ m^3 \right]}{q \left[ \frac{m^3}{d}
% \right]}$$ 
%
%calcHRT(u, Vliq);


%%
% no equality constraints yet
%
ceq= [];


%% 

if nargout >= 3

  %% TODO
  % im falle mehrerer constraints ist das hier nicht richtig, GC ist
  % ebenfalls von OLR abhängig, momentan allerdings eher nicht, da OLR
  % konstant ist
  
  GC= A';

  varargout{1}= GC;

end


%%

if nargout >= 4

  GCeq= [];

  varargout{2}= GCeq;

end
    
%%


