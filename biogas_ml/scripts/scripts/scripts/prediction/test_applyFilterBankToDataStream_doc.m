
%%

init_filterbank_test_train;

%%
% sampling time: 1 h
if strcmp(system, 'AM1') % zeitkonstante des Modells ist Tag, s. Dilution rate
  sampletime= 1/24;             % sampling time of input measured in days
  num_days= 100;         % Anzahl Tage Simulation
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
% lade verschiedene Startzustände
%
if strcmp(system, 'AM1')
  X= load_file('X_rand_state.mat');
  
  h= @(x)calcAM1y(x, params);
  
  fsim= @AM1ode4;
else
  %X= [15 1928.452487 4.8077 994.0616 265.299 0.24199];
  % X= repmat([7.5, 1000, 1000, 1500, 280], 5, 1) + randn(5,5) * diag([4, 500, 500, 500, 10])
  % X= [X, X(:,5)/1.08e3]
  X= load_file('X_rand_state_ode6.mat');
  
  h= @(x, u)calcADode6y(x, u, params);
  
  fsim= @ADode6;
end
  
%%

X_train= load_file('X_training.mat');

mini= min(X_train)';
maxi= max(X_train)';

%%



%% 
% std. dev. of initial state estimate x0, measured in 100 %
% if strcmp(system, 'AM1')
%   std_devs= {0.1, 1, 10};       % 1 == 100 %, 10 = 1000 %
% else
%   std_devs= {0.001, 0.01, 0.1};       % 0.01 == 1 %, 1 = 100 %
% end

%%

if set == 0
  end_x= size(X, 1);
  step_u= 4;
  end_u= numel(U);
%   end_std_dev= numel(std_devs);
else
  end_x= 2;
  step_u= 4;
  end_u= 2;
%   end_std_dev= 1;
end

%%

%for istd_dev= 1:end_std_dev

  %%
  
  %std_dev= std_devs(istd_dev);

  Xt= [];
  YUt= [];

  %%
  
  err_mat= zeros(size(X, 1), numel(U)/(step_u - 1));%, numel(std_devs));

  %%

  for ix= 1:end_x

    x0= X(ix, :);

    %%

    for iu= 1:step_u:end_u

      u= U{iu};

      %%

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
      
      if nargin(h) == 1 % number of argument sfor function handle is constant
        % either 1 or 2
        y= feval(h, xsim);    % measurements
      else
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
      % measure runtime of estimator
      start_time= tic;
      
      %%
  
      % zurück geliefertes t ist dann auch in Tagen gemessen
      [YU, X, t]= applyFilterBankToDataStream(xsim, y, uused, tsim);
      
      %%
      % um test daten zu haben, wurde mal genutzt um in traingsdaten zu
      % stecken, ansonsten hier kein nutzen
      Xt= [Xt; X];
      YUt= [YUt; YU];
      
      %%

      err= zeros(1,size(xsim, 2));

      %%

      if (iu == 1 && ix == 1)
        doplots= 1;
        figure;
      end
      
      %%

      for ivar= 1:size(xsim, 2)

        %%
        
        rf_model= load_file(sprintf('rf_model_%i.mat', ivar));

        bins= rf_model.nclass;
        
        [xclass]= real2classvalues(X(:, ivar), bins, mini(ivar), maxi(ivar));

        Y_hat= classRF_predict(YU, rf_model);

        try
          [confMatrix]= calcConfusionMatrix(xclass, Y_hat);
        catch ME
          disp(ME.message);
          confMatrix= zeros(1,1);
        end
        
        %disp(confMatrix)

        y_real= mini(ivar) + (Y_hat + 0.5) * (maxi(ivar) - mini(ivar)) / bins;

        %%
        
        if (doplots)
          %% TODO - 3,2 ist abhängig von system, bei 4 ode nur 2,2
          subplot(3,2,ivar), plot(t, y_real, tsim, xsim(:,ivar));
        end
        
        %%
        
        save(sprintf('results_test_filter_bank_%s_x%i_u%i_var%i.mat', ...
             system, ix, iu, ivar), '-v7.3');
        
        %%
        % interpolieren, weil t nicht von anfang an vorhanden ist, wegen
        % vorlaufzeit von filter bank
        x_res= interp1(tsim, xsim(:,ivar), t, 'linear');

        err(ivar)= numerics.math.calcRMSE(x_res, y_real);

      end
      
      %%
      
      end_time= toc(start_time);
      
      fprintf('Average time of soft-sensor for one sample time is: %.3f s.\n', end_time/toiteration);
            
      %%

      err_mat(ix, ceil(iu/step_u))= mean(err);

    end

  end

  %%
  % make a boxplot of err_mat

  %% TODO

  % s_u01= repmat('u01', numel(err_mat(:,1)));
  % s_u02= repmat('u02', numel(err_mat(:,2)));
  % s_u03= repmat('u03', numel(err_mat(:,3)));
  % s_u04= repmat('u04', numel(err_mat(:,4)));
  % s_u05= repmat('u05', numel(err_mat(:,5)));
  % 
  % s_meth= [s_u01; s_u02; s_u03];

  %boxplot([err_mat(:,1); err_mat(:,2); err_mat(:,3)], s_meth);

  figure, boxplot(err_mat);%(:,:,istd));

  %%

  save(sprintf('results_test_filter_bank_%s.mat', system), 'err_mat');

  %%
  
% end

%%


