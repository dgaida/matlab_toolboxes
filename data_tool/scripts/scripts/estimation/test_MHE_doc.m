
%%

init_filterbank_test_train;

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
% lade verschiedene Startzustände
%
if strcmp(system, 'AM1')
  X= load_file('X_rand_state.mat');
else
  %X= [15 1928.452487 4.8077 994.0616 265.299 0.24199];
  % X= repmat([7.5, 1000, 1000, 1500, 280], 5, 1) + randn(5,5) * diag([4, 500, 500, 500, 10])
  % X= [X, X(:,5)/1.08e3]
  X= load_file('X_rand_state_ode6.mat');
end
  
%%

if strcmp(system, 'AM1')
  
  %% 
  % OK so
  % f muss auch noch sampletime als 4. parameter übergeben werden
  % allerdings währe die sample time von f abhängig vom aufruf von f, von
  % daher sample time evtl. als parameter der funktion definieren, so dass
  % diese im solveraufruf explizit an f übergeben werden muss
  f= @(t, x, u)AM1ode4(t, x, u, u_sample*sampletime, params);
  h= @(x)calcAM1y(x, params);

  fsim= @AM1ode4;
  
else
  
  f= @(t, x, u)ADode6(t, x, u, u_sample*sampletime, params);
  h= @(x, u)calcADode6y(x, u, params);
  
  fsim= @ADode6;
end


%% 
% std. dev. of initial state estimate x0, measured in 100 %
if strcmp(system, 'AM1')
  std_devs= {0.1, 1, 10};       % 1 == 100 %, 10 = 1000 %
else
  %std_devs= {0.001, 0.01, 0.1};       % 0.01 == 1 %, 1 = 100 %
  std_devs= {0.01, 0.05, 0.1};       % 0.01 == 1 %, 1 = 100 %
end

%%

if set == 0
  end_x= size(X, 1);
  step_u= 4;
  end_u= numel(U);
  start_std_dev= 1;
  end_std_dev= numel(std_devs);
else
  end_x= 1;
  step_u= 4;
  end_u= numel(U); %1;
  start_std_dev= 1;
  end_std_dev= numel(std_devs); %1;%
end

%%

load('results_test_ekf_hybrid_simon_x0hats.mat', 'x0hats');

%%

for istd_dev= start_std_dev:end_std_dev

  %%
  
  std_dev= std_devs{istd_dev};
  
  %%
  % for each standard deviation there is one error matrix and will be one
  % boxplot
  err_mat= zeros(size(X, 1), numel(U)/(step_u - 1));

  %%
  
  for ix= 1:end_x

    x0= X(ix, :);

    %% TODO
    % just to test
    %x0= [5 0.4 45.8 0.061];
    %x0= [0.035 0.98 0.1 0.11];
    % equilibrium for S1in= 2, S2in= 20
    %x0= [2 0.001 15.9401 0.0076];

    std_dev_x= x0 * std_dev;

    x0hat= x0 + std_dev_x .* randn(1,numel(x0));
    x0hat= max(0, x0hat);   % wichtig wenn std_dev > 1
    
    %%
    % load x0hat from file saved after runs of kalman filter, such that
    % both x0hats are the same:
    
    x0hat= x0hats(istd_dev, ix, :);
    x0hat= reshape(x0hat, 1, 6);

    %%

    for iu= 1:step_u:end_u

      u= U{iu};

      %% TODO
      % just for testing

      %u(:,1)= 3793 .* ones(2400/u_sample,1);
      %u(:,2)= 1077 .* ones(2400/u_sample,1);

      %%
      % übergebenes u muss im abstand der sampletime übergeben werden,
      % deshalb wird nur jeder 1/u_sample u Wert übergeben
      % hier wird nicht jedes u simuliert, sondern nur jedes 60., das ist
      % ok so
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
      % sampling time of measurements is 1 h
      if nargin(h) == 1 % number of arguments for function handle is constant
        % either 1 or 2
        y= feval(h, xsim);    % measurements
      else
        % wir machen hier die annahme, dass xsim und u das geliche
        % zeitraster haben, haben sie aber nicht, rate von u ist höher,
        % deshalb wieder jeden 60. wert nehmen
        [y, pH]= feval(h, xsim, uused);
      end

      %%
      % add noise to measurement data
      [y, std_dev_out]= add_noise_to_y_ekf_filterbank(y, rel_noise_out, set);
      
      %%
      
%       if set == 1 && exist('pH', 'var')
%         figure, plot(1:toiteration, pH);
%         ylabel('pH');
%       end
      
      %%

      %%
      % input 
      
%       usign1= numerics.math.calcRMSE(u(:,1), zeros(numel(u(:,1)),1));
%       usign2= numerics.math.calcRMSE(u(:,2), zeros(numel(u(:,2)),1));
%       
%       std_dev_in1= usign1 * rel_noise_in;    % input ebenfalls mit 5 % Genauigkeit
%       std_dev_in2= usign2 * rel_noise_in;    % input ebenfalls mit 5 % Genauigkeit
      
      %% TODO
      % auf u sollte rauschen überlagert werden, allerdings verlangsamt das
      % deutlich die simulationen, welche während der optimierung gemacht
      % werden. wird jetzt nur in MHE gemacht, vor der letzten simulation,
      % nicht für optimierungen
      
      %%
      
      shift_window= 24 * 1;    % measured in hours
      
      %%
      % measure runtime of estimator
      start_time= tic;
      
      %%
      % window= 31 d in h ausgedrückt
      xp= MHE(f, h, u, y, x0hat, 31 * 24, sampletime, u_sample, shift_window, rel_noise_in);
      
      %%
      
      end_time= toc(start_time);
      
      fprintf('Average time of MHE for one sample time is: %.3f s.\n', end_time/toiteration);
      
      %%
      
      err= zeros(1,size(xsim, 2));

      for ierr= 1:size(xsim, 2)
        
        %% 
        % damit ergebnisse mit filterbank vergleichbar werden, muss hier
        % daten resampled werden, da filterbank erst ab 31 d daten
        % vergleicht, sonst ist summe hier immer größer!
        % s. test_applyFilter...
        %
        % t definieren
        % 
        %% TODO - das ist aus test_applyFilterBank ... genommen, s. Z. 318
        % wenn sich dort was ändert, muss sich auch hier was ändern!
        %% TODO
        % warum wird eigentlich sampletime vorne und hinten abgezogen???
        if strcmp(system, 'AM1')
          t= (31 - sampletime:sampletime:toiteration*sampletime - sampletime)';
        else
          % sampletime wird hier ins stunden gemessen, muss aber in tagen
          % gemessen werden, deshalb noch mal durch 24 teilen
          t= (31 - sampletime/24:sampletime/24:toiteration*sampletime/24 - sampletime/24)';
        end
        
        x1= interp1(tsim, xsim(:,ierr), t, 'linear');
        
        raster= 0: ...31 - sampletime/24:
          shift_window/24:toiteration*sampletime/24;% - sampletime/24;
        %raster(end)= toiteration*sampletime/24;
        x2= interp1(raster, xp(:,ierr), t, 'linear');
        
        %% 
        % länge von xsim und xp mit filterbank vergleichen, länge sollte
        % gleich sein, wenn man bei tsim ab 31 d startet
        
        %err(ierr)= numerics.math.calcRMSE(xsim(:,ierr), xp(ierr,:));
        err(ierr)= numerics.math.calcRMSE(x1, x2);
      end

      %%
      
      err_mat(ix, ceil(iu/step_u))= mean(err);

      %%
      
      save(sprintf('results_test_mhe_%s_std%i_x%i_u%i_ns%i.mat', ...
                   system, istd_dev, ix, iu, rel_noise_in*100), '-v7.3');
      
      %%
      
    end

  end

  %%
  % make a boxplot of err_mat

  %% TODO

  % s_cmaes= repmat('CMAES', size(fit_cmaes(:)));
  % s_de= repmat('DE   ', size(fit_de(:)));
  % s_pso= repmat('PSO  ', size(fit_pso(:)));
  % 
  % s_meth= [s_cmaes; s_de; s_pso];
  % 
  % boxplot([fit_cmaes(:); fit_de(:); fit_pso(:)], s_meth);

  figure, boxplot(err_mat);

  %%

  save(sprintf('results_test_mhe_%s_std%i_ns%i.mat', ...
               system, istd_dev, rel_noise_in*100));

  %%
  
end

%%

shutdown(120);

%%


