
%%

clear
close all;

%%

system= 'ADode6';
%system= 'AM1';

%%

color_flag= 0;    % 0 for grayscale

%%

ix= 1;%3
iu= 1;
istd_dev= 1;
ns= 5;      % noise level 5 = 5 %, 1 = 1 %

%%

if color_flag
  colors= get_plot_colors(2, 1);
else
  % mache mehr als 2 farben, damit die hellste farbe nicht zu hell ist
  colors= get_plot_colors(3, 0);  
end

%%

%fak= 2;

fig('width',14,'fontsize',10);%('Position', [45 100 560*fak 420*fak]);

% wird eh nicht geplottet
%title(sprintf('results hybrid EKF x%i u%i', ix, iu))

%%

load(sprintf('results_test_mhe_%s_std%i_x%i_u%i_ns%i.mat', ...
               system, istd_dev, ix, iu, ns));
             
%%

for ivar= 1:size(xsim, 2)

  %%
  
  subplot(3,2,ivar);
  
  % gilt nur für ADode6, dort sampletime in h, muss auf days hier kommen
  if color_flag
    plot(tsim, xsim(:,ivar), colors{1}, ...
         0:shift_window/24:toiteration*sampletime/24, xp(:,ivar), colors{2}, ...
         'LineStyle', '--');
  else
    plot(tsim, xsim(:,ivar), 'Color', colors(1,:));
    hold on;
    plot(0:shift_window/24:toiteration*sampletime/24, xp(:,ivar), ...
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
  export_fig(sprintf('results_test_mhe_%s_std%i_x%i_u%i_ns%i', ...
               system, istd_dev, ix, iu, ns), '-png', '-eps');
else
  export_fig(sprintf('results_test_mhe_%s_std%i_x%i_u%i_ns%i_bw', ...
               system, istd_dev, ix, iu, ns), '-png', '-eps');
end

%%


