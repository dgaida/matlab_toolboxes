%% MHE_objective
% Calculates fitness of an moving horizon estimate starting at state x
%
function fitness= MHE_objective(x, f, h, u, y, x0, toiteration, varargin)
%% Release: 1.0

%%

error( nargchk(7, 9, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%% 
% check arguments

checkArgument(x, 'x', 'double', '1st');

% continuous system function
checkArgument(f, 'f', 'function_handle', '2nd');
% continuous measurement function
checkArgument(h, 'h', 'function_handle', '3rd');

checkArgument(u, 'u', 'double', 4);   % input
checkArgument(y, 'y', 'double', 5);   % output/measurement

if isvector(u)
  u= u(:);
end

if isvector(y)
  y= y(:);
end

if nargin >= 6 %&& ~isempty(varargin{3})
  %x0= varargin{3};
  isRn(x0, 'x0', 6);
  x0= x0(:);
else
  error('You must provide the initial state x0!');
end

isN(toiteration, 'toiteration', 7);

if nargin >= 8 && ~isempty(varargin{1})
  sampletime= varargin{1};
  isR(sampletime, 'sampletime', 8);
else
  sampletime= 1/24;   % 1/24 der zeitkonstante des Modells, falls Modell
  % in Tagen gemessen wird, dann Interpretation: sampletime= 1 h
end

if nargin >= 9 && ~isempty(varargin{2})
  u_sample= varargin{2};
  isR(u_sample, 'u_sample', 9);
else
  u_sample= 1;    % that means same sample time as |sampletime|
end


%%

opt= odeset('RelTol',1e-4,'AbsTol',1e-6);

%%
% fitness vector

fitness= zeros(size(x, 1), 1);

%%

doplots= 0;   %TODO: 0

if doplots
  colors= get_plot_colors(size(x, 1) + 1, 1);
end

%%

for iind= 1:size(x, 1)

  %%
  
  if doplots && iind == 1 && size(x, 1) >= 2
    fig;
    %% TODO: 1/24 funktioniert nur für modell mit h als Zeitkonstante
    plot([0:sampletime/24:(toiteration - 1)*sampletime/24], y(:,1), 'b');
    hold on;
  end
  
  %%
  % initial state of the simulation
  xind= x(iind, :);
  
  %%
  
  [tsim, xsim]= ode15s( f, [0:sampletime:(toiteration - 1)*sampletime], ...
                        xind, opt, u );

  %%

  %%
  % wenn sampletime= 1 (bedeutet 1 h), dann bedeutet 1 in tsim eine stunde,
  % allerdings muss es für filterbank unten 1 tag bedeuten, deshalb durch
  % 24 teilen. wenn sampletime= 1/24, dann bedeutet 1 in tsim 1 Tag, dann
  % nicht durch 24 teilen, kürzt sich weg mit sampletime
  %tsim= tsim./24./sampletime;

  %%
  % sampling time of measurements is 1 h
  if nargin(h) == 1 % number of arguments for function handle is constant
    % either 1 or 2
    y_pred= feval(h, xsim);    % measurements
  else
    % wir machen hier die annahme, dass xsim und u das geliche
    % zeitraster haben, haben sie aber nicht, rate von u ist höher,
    % deshalb wieder jeden 60. wert nehmen
    y_pred= feval(h, xsim, u(1:1/u_sample:end,:));
  end

  %%
  % 
  for iy= 1:size(y, 2)

    %% TODO
    % evtl. noch quadrieren oder ein anderes Maß, bzw. andere Gewichtung
    y_rmse= numerics.math.calcRMSE(y(:,iy), y_pred(:,iy));

    %%

    fitness(iind,1)= fitness(iind,1) + y_rmse;

    %%

  end

  %% TODO
  % arrival cost, auch hier evtl. andere Gewichtung und anderes Maß
  fitness(iind,1)= fitness(iind,1) + 1/200 * numerics.math.calcRMSE(xind, x0);

  %%

  if doplots && size(x, 1) >= 2
    %% TODO: 1/24 funktioniert nur für modell mit h als Zeitkonstante
    plot([0:sampletime/24:(toiteration - 1)*sampletime/24], y_pred(:,1), ...
         colors{iind + 1}, 'LineWidth', 2);
        
  end
  
  %%
  
end

%%

if doplots && size(x, 1) >= 2
  hold off;
  xlabel('t [d]')
  ylabel('Q_{ch4} [l/h]')
  legend({'original', 'x0', 'x1', 'x2', 'x3', 'x4'}, 'Location', 'North')
  export_fig('mhe_comparison', '-png', '-m3');
end

%%


