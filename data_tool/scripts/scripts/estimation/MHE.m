%% MHE
% Moving Horizon State Estimation
%
function xp= MHE(f, h, u, y, x0, window, varargin)
%% Release: 1.0

%%

error( nargchk(6, 10, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

% continuous system function
checkArgument(f, 'f', 'function_handle', '1st');
% continuous measurement function
checkArgument(h, 'h', 'function_handle', '2nd');

checkArgument(u, 'u', 'double', 3);   % input
checkArgument(y, 'y', 'double', 4);   % output/measurement

if isvector(u)
  u= u(:);
end

if isvector(y)
  y= y(:);
end

if nargin >= 5 %&& ~isempty(varargin{3})
  %x0= varargin{3};
  isRn(x0, 'x0', 5);
  %x0= x0(:);
else
  error('You must provide the initial state x0!');
end

isN(window, 'window', 6);

if nargin >= 7 && ~isempty(varargin{1})
  sampletime= varargin{1};
  isR(sampletime, 'sampletime', 7);
else
  sampletime= 1/24;   % 1/24 der zeitkonstante des Modells, falls Modell
  % in Tagen gemessen wird, dann Interpretation: sampletime= 1 h
end

if nargin >= 8 && ~isempty(varargin{2})
  u_sample= varargin{2};
  isR(u_sample, 'u_sample', 8);
else
  u_sample= 1;    % that means same sample time as |sampletime|
end

if nargin >= 9 && ~isempty(varargin{3})
  shift_window= varargin{3};
  isN(shift_window, 'shift_window', 9);
else
  shift_window= 24 * 1;    % that means 1 day if sampletime is 1 h.
end

if nargin >= 10 && ~isempty(varargin{4})
  rel_noise_in= varargin{4};
  isR(rel_noise_in, 'rel_noise_in', 10, '+');
else
  rel_noise_in= 0.05;    % 5 %
end

%%
% Annahme, dass window in Basiseinheit gemessen wird (also h oder d)
% y alle Daten im Zeitraster h ist
% shift_window in h gemessen

toiteration= window / sampletime;

%%

myx0= x0;   % initial guess

%%

opt= odeset('RelTol',1e-4,'AbsTol',1e-6);

%%
% predicted states 

xp= zeros(ceil(size(y, 1) / shift_window) + 1, numel(x0));

%%

iiter= 1;

%%

for iwin= 1:shift_window:size(y, 1) - toiteration + 1

  %% TODO
  % bin mir nicht sicher ob das so stimmt
  fprintf('MHE: iter %i of %i.\n', iiter, size(xp, 1) - ceil((toiteration + 1) / shift_window) + 1);
  
  %%
  
  myy= y(iwin:iwin + toiteration - 1, :);
  
  start= (iiter == 1) + (iiter > 1)*fix(iwin/u_sample);
  ende= start + round((toiteration-1)/u_sample);
  
  % should never happen
  if (ende > size(u, 1))
    warning('MHE:bounds', 'ende > size(u, 1) : %i > %i', ende, size(u, 1));
  end
  
  myu= u(start:ende, :);
  
  %%
  % objective function
  obj_fun= @(x)MHE_objective(x, f, h, myu, myy, myx0, toiteration, sampletime, u_sample);
  
  %%
  % lower and upper boundaries for initial state, which is the optimization
  % variable
  
  fac= 0.15;
  
  LB= max(myx0 - myx0.*fac, 0);
  UB= myx0 + myx0.*fac;
  
  %%
  % call some optimization method
  %%TODO: change 5 back to 20
  [x]= startCMAES(obj_fun, myx0, LB, UB, 20, 4);%4
  
  %% TODO
  % evtl. sollte man hier u mit rauschen überlagern, oben ist u rauschfrei
  % Simulation dauert viel zu lange mit verrauschtem input
  %myu= add_noise_to_u_filterbank(myu, rel_noise_in);
  
  %%
  % do last simulation to get current state estimate
  
  [tsim, xsim]= ode15s( f, [0:sampletime:(toiteration - 1)*sampletime], ...
                        x, opt, myu ); 
  
  %%
  % state estimate is last simulated state
  if iiter == 1
    xp(iiter:ceil(toiteration/shift_window),:)= xsim(1:shift_window:end,:);
    xp(iiter + ceil(toiteration/shift_window),:)= xsim(end,:);
  else
    xp(iiter + ceil(toiteration/shift_window),:)= xsim(end,:);
  end
  
  %%
  % davon wird abgeraten in Diehl2006a, besser über Kalman schätzen
  myx0= xsim(shift_window,:);
  
  %%
  
  iiter= iiter + 1;
  
  %%
  
end

%%


