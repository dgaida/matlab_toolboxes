%% MHE_ADM1_objective
% Calculates fitness of an moving horizon estimate starting at state x for
% ADM1
%
function fitness= MHE_ADM1_objective(x, plant_id, u, y, x0, window, varargin)
%% Release: 0.0

%%

error( nargchk(6, 8, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%% 
% check arguments

checkArgument(x, 'x', 'double', '1st');

checkArgument(plant_id, 'plant_id', 'char', '2nd');

checkArgument(u, 'u', 'double', '3rd');   % input
checkArgument(y, 'y', 'double', 4);   % output/measurement

if isvector(u)
  u= u(:);
end

if isvector(y)
  y= y(:);
end

if nargin >= 5
  isRn(x0, 'x0', 5);
  x0= x0(:);
else
  error('You must provide the initial state x0!');
end

isN(window, 'window', 6);   % measured in days

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

%%



%%
% fitness vector

fitness= zeros(size(x, 1), 1);

%%

for iind= 1:size(x, 1)

  %%
  % initial state of the simulation
  xind= x(iind, :);
  
  %%
  % xind only contains the first 25 components of the state vector,
  % therefore calculate the components 26 - 37 out of xind components or
  % let them constant (equal to x0). 

  %% TODO: second line only true if both digesters are in optimization
  x_m= xind';
  %x_m= reshape(xind', 25, 2);
  myx0_m= reshape(x0, 37, 2);
  
  xind_ext= expand_state_x_MHE(x_m, myx0_m);
  
  %%
  
  [tsim, xsim, dummy, fitsim, sensors, sensors_data]= ...
    simBiogasPlantBasic_xu(plant_id, xind_ext, u, u_sample, [0, window]);

  %%
  % wenn sampletime= 1 (bedeutet 1 h), dann bedeutet 1 in tsim eine stunde,
  % allerdings muss es für filterbank unten 1 tag bedeuten, deshalb durch
  % 24 teilen. wenn sampletime= 1/24, dann bedeutet 1 in tsim 1 Tag, dann
  % nicht durch 24 teilen, kürzt sich weg mit sampletime
  %tsim= tsim./24./sampletime;

  % diese simulation ist fehlgeschlagen
  if isempty(tsim)
    fitness(iind,1)= 100; % evtl. einen anderen wert nehmen
    continue;
  end
  
  %% TODO - change
  % sampling time of measurements is 1 h
  
  pHs= sensors_data{1,7};

  %% TODO
  % diese größen benötige ich getrennt nach fermenter - OK für diesen Test
  % nicht, da ich eh nur mit 1. fermenter arbeite

  sim_biogass= sensors_data{1,10};
  sim_ch4s= sensors_data{1,11};
  sim_co2s= 100 - sensors_data{1,11} - sensors_data{1,13} ./ 10000;

  %%

  ts= sensors_data{1,end};

  %%
  
  y_pred= [pHs.digester', pHs.postdigester', sim_biogass', sim_ch4s', sim_co2s'];
  
  %% TODO
  % resample predicted data to given y
  
  y_pred= interp1(ts, y_pred, 0:sampletime:window - sampletime);

  %%
  % 
  for iy= 1:size(y, 2)

    %% 
    % nehme erst ab dem 2. Wert, da 1. Wert oft nicht stimmt
    
    %% TODO
    % evtl. noch quadrieren oder ein anderes Maß, bzw. andere Gewichtung
    y_rmse= numerics.math.calcRMSE(y(2:end,iy), y_pred(2:end,iy));

    %%
    
    if iy == 3    % for biogas stream, which is around 4000 m³/d
      y_rmse= y_rmse / 100;
    end
    
    %%

    fitness(iind,1)= fitness(iind,1) + y_rmse;

    %%

  end

  %% TODO
  % arrival cost, auch hier evtl. andere Gewichtung und anderes Maß
  fitness(iind,1)= fitness(iind,1) + 1/1 * numerics.math.calcRMSE(xind_ext(:), x0);

  %%

end

%%


