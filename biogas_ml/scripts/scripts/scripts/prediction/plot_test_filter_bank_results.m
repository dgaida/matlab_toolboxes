
%%

clear
close all;

%%

global PUBLISH_FLAG;

%%

if PUBLISH_FLAG == 1
  return;
end

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

if set == 0
  end_x= size(X, 1);
  step_u= 4;
  end_u= numel(U);
else
  end_x= 2;
  step_u= 4;
  end_u= numel(U); %1;
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

%ix= 2;%3
%iu= 1;

%%
  
for ix= 1:end_x

  %%

  for iu= 1:step_u:end_u

    %%

    fig('width',14,'fontsize',10);%('Position', [45 100 560*fak 420*fak]);

    %title(sprintf('results filterbank x%i u%i', ix, iu))

    %%

    load(sprintf('results_test_filter_bank_%s_x%i_u%i_var%i.mat', ...
                   system, ix, iu, 1), 'xsim');

    %%

    for ivar= 1:size(xsim, 2)

      %%

      load(sprintf('results_test_filter_bank_%s_x%i_u%i_var%i.mat', ...
                   system, ix, iu, ivar), 'xsim', 'tsim', 't', 'y_real');

      %%

      subplot(3,2,ivar);

      if color_flag
        plot(tsim, xsim(:,ivar), colors{1}, t, y_real, colors{2});
      else
        plot(tsim, xsim(:,ivar), 'Color', colors(1,:));
        hold on;
        plot(t, y_real, 'Color', colors(2,:));
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
      export_fig(sprintf('results_test_filter_bank_%s_x%i_u%i', ...
                     system, ix, iu), '-png', '-eps');
    else
      export_fig(sprintf('results_test_filter_bank_%s_x%i_u%i_bw', ...
                     system, ix, iu), '-png', '-eps');
    end
    
    %%
    
    close all;
    
  end

end

%%

%fig('width',14,'fontsize',10);
fig('width',8,'fontsize',10);

%%

load(sprintf('results_test_filter_bank_%s.mat', system), 'err_mat');

s_meth= [];

for icol= 1:numel(1:step_u:end_u)
  % creating labels
  s_1st= repmat(sprintf('u_%i', icol), end_x, 1 );

  % merging labels to one vector
  s_meth= [s_meth; s_1st];
end          

boxplot(err_mat, s_meth);%, 'labels', {'u_1', 'u_2', 'u_3'});%, 'texmode', 'on');
ylabel('$e_{\bf{\hat{x}}}$', 'FontSize', 10, 'FontName', 'Times New Roman', ...
       'Interpreter', 'latex');

%%

export_fig(sprintf('results_test_filter_bank_box_%s', ...
                   system), '-png', '-eps');

%%


