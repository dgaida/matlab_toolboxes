%% Syntax
%       [YU, X]= applyFilterBankToDataStream(x, y, u, t)
%       applyFilterBankToDataStream(x, y, u, t, sample_time)
%       applyFilterBankToDataStream(x, y, u, t, sample_time,
%       filter_num_out) 
%       applyFilterBankToDataStream(x, y, u, t, sample_time,
%       filter_num_out, filter_num_in) 
%       [YU, X, t]= applyFilterBankToDataStream(...) 
%       
%% Description
% |[YU, X]= applyFilterBankToDataStream(x, y, u, t)| 
%
%%
% @param |x| : stream of state vector data. The first dimension defines the
% number of observations, the 2nd dimension the number of states. 
%
%%
% @param |y| : stream of output measurements. The first dimension defines
% the number of observations, the 2nd dimension the number of measurement
% values. 
%
%%
% @param |u| : stream of input measurements. The first dimension defines
% the number of observations, the 2nd dimension the number of inputs. 
%
%%
% @param |t| : time vector measured in days. Must have same number of
% elements as |x|, |y| respectively |u| have rows. 
%
%%
% @return |YU| : 
%
%%
% @return |X| : |x| resampled using |sample_time|. 
%
%%
% @param |sample_time| : sample time in hours. double scalar. The data in
% |x|, |y| and |u| is resampled using this value and returned in |X| and
% |Y|. 
%
%%
% @param |filter_num_out| : moving average filters for the output
% measurements, the values in the array are given in hours
%
%%
% @param |filter_num_in| : moving average filters for the input
% measurements, the values in the array are given in hours
%
%%
% @return |t| : resampled (equidistant) time vector using |sample_time|
%
%% Example
%
%

clear;
close all;

%%

set= 1; % 0

if set == 0
  bins= 25;
  trees= 40;
else
  bins= 5;
  trees= 10;
end


%%

D= 0.90;

[params]= setAM1params(D);

%% TODO
% create dataset from different states and split u into pieces

x= load_file('X_rand_state.mat');
u= load_file('u_rand_signal_train.mat');

sampletime= 1/24;             % days

if set ~= 0
  u= u(1:7200,:);
end

toiteration= size(u,1);

%x0= [5 0.4 45.8 0.061];
%x0= [0.035 0.98 0.1 0.11];
% equilibrium for S1in= 2, S2in= 20
%x0= [2 0.001 15.9401 0.0076];
x0= [4.29 0.275 15.6809 0.07522];

opt= odeset('RelTol', 1e-4, 'AbsTol', 1e-6);%,'OutputFcn',@debugode);

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

for ix= 1:end_x
  
  x0= x(ix,:);

  %%
  %% TODO
  % da in applyFilterBankToDataStream auf h runter gerechnet wird, muss hier
  % auch mindestens in stunden daten aufgezeichnet werden, also 1/24

  [tsim, xsim]= ode15s( @AM1ode4, [0:sampletime:(toiteration - 1)*sampletime], ...
                        x0, opt, u, sampletime, params );

  y= calcAM1y(xsim, params);

  %%

  std_dev_in_out= 0.1;

  u= u + std_dev_in_out .* randn(toiteration, size(u, 2));

  %% TODO
  % definition der std. abweichung über das SNR verhältnis
  % SNRdB= 20 * log10 (Asignal / Anoise)
  % dabei sind A die RMS Amplituden der Signale
  % Anoise= Asignal / 10^(SNRdB/20)

  Asignal= numerics.math.calcRMSE(y, zeros(numel(y),1));
  SNRdB= 40;    % macht der Wert Sinn?

  Anoise= Asignal / (10^(SNRdB/20));

  std_dev_in_out= Anoise;

  %%

  y= y + std_dev_in_out .* randn(toiteration, 1);
  y= max(y, 0);

  %%

  [YU_temp, X_temp]= applyFilterBankToDataStream(xsim, y, u, tsim);

  %%
  
  YU= [YU; YU_temp];
  X= [X; X_temp];

end

%%

npoints= size(X, 1);

Ntr= fix(npoints * 2/3);
Nval= npoints - Ntr;

%%

mini= zeros(4,1);
maxi= zeros(4,1);

for ivar= 1:4

  [xclass, mini(ivar), maxi(ivar)]= real2classvalues(X(:, ivar), bins);

  %%

  training_data= [xclass(1:Ntr, :), YU(1:Ntr, :)];
  test_data=     [xclass(Ntr + 1:end, :), YU(Ntr + 1:end, :)];

  % classification

  % call RF

   [rf_model(ivar), perf, perf_percent, perf_1st, confMatrix, confPMatrix]= ...
     startRF(training_data, test_data, 0, trees);
  
  % evaluate RF
  
  disp('perf')
  disp(perf)

end

save('rf_models.mat', 'rf_model', '-v7.3');

save('X_training.mat', 'X', '-v7.3');

save('YU_training.mat', 'YU', '-v7.3');

%%
% evaluate filter

if(0)
  
S1_in= 2.0;
S2_in= 20.0;

toiteration= 500;%7500;

u= [S1_in + sort( 8 * rand(toiteration, 1) ), S2_in + sort( 55 * rand(toiteration, 1) )];

[tsim2, xsim2]= ode15s( @AM1ode4, [0:1:toiteration - 1], x0, opt, u, params );

Q_ch4_2= calcAM1y(xsim2, params);
y= Q_ch4_2;

u= u + std_dev_in_out .* randn(toiteration, size(u, 2));

y= y + std_dev_in_out .* randn(toiteration, 1);

%%

[YU, X, t]= applyFilterBankToDataStream(xsim2, y, u, tsim2);

%%

err= zeros(1,4);

for ivar= 1:4

  [xclass]= real2classvalues(X(:, ivar), bins, mini(ivar), maxi(ivar));

  Y_hat= classRF_predict(YU, rf_model(ivar));

  [confMatrix]= calcConfusionMatrix(xclass, Y_hat);
  
  %disp(confMatrix)
  
  y_real= mini(ivar) + (Y_hat + 0.5) * (maxi(ivar) - mini(ivar)) / bins;
  
  figure, plot(t, y_real, tsim2, xsim2(:,ivar));
  
  %%
  
  x_res= interp1(tsim2, xsim2(:,ivar), t, 'linear');
  
  err(ivar)= numerics.math.calcRMSE(x_res, y_real);
  
end

mean(err)

%%

end

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/interp1">
% matlab/interp1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/filter">
% matlab/filter</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_ml/createdatasetforpredictor')">
% biogas_ml/createDataSetForPredictor</a>
% </html>
%
%% TODOs
% # improve documentation a bit
% # check/improve example
%
%% <<AuthorTag_DG/>>


