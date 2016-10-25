%% residual4plotAnalysis
% Residual 4 plot analysis
%
function residual4plotAnalysis(r, varargin)
%% Release: 1.3

%%
%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 2 && ~isempty(varargin{1})
  new_fig= varargin{1};
  is0or1(new_fig, 'new_fig', 2);
else
  new_fig= 1;
end

%%
% check argument

checkArgument(r, 'r', 'double', '1st');

%%

if new_fig
  
  figure1= figure('Position', [45 100 560*2 420*2], ...
          'Color','w', ...'PaperSize',[20.98404194812 29.67743169791], 
          'InvertHardcopy', 'on');

  set(figure1, 'DefaultTextFontSize', 11); 
  set(figure1, 'DefaultAxesFontSize', 11); 
  set(figure1, 'DefaultAxesFontName', 'times new roman');
  set(figure1, 'DefaultTextFontName', 'times new roman');

end

%%
% plot residuals
% Run sequence plot to test fixed location and variation. 

subplot(2,2,1);

plot(r);
xlabel('Samples')


%%
% lag plot

subplot(2,2,2);

% in http://www.itl.nist.gov/div898/handbook/eda/section3/4plot.htm
% sollte auf y-achse yi und auf x-achse xi-1

% scatter(r(2:end), r(1:end-1), '.');
% 
% xlabel('x(k)')
% ylabel('x(k-1)')

scatter(r(1:end-1), r(2:end), '.');

xlabel('x(k-1)')
ylabel('x(k)')

title('Lag plot')


%%
% histogram

%% TODO
% have a look at alternative: histfit

%%

subplot(2,2,3);

% n_bins= numel(r)/10;
% 
% [bin_r, r_out]= hist(r, n_bins);
% bar(r_out, bin_r);
% 
% mu= mean(r);
% sigma= std(r);
% 
% %r_synth= mu + sigma .* randn(numel(r),1);
% %r_synth= sort(r_synth);
% 
% step_r= (max(r) - min(r)) / 100;
% 
% r_synth= min(r):step_r:max(r);
% 
% % gauß glockenkurve
% f= 1 ./ ( sigma .* sqrt(2*pi) ) * exp( -1/2 .* ( ( r_synth - mu ) ./sigma ).^2 );
% 
% %sum(bin_r) * numel(bin_r);
% 
% %[bin_r_synth, r_synth_out]= hist(r_synth, numel(r_synth));
% 
% %xi= min(r_out):( max(r_out) - min(r_out) ) / 500:max(r_out);
% 
% %yi= interp1(r_out, bin_r, xi, 'spline');
% 
% hold on; 
% % TODO: das dürfte sich herauskürzen, da dürfte: f * 100 stehen
% plot(r_synth, f * 10 * numel(r) / n_bins, 'r');
% hold off;

histfit(r);

%%
% normal probability plot

subplot(2,2,4);
% 
% [bin_r, r_out]= hist(r, numel(r));
% 
% F_r= cumsum(bin_r) ./ sum(bin_r);
% 
% %scatter(sort(r), F_r, '.');
% 
% %%
% 
% [bin_r_s, r_s_out]= hist(r_synth, numel(r_synth));
% 
% F= cumsum(bin_r_s) ./ sum(bin_r_s);
% 
% %hold on;
% semilogy(sort(r_synth), F, 'r');
% hold off;

normplot(r);

%%

% xlabel('Data')
% ylabel('Probability')
% title('Normal Probability Plot')


%%


