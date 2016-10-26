%% getRecordedFitnessExtended
% Get fitness out of recorded values plus norm u and x
%
function [fitness, udotnorm, xdotnorm]= getRecordedFitnessExtended(...
  sensors, substrate, plant, y, t, varargin)
%% Release: 1.1

%%

error( nargchk(5, 8, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%

if nargin >= 6 && ~isempty(varargin{1})
  fitness_params= varargin{1};
  
  is_fitness_params(fitness_params, 6);
else
  fitness_params= [];
end

if nargin >= 7 && ~isempty(varargin{2})
  use_history= varargin{2};
  
  is0or1(use_history, 'use_history', 7);
else
  use_history= 0; % default 0
end

if nargin >= 8 && ~isempty(varargin{3})
  init_substrate_feed= varargin{3};
  %% TODO
  % check argument n_substrate x n_digester
else
  init_substrate_feed= [];
end


%%
% check arguments

is_sensors(sensors, '1st');   % throws an error if not

% both are only needed for use_history == 1
is_substrate(substrate, 2);
is_plant(plant, 3);

checkArgument(y, 'y', 'double', 4);     % could be empty
checkArgument(t, 't', 'double', 5);     % could be empty

%%

if ~isempty(y) && ~isempty(t)
  % get fitness out of recorded y
  fitness= getRecordedFitness(y, t, use_history);
elseif ~isempty(fitness_params)
  fitness= getRecordedFitness(sensors, fitness_params, use_history);
else
  error('Either y and t or fitness_params have to be non-empty!');
end

%%

if (use_history)

  %%
  
  if isempty(t)
    t= double(sensors.getTimeStream());
  end

  %%
  
  udotnorm= getudotnorm(substrate, sensors, t, init_substrate_feed);
  %udotnorm= 0;
  
  %% TODO
  % vorfaktor vor udotnorm bestimmt Dämpfung des reglers, desto größer
  % Faktor, desto größer die Dämpfung. falls regler schwingt, dann diesen
  % faktor erhöhen. bei test auf stationärität sollte dieser faktor hier
  % eingestellt werden. 
  
  if ~isempty(fitness_params)
    %% das hier wird von writetodatabase aufgerufen, wenn gewicht in fitness_params
    % nicht 0.1 ist, dann führt das für die datenbank zu falschen
    % ergebnissen
    fitness(end)= fitness(end) + fitness_params.myWeights.w_udot .* udotnorm;
  else
    %% TODO
    % dieser Faktor muss immer identisch sein mit dem, welcher in C# genutzt
    % wird
    %% TODO
    % alle experimente bisher (16.8. - 24.8.2013) wurden mit Faktor 0.1
    % gemacht, das war allerdings falsch, da faktor in C#
    % (fitness_params.myWeights.w_udot) 0.05 ist. führt dazu, dass
    % substratwechsel am anfang der simulation doppelt so schlimm bewertet
    % wird wie ein wechsel während der simulation wirklich wäre. 
    %% TODO - faktor hier sollte 0.05 sein
    % habe faktor am 24.08.2013 um 19.00 Uhr geändert auf 0.05. Alle
    % experimente, welche ab 25.08.2013 mittags gestartet werden, haben
    % neuen faktor. schauen ob diese experimente besser sind als wie alte
    % experimente. ein paar der alten experimente erneuern zum test. 
    %fitness(end)= fitness(end) + 0.1 .* udotnorm;
    fitness(end)= fitness(end) + 0.05 .* udotnorm;
  end
  
  %%

  xdotnorm= getxdotnorm(plant, sensors, t);
  
  %% TODO
  % das war mal ein Faktor von 0.01, habe ich jetzt heraus genommen
  fitness(end)= fitness(end) + 0.0 .* xdotnorm;

else % ~use_history
  udotnorm= 0;
  xdotnorm= 0;
end

%%


