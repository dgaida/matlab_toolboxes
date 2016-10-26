%% 
% inits the scripts train_applyFilterBankToDataStream_doc,
% test_applyFilterBankToDataStream_doc and test_ekf_hybrid_simon_doc out of
% data_tool
%

%%
% Zustand
% 1)  5 - 35
% 2)  1600 - 3000
% 3)  0 - 100
% 4)  1600 - 1800
% 5)  220 - 340
% 6)  0.2 - 0.3
%
% In:
% 1)  1.5 - 11
% 2)  20 - 72
%

close all;
clear;

%%

global PUBLISH_FLAG;

%%

if isempty(PUBLISH_FLAG)
  %%
  % 0 is complete
  % 1 is fast
  %% TODO - back to 1
  set= 1; % 0
else
  return;
end

%%

disp(PUBLISH_FLAG)

%% TODO - outcomment
error('Ignored PUBLISH_FLAG during publication');

%% Achtung!
% Zeitkonstante von ADode6 Modell ist in Stunden nicht in Tagen!!!

system= 'ADode6';
%system= 'AM1';

%% 
% Referenzen in diesem Skript beziehen sich auf biogas_scripts Toolbox

% in Rincon et al. sind PLots von S1 und S2, Wertebereich für S1= 1 bis 6
% g/l und für S2= 5 bis 35 mmol/l sind OK

% müsste man auch mal variieren: Bernard et al. (ref. 1, S. 7) im Bereich
% von: 0.1 bis 1.1 d^-1 ist in ordnung, 0.9 ist damit recht hoch, in ref. 3
% Rincon et al. wurde allerdings mit ähnlich hohem D gefahren
D= 0.90;          % 1/day           % 

%%

if strcmp(system, 'AM1')
  fpar= @()setAM1params(D);
  
  % 5 % entsprechen
  % SNRdB= 26 dB =  log10(100/5)*20
  rel_noise_in= 5/100;      % noise of input in 100 %
  rel_noise_out= 5/100;     % noise of output in 100 %
else
  fpar= @()setADode6params(D);
  
  %% TODO
  % auch mal fehler auf 5 % setzen
  % 1 % entsprechen einem SNR von 40 dB
  % s. http://en.wikipedia.org/wiki/Signal-to-noise_ratio
  % SNR= (Asignal/Anoise)^2
  % SNRdB= 20 log_10(Asignal/Anoise)
  % A is the amplitude of the signal root mean square
  % hängt aber auch von kalman filter ab, was da steht
  rel_noise_in= 5/100;%1/100;      % noise of input in 100 %
  rel_noise_out= 5/100; %1/100;     % noise of output in 100 %
end

%%
% get params
params= feval(fpar); 

%%

opt= odeset('RelTol', 1e-4, 'AbsTol', 1e-6);

%%


