%% Syntax
%       plot_test_ekf_FilterBank_Us(U, step_u, end_u, u_sample, sampletime,
%       toiteration) 
%
%% Description
% |plot_test_ekf_FilterBank_Us(U, step_u, end_u, u_sample, sampletime,
% toiteration)| plots input data for state estimation experiments. 
%
%%
% @param |U| : 
%
%% Example
%
%

%%

system= 'ADode6';
set= 1;

%%
% sampling time: 1 h
if strcmp(system, 'AM1') % zeitkonstante des Modells ist Tag, s. Dilution rate
  sampletime= 1/24;             % sampling time of input measured in days
  num_days= 100;         % Anzahl Tage Simulation [d]
else
  sampletime= 1;      % zeitkonstante des ADode6 ist gemessen in h
  % deshalb ist sampletime von 1 h einfach eine 1
  num_days= 100 * 24;   % Anzahl Tage gemessen in Stunden
end

% toiteration is measured in h, total sim time is 100 days
% toiteration ist einheitenlos, gibt an wie viele iterationen im filter
% gemacht werden müssen um num_days mit einer sampletime durchzusimulieren
% ist für beide Modelle gleich groß
toiteration= num_days / sampletime;% 10

%%
% create U for system

[U, u_sample]= create_U_ekf_and_filterbank(system);

%%

if set == 0
  step_u= 4;
  end_u= numel(U);
else
  step_u= 4;
  end_u= numel(U); %1;
end

%%

color_flag= 1;   % if 0, then plot grayscale

%%

if strcmp(system, 'AM1')
  plot_test_ekf_FilterBank_Us(U, step_u, end_u, u_sample, sampletime, toiteration, color_flag);
else
  % sampletime soll in tagen gemessen übergeben werden, also durch 24
  % teilen, adrstellung immer in Tagen unabhängig davon, dass sampletime
  % von diesem Modell in h gemessen wird
  plot_test_ekf_FilterBank_Us(U, step_u, end_u, u_sample, sampletime/24, toiteration, color_flag);
end

%%

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc data_tool/export_fig">
% data_tool/export_fig</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isn">
% script_collection/isN</a>
% </html>
% 
% and is called by:
%
% (the user)
%
%% See Also
% 
% <html>
% <a href="matlab:doc('ekf_hybrid_simon')">
% ekf_hybrid_simon</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('ekf_discrete_simon')">
% ekf_discrete_simon</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('ekf_cont_simon')">
% ekf_cont_simon</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('kalman_discrete_simon')">
% kalman_discrete_simon</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('mhe')">
% MHE</a>
% </html>
%
%% TODOs
% # improve documentation
% # improve code documentation
%
%% <<AuthorTag_DG/>>


