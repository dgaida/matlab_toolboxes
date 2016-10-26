
%%



%if(0)
  
  
  
  
init_filterbank_test_train;

%%
% sampling time: 1 h
if strcmp(system, 'AM1') % zeitkonstante des Modells ist Tag, s. Dilution rate
  sampletime= 1/24;             % sampling time of input measured in days
  num_days= 6000;         % Anzahl Tage Simulation [d]
else
  sampletime= 1;      % zeitkonstante des ADode6 ist gemessen in h
  % deshalb ist sampletime von 1 h einfach eine 1
  num_days= 6000 * 24;   % Anzahl Tage gemessen in Stunden
end

% toiteration is measured in h, total sim time is 100 days
% toiteration ist einheitenlos, gibt an wie viele iterationen im filter
% gemacht werden müssen um num_days mit einer sampletime durchzusimulieren
% ist für beide Modelle gleich groß
toiteration= num_days / sampletime;% 10

%%

if set == 0
  bins= 50;
  trees= 50;
else
  bins= 10;
  trees= 25;
end

%% TODO
% create dataset from different states and split u into pieces

%%
% lade verschiedene Startzustände
%
if strcmp(system, 'AM1')
  x= load_file('X_rand_state.mat');
  
  h= @(x)calcAM1y(x, params);
  
  fsim= @AM1ode4;
else
  %% TODO
  % höhere variabilität in zustandsvektor erzeugen
  % nicht randn sondern rand nutzen, oder besser latin hypercube sampling
  %X= [15 1928.452487 4.8077 994.0616 265.299 0.24199];
  % X= repmat([7.5, 1000, 1000, 1500, 280], 5, 1) + randn(5,5) * diag([4, 500, 500, 500, 10])
  % X= [X, X(:,5)/1.08e3]
  % 
  % new:
  % X= repmat([0, 0, 0, 0, 260], 10, 1) + rand(10,5) * diag([50, 2500, 3000, 3500, 50]);
  % X= [X, X(:,5)/1.08e3];
  %
  x= load_file('X_rand_state_ode6.mat');
  
  h= @(x, u)calcADode6y(x, u, params);
  
  fsim= @ADode6;
end

%%
% create u

[u, u_sample]= create_u_filterbank_train(system, toiteration);%, set);

%%

%toiteration= size(u,1);

%x0= [5 0.4 45.8 0.061];
%x0= [0.035 0.98 0.1 0.11];
% equilibrium for S1in= 2, S2in= 20
%x0= [2 0.001 15.9401 0.0076];
%x0= [4.29 0.275 15.6809 0.07522];

% S1_in_bound= [2.0, 10];
% S2_in_bound= [20.0, 75];
% 
% n_steps= 4000;
% 
% S1_in_rand= S1_in_bound(1) + diff(S1_in_bound) .* rand(n_steps, 1);
% S2_in_rand= S2_in_bound(1) + diff(S2_in_bound) .* rand(n_steps, 1);
% 
% timesteps= (toiteration - 1)/2 + (toiteration - 1) / 6 * randn(n_steps, 1);
% timesteps= sort(timesteps);
% 
% u= interp1(timesteps, S1_in_rand, 1:toiteration, 'spline')';
% u(:,2)= interp1(timesteps, S2_in_rand, 1:toiteration, 'spline')';
% 
% %u= [S1_in * ones(toiteration, 1), S2_in * ones(toiteration, 1)];
% %u= [S1_in + sort( 8 * rand(toiteration, 1) ), S2_in + sort( 55 * rand(toiteration, 1) )];
% 
% u(:,1)= max(min(u(:,1), S1_in_bound(2)), S1_in_bound(1));
% u(:,2)= max(min(u(:,2), S2_in_bound(2)), S2_in_bound(1));

X= [];
YU= [];

if set == 0
  end_x= size(x, 1);
else
  end_x= 2;
end

%%

if strcmp(system, 'AM1')
  plot_test_ekf_FilterBank_Us({u}, 1, 1, u_sample, sampletime, toiteration);
else
  % sampletime soll in tagen gemessen übergeben werden, also durch 24
  % teilen, adrstellung immer in Tagen unabhängig davon, dass sampletime
  % von diesem Modell in h gemessen wird
  plot_test_ekf_FilterBank_Us({u}, 1, 1, u_sample, sampletime/24, toiteration);
end

%%

ind_test_data= [];

%%

for ix= 1:end_x
  
  %%
  
  fprintf('Simulation %i of %i.\n', ix, end_x);
  
  %%
  
  x0= x(ix,:);

  %%
  %% TODO
  % da in applyFilterBankToDataStream auf h runter gerechnet wird, muss hier
  % auch mindestens in stunden daten aufgezeichnet werden, also 1/24
  % num_days und sampletime werden in grundeinheit (also Tage (4) oder h
  % (6)) gemessen, da sampling time 1 h sein soll, bedeutet das für
  % (4): simulation von 0 bis 6000 tage - 1 stunde, im Raster von 1 h 
  % (6): simulation von 0 bis 143999 Stunden das sind 6000 tage - 1 stunde,
  % im raster von 1 h. 
  % der sechste Parameter sampletime muss die Abtastrate des u's sein,
  % gemessen in der simulationszeit (= grundeinheit). hier wird einfach
  % jeder 60. wert genommen, damit abtastrate von u ebenfalls in h. gilt
  % nur für ADode6. 
  % tsim und xsim haben Raster von 1 h
  [tsim, xsim]= ode15s( fsim, [0:sampletime:(toiteration - 1)*sampletime], ...
                        x0, opt, u(1:1/u_sample:end,:), sampletime, params );

  %%
  % wenn sampletime= 1 (bedeutet 1 h), dann bedeutet 1 in tsim eine stunde,
  % allerdings muss es für filterbank unten 1 tag bedeuten, deshalb durch
  % 24 teilen. wenn sampletime= 1/24, dann bedeutet 1 in tsim 1 Tag, dann
  % nicht durch 24 teilen, kürzt sich weg mit sampletime
  tsim= tsim./24./sampletime;
  
  %%
  
  if size(xsim, 1) ~= size(u, 1)
    %disp('Not using this simulation.');
    %continue;
    % raster von 1 h
    uused= u(1:1/u_sample:1/u_sample * size(xsim, 1),:);
  else
    uused= u;
  end
  
  %%
  
  if nargin(h) == 1 % number of arguments for function handle is constant
    % either 1 or 2
    y= feval(h, xsim);    % measurements
  else
    % xsim und uused müssen gleiches raster haben, beide haben 1 h, ok
    [y, pH]= feval(h, xsim, uused); 
  end

  %%

  %%
  % input 

  uused= add_noise_to_u_filterbank(uused, rel_noise_in);

  %%
  % add noise to measurement data
  y= add_noise_to_y_ekf_filterbank(y, rel_noise_out, set);

  %%
  % tsim is assumed to be measured in days, muss allerdings in stunden
  % vorliegen, da in der funktion eine sample time von 1 h genutzt wird
  % alle anderen parameter xsim, y, uused müssen demnach stundenwerte sein
  [YU_temp, X_temp]= applyFilterBankToDataStream(xsim, y, uused, tsim);

  %%
  
  YU= [YU; YU_temp];
  X= [X; X_temp];

  %% TODO
  % diesen index kann man auch zufällig wählen, nicht nur am ende daten
  % nehmen
  
  start_idx= randi(size(YU, 1) - 2000, 1); % werfe eine zahl zwischen anzahl daten - 2000
  
  % testdaten sind immer ein paket von 2000 zusammenhängenden daten
  ind_test_data= [ind_test_data, ...
                  start_idx:start_idx + 2000];  % packe die daten in testdaten
  
  %%
  
end

%%


save('X_training.mat', 'X', '-v7.3');

save('YU_training.mat', 'YU', '-v7.3');

save('ind_test_data.mat', 'ind_test_data', '-v7.3');

%npoints= size(X, 1);

%Ntr= fix(npoints * 2/3);
%Nval= npoints - Ntr;

%%
%% TODO - evtl. entfernen

if (set == 0)

  %shutdown();   %% TODO - auf jeden Fall entfernen

  %return;

end

%%



%end % if(0) from the beginning of the script



clear;

%%

load('X_training.mat');
load('YU_training.mat');

%% TODO
% ind_test_data fehlt in meinem phd_data/04 Ordner, deshalb müsen alle
% experimente wiedehrolt werden, oder man lässt es so...
load('ind_test_data.mat');

%%

set= 0;

if set == 0
  bins= 50;
  trees= 50;
else
  bins= 10;
  trees= 25;
end

%%
%% TODO comment
% das sind die testdaten, welche ich auch in training daten stecke um zu
% schauen wie das bestmögliche ergebnis aussieht
% load('X_YU_validation_put_in_training_TODO.mat')
% X= [X; Xt];
% YU= [YU; YUt];

%%

ind_test= ind_test_data; % Ntr + 1:size(YU, 1)
ind_train= setxor(1:size(YU, 1), ind_test); % 1:Ntr;

%% TODO
% wird glaube ich nicht genutzt
k= 500000;

%% TODO
% wie sieht es mit einer 5-fold cross validation aus?

%%

mini= zeros(size(X, 2),1);
maxi= zeros(size(X, 2),1);

%%

for ivar= 1:size(X, 2)    % for each state variable

  %%
  % cluster state vector data in classes
  [xclass, mini(ivar), maxi(ivar)]= real2classvalues(X(:, ivar), bins);

  %%

  %% TODO comment
   %training_data= [xclass([1:10:1000000, 2812570:1:end], :), YU([1:10:1000000, 2812570:1:end], :)];
   %test_data= [xclass(2812570:1:end, :), YU(2812570:1:end, :)];
  
  %% TODO outcomment
  training_data= [xclass(ind_train, :), YU(ind_train, :)];
  test_data=     [xclass(ind_test, :) , YU(ind_test, :)];

  %%
  % do sampling
  
  %sample_idx= randsample(size(training_data, 1), k);
  
  %training_data= training_data(sample_idx, :);

  % take each 2nd value, because data comes out of simulation, this could
  % make more sense as a random sampling method
  
  %% TODO outcomment
  %training_data= training_data(1:2:end, :);
  
  %%
  
  % classification

  % call RF

   [rf_model, perf, perf_percent, perf_1st, confMatrix, confPMatrix]= ...
     startRF(training_data, test_data, 0, trees);
  
  % evaluate RF
  
  %%
  
  save(sprintf('rf_model_%i.mat', ivar), 'rf_model', '-v7.3');

  clear rf_model;
  
  %%
  
  disp('perf')
  disp(perf)
  
  disp('confMatrix')
  disp(confMatrix)

end

%%

%shutdown(60);

%%


