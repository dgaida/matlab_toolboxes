%% MHE_ADM1
% Moving Horizon State Estimation for ADM1
%
function xp= MHE_ADM1(plant_id, u, y, x0, window, varargin)
%% Release: 0.0

%%

error( nargchk(5, 9, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

checkArgument(plant_id, 'plant_id', 'char', '1st');

checkArgument(u, 'u', 'double', 2);   % input
checkArgument(y, 'y', 'double', 3);   % output/measurement

if isvector(u)
  u= u(:);
end

if isvector(y)
  y= y(:);
end

if nargin >= 4 && ~isempty(x0)
  isRn(x0, 'x0', 4);
else
  error('You must provide the initial state x0!');
end

isN(window, 'window', 5);   % measured in days not in hours

if nargin >= 6 && ~isempty(varargin{1})
  sampletime= varargin{1};
  isR(sampletime, 'sampletime', 6);
else
  sampletime= 1/24;   % 1/24 der zeitkonstante des Modells, falls Modell
  % in Tagen gemessen wird, dann Interpretation: sampletime= 1 h
end

if nargin >= 7 && ~isempty(varargin{2})
  u_sample= varargin{2};
  isR(u_sample, 'u_sample', 7);
else
  u_sample= 1;    % that means same sample time as |sampletime|
end

if nargin >= 8 && ~isempty(varargin{3})
  shift_window= varargin{3};
  isN(shift_window, 'shift_window', 8);
else
  shift_window= 24 * 1;    % that means 1 day if sampletime is 1 h.
end

if nargin >= 9 && ~isempty(varargin{4})
  rel_noise_in= varargin{4};
  isR(rel_noise_in, 'rel_noise_in', 9, '+');
else
  rel_noise_in= 0.05;    % 5 %
end

%%
% Annahme, dass window in Basiseinheit gemessen wird (also d)
% y alle Daten im Zeitraster h ist, bzw. sampletime
% shift_window in h gemessen

toiteration= window / sampletime;

%%
% [digester1; digester2; ...]
myx0= x0;   % initial guess, vector with initial states of digesters

%%
% predicted states 

xp= zeros(ceil(size(y, 1) / shift_window) + 1, numel(x0));

%%

iiter= 1;

%%

for iwin= 1:shift_window:size(y, 1) - toiteration + 1

  %%
  
  fprintf('MHE ADM1: iter %i of %i.\n', iiter, size(xp, 1) - ceil((toiteration + 1) / shift_window) + 1);
  
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
  obj_fun= @(x)MHE_ADM1_objective(x, plant_id, myu, myy, myx0, window, sampletime, u_sample);
  
  %% TODO
  % 37 verallgemeinern, 25 am besten auch
  
  myx0_m= reshape(myx0, 37, 2);
  %% TODO: here I only use the first digester in the optimization
  myx0_red= myx0_m(1:25, 1);
  %myx0_red= myx0_m(1:25, :);     % to use all digesters
  
  % scale data
  
  myx0_red(8, :)= myx0_red(8, :) .* 1e5;   % hydrogen: 10e-7
  
  myx0_red= myx0_red(:);
  
  %%
  % lower and upper boundaries for initial state, which is the optimization
  % variable
  LB= max(myx0_red - myx0_red.*0.15, 0);
  UB= myx0_red + myx0_red.*0.15;
  
  %%
  % call some optimization method
  
  [x]= startCMAES(obj_fun, myx0_red', LB', UB', 5, 2); %4
  
  %% TODO
  % evtl. sollte man hier u mit rauschen überlagern, oben ist u rauschfrei
  % Simulation dauert viel zu lange mit verrauschtem input
  %myu= add_noise_to_u_filterbank(myu, rel_noise_in);
  
  %% 
  % x is only a part of the ADM1 state
  
  %% TODO: only needed if both digesters are in optimization
  %x_m= reshape(x(:), 37, 2);
  x_m= x(:);
  
  x= expand_state_x_MHE(x_m, myx0_m);
  
  %%
  % do last simulation to get current state estimate
  
  [tsim, xsm, dummy, fitsim, sensors]= ...
    simBiogasPlantBasic_xu(plant_id, x, myu, u_sample, [0, window]);
  
  %% TODO
  % nicht mit xsm arbeiten, da dort nicht nur zustände der fermenter drin
  % sind, vor allem weiß man nicht wo die fermenter drin stehen, sondern
  % aus sensor aufgezeichnete zustandsvektoren holen
  
  % dim: 37 x time
  state1= double(sensors.getMeasurementStreams('ADMstate_digester'));
  state2= double(sensors.getMeasurementStreams('ADMstate_postdigester'));
  
  % time x 74
  xsm= [state1; state2]';
  
  tsim= double(sensors.getTimeStream())';   % column vector
  
  %%
  % resample xsim to ...
  
  xsim= interp1(tsim, xsm, 0:sampletime:tsim(end));
  
  %%
  % state estimate is last simulated state
  if iiter == 1
    if numel(xsim(1:shift_window:end,1)) ~= ceil(toiteration/shift_window) + 1
      xp(iiter:ceil(toiteration/shift_window),:)= xsim(1:shift_window:end,:);
      xp(iiter + ceil(toiteration/shift_window),:)= xsim(end,:);
    else
      xp(iiter:ceil(toiteration/shift_window) + 1,:)= xsim(1:shift_window:end,:);
    end
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


