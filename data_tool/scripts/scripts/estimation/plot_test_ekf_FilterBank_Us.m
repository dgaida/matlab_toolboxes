%% plot_test_ekf_FilterBank_Us
% Plot input data for state estimation experiments
%
function plot_test_ekf_FilterBank_Us(U, step_u, end_u, u_sample, sampletime, toiteration, color_flag)
%% Release: 0.3

%%

error( nargchk(7, 7, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%% 
% check arguments

isN(step_u, 'step_u', 2);
isN(end_u, 'end_u', 3);

isN(toiteration, 'toiteration', 6);
is0or1(color_flag, 'color_flag', 7);

%%

%% 

if color_flag
  colors= get_plot_colors(3, 1);
  colors{3}= 'k';
else
  % mache mehr als 3 farben, damit die hellste farbe nicht zu hell ist
  colors= get_plot_colors(5, 0);  
end

linestyles= {'--', '-', ':'};

%%

fig('width', 12, 'fontsize', 10);

%% 
% tried for grayscale, does not seem to have any effect

% if color_flag == 0
%   set(gcf, 'Colormap', gray);
% else
%   set(gcf, 'Colormap', lines);
%   %colormap(lines);
% end

%%

for iin= 1:2

  %%
  
  %fig('width',13,'fontsize',10);
  subplot(2,1,iin);

  %%
  
  for iu= 1:step_u:end_u

    myu= U{iu};
    myu= myu(:,iin);
    
%     plot(0:1*u_sample*sampletime:(toiteration/u_sample - 1)*sampletime*u_sample, ...
%          myu, colors{ceil(iu/step_u)});
    if color_flag
      plot(0:sampletime:(toiteration - 1)*sampletime, ...
         myu(1:1/u_sample:end), 'Color', colors{ceil(iu/step_u)}, 'LineWidth', 1, ...
         'MarkerSize', 1, 'LineStyle', linestyles{ceil(iu/step_u)});
    else
      plot(0:sampletime:(toiteration - 1)*sampletime, ...
         myu(1:1/u_sample:end), 'Color', colors(ceil(iu/step_u),:), 'LineWidth', 1, ...
         'MarkerSize', 1, 'LineStyle', linestyles{ceil(iu/step_u)});
    end
    
    hold on;

  end
  
  hold off;
  
  %%
  
  xlabel('$t$ [d]', 'Interpreter', 'latex');
  
  if iin == 1
    ylabel('$S_{i, \alpha}(t)$ [mg/l]', 'Interpreter', 'latex');
    hleg1= legend('$S_{i,1}$', '$S_{i,2}$', '$S_{i,3}$', 'Location', 'EastOutside');
    set(hleg1, 'Interpreter', 'latex');
    ylim([0, 12000]);
  else
    ylabel('$B_{ic, \alpha}(t)$ [mg/l]', 'Interpreter', 'latex');
    hleg2= legend('$B_{ic,1}$', '$B_{ic,2}$', '$B_{ic,3}$', 'Location', 'EastOutside');
    set(hleg2, 'Interpreter', 'latex');
  end
  
  
  %%
  
  %export_fig(sprintf('test_ekf_FilterBank_Us_u%i', iin), '-png', '-eps');

end

%%

if color_flag
  export_fig('test_ekf_FilterBank_Us', '-png', '-eps');
else
  export_fig('test_ekf_FilterBank_Us_bw', '-png', '-eps');
end
  
%%


