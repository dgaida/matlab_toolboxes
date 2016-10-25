
%%

clear
close all;

%%

system= 'ADode6';
%system= 'AM1';

%%

color_flag= 0;    % 0 for grayscale

%%

set= 0;

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
  end_x= 2;
  step_u= 4;
  end_u= numel(U); %1;
  start_std_dev= 1;
  end_std_dev= 1;%numel(std_devs);
end

%%

ns= 5;      % noise level 5 = 5 %, 1 = 1 %

%%

if color_flag
  colors= get_plot_colors(2, 1);
else
  % mache mehr als 2 farben, damit die hellste farbe nicht zu hell ist
  colors= get_plot_colors(3, 0);  
end

%%

for istd_dev= start_std_dev:end_std_dev

  %%
  
  for ix= 1:end_x
    
    %%
    
    for iu= 1:step_u:end_u
      
      %%

      %fak= 2;

      fig('width',14,'fontsize',10);%('Position', [45 100 560*fak 420*fak]);

      % wird eh nicht geplottet
      %title(sprintf('results hybrid EKF x%i u%i', ix, iu))

      %%

      load(sprintf('results_test_ekf_hybrid_simon_%s_std%i_x%i_u%i_ns%i.mat', ...
                     system, istd_dev, ix, iu, ns));

      %%

      for ivar= 1:size(xsim, 2)

        %%

        subplot(3,2,ivar);

        % gilt nur für ADode6, dort sampletime in h, muss auf days hier kommen
        if color_flag
          plot(tsim, xsim(:,ivar), colors{1}, ...
               0:sampletime/24:(toiteration - 1)*sampletime/24, xp(ivar,:), colors{2}, ...
               'LineStyle', '--');
        else
          plot(tsim, xsim(:,ivar), 'Color', colors(1,:));
          hold on;
          plot(0:sampletime/24:(toiteration - 1)*sampletime/24, xp(ivar,:), ...
            'Color', colors(2,:), 'LineStyle', '--');
          hold off;
        end
        
        %%

        if (ivar == 5 || ivar == 6)
          xlabel('$t$ [d]', 'Interpreter', 'latex');
        end
        
        switch(ivar)
          case 1
            ylabel('$S(t)$ [mg/l]', 'Interpreter', 'latex');
          case 2
            ylabel('$X_a(t)$ [mg/l]', 'Interpreter', 'latex');
          case 3
            ylabel('$V_a(t)$ [mg/l]', 'Interpreter', 'latex');
          case 4
            ylabel('$X_m(t)$ [mg/l]', 'Interpreter', 'latex');
          case 5
            ylabel('$C(t)$ [mg/l]', 'Interpreter', 'latex');
          case 6
            ylabel('$P_c(t)$ [atm]', 'Interpreter', 'latex');

        end

        %%

      end

      %%

      if color_flag
        export_fig(sprintf('results_test_ekf_hybrid_%s_std%i_x%i_u%i_ns%i', ...
                     system, istd_dev, ix, iu, ns), '-png', '-eps');
      else
        export_fig(sprintf('results_test_ekf_hybrid_%s_std%i_x%i_u%i_ns%i_bw', ...
                     system, istd_dev, ix, iu, ns), '-png', '-eps');
      end
      
      %%

      close all;

    end
    
  end
  
end

%%

fig('width',14,'fontsize',10);

%%

for istd_dev= start_std_dev:end_std_dev

  %%
  
  load(sprintf('results_test_ekf_hybrid_simon_%s_std%i_ns%i.mat', ...
               system, istd_dev, 0.05*100), 'err_mat');
  
  %%
  
  subplot(2,2,istd_dev);
  
  %%
  % do boxplot
  
  %c= get(0, 'DefaultFigureColor');
  %set(0, 'DefaultFigureColor', 'white');

  
  %figure
%   fak= 1;
%   figure1= figure('Position', [45 100 560*fak 420*fak], ...
%                   ...%'PaperSize',[20.98404194812 29.67743169791], ...
%                   ...'InvertHardcopy', 'on',...
%                   'Color',[1 1 1]);
%   axes1= axes('Parent', figure1, ...'LineWidth', 2, ...
%               ...'FontWeight', 'bold', ...
%               'FontSize', 10, 'FontName', 'Times New Roman');%, ...
%               %'Interpreter', 'none');

  s_meth= [];

  for icol= 1:numel(1:step_u:end_u)
    % creating labels
    s_1st= repmat(sprintf('u_%i', icol), end_x, 1 );
  
    % merging labels to one vector
    s_meth= [s_meth; s_1st];
  end          

  boxplot(...axes1, ...
    err_mat, s_meth);%, 'labels', {'u_1', 'u_2', 'u_3'});%, 'texmode', 'on');
  ylabel('$e_{\bf{\hat{x}}}$', 'FontSize', 10, 'FontName', 'Times New Roman', ...
         'Interpreter', 'latex');
  %set(gca, 'XTick', 1:3);
  %set(gca, 'XTickLabel', {'u_1', 'u_2', 'u_3'});
  
  if max(max(err_mat)) > 30
    ylim([0 ceil(max(max(err_mat))*1.05)]);
  end
  
  % %%
  
end

%%

export_fig(sprintf('results_test_ekf_hybrid_box_%s_ns%i', ...
                   system, ns), '-png', '-eps');
  
  %%

  %set(0, 'DefaultFigureColor', c);

  %%
  
%end

%%



%%


