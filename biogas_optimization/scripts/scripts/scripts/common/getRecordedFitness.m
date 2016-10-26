%% getRecordedFitness
% Get fitness out of recorded y or the sensors object
%
function fitness= getRecordedFitness(y_sensors, varargin)
%% Release: 1.0

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 2 && ~isempty(varargin{1})
  t_fitness_params= varargin{1};
  % if y is given, then it must be t
  % if sensors is given it must be fitness_params
  % is checked below
else
  error('The 2nd parameter must be non-empty!');
end

if nargin >= 3 && ~isempty(varargin{2})
  use_history= varargin{2};
  
  is0or1(use_history, 'use_history', 3);
else
  use_history= 0; % default 0
end

%%

if isa(y_sensors, 'double')
  t= t_fitness_params;
  
  if ~isvector(t)
    % throw error if isvector fails
    error('The 2nd argument t is not a double vector, but a %s!', class(t));
  end
  
  y= y_sensors;
else
  
  is_sensors(y_sensors, '1st');   % throws an error if not
  
  % get dimension of recorded fitness - number of dimensions
  fitness_params= t_fitness_params;
  
  is_fitness_params(fitness_params, '2nd');
  
  % allocate y - todo  - ist schwierig
  
  for iobj= 1:double(fitness_params.nObjectives)
    % die fitness, welche ich hier aus dem sensors object hole ist die
    % fitness, welche von fitness_sensor aufgezeichnet wird. diese hat
    % nicht viel mit dem fitness vektor zu tun, welcher unten berechnet
    % wird
    y(:, iobj)= double(y_sensors.getMeasurementStream('fitness', iobj - 1));
  end
  
  t= double(y_sensors.getTimeStream('total_biogas_'));
  
end

%%



%% 

if use_history

  fitness= zeros(1, size(y, 2));

  %t_sample= min(t):1:max(t);    % sample over 1 day

  Dt= t(end) - t(1);    % delta t, duration of last simulation
  
  %% 
  % wenn ich nur 1 Tag simuliere, komme ich hier nicht rein
  % jetzt ok, 1 tag ist mindest simulationsdauer
  if Dt >= 0.05 %numel(t_sample) > 3

    for iobj= 1:size(y, 2)

      % interpolate on 1 day data
      %fitness_history= interp1(t, y(:,iobj), t_sample, 'linear');

      % get the sum, ignore the first value
      % start integrating 1 day after start of simulation
      fitness(1, iobj)= ...sum(fitness_history(2:end));
        integrate_data(y(:,iobj), t, t(1) + min(0.9, Dt*0.1));
      %% 
      % gradienten von etwas bestimmen
      % diff -> wird in getRecordedFitnessExtended gemacht

      %% 
      % terminal cost nutzen
      % terminal cost hat 1/3 Einfluss auf gesamten Fitnesswert, wenn man
      % max(t)/2 nutzt. wemm man davon ausgeht, dass max(t)= 100 d ist,
      % dann ist stage cost: 100 * y(end,iobj) (falls y constant wäre)
      % terminal cost: 50 * y(end,iobj), also 50/(100 + 50)= 1/3
      
      % 3/3 y + 1/3 y = 4/3 y, damit sind 1 von 4 teilchen in terminal
      % cost, also 25 %
      
      %% TODO
      % alle experimente in I wurden mit w_term= 0.5 gemacht. w_term= 0.75
      % wurde jetzt gewählt für experimente II, damit setpoint halten einen
      % substratwechsel nicht verhindert. bei einem substratwechsel wird
      % setpoint für eine weile verlassen, am ende des Tp wird der setpoint
      % erst wieder erreicht. bei limitierten substraten und bei dann
      % wieder neu vorliegenden (wiederaufgefüllten) substraten muss es
      % möglich sein wieder zum alten optimalen substratmix zurück zu
      % wechseln
      
      w_term= 0.75; % 0.5;      % weight for terminal cost
      
      %% TODO
      % wenn nObjectives == 3, dann fasse ich bisher die 2. und 3.
      % komponente zusammen zur 2. komponente. wenn ich bei MO methode
      % wirklich mit 3 objectives arbeiten will, muss ich das hier
      % überarbeiten
      %% TODO
      % wenn ich mit SO methoden arbeiten, wird u_dot nicht richtig
      % verarbeitet. dieses wird dann durch max(t)-min(t) geteilt. ich
      % müsste dann mit nObjectives= 2 arbeiten, evtl. in C# überarbeiten
      % und dann hier schauen, wenn ich mit SO methode arbeite, dass ich
      % dann aus 2dim y ein 1dim y mache, genau so wie ich von 3 auf 2
      % gehe. bisher nicht möglich
      if iobj == 3
        %% TODO - hier wird durch 150 dividiert aufgrund von normierung
        % damit ich ergebnisse, welche ich mit Tp= 150 d behalten kann.
        % vorher wurde hier fälschlicherweise ebenfalls durch (max(t) -
        % min(t)) geteilt, so wie unten. die dritte dimension ist
        % allerdings udot und die darf nicht von Tp abhängig sein, weil
        % sonst das verhältnis zwischen fitness(1) und udot sich
        % verschiebt bei unterschiedlichen Tp's. y(end, 3) ist in der regel
        % 0, es sei denn am ende der simulation wird gerade substratzufuhr
        % geändert. wenn ja, dann muss ich dsa auch durch 150 teilen,
        % anders als wie unten
        fitness(1, iobj)= (1 - w_term) * 1/(   150         ) * fitness(1, iobj) + ...
                          w_term       * 1/(   150         ) .* y(end, iobj); % /2     %   25 %
                        
        %%
        % add 3rd element of fitness vector to 2nd element
        fitness(1, iobj - 1)= fitness(1, iobj - 1) + fitness(1, iobj);
        
        % reduce fitness vector to a 2dimensional one
        fitness= fitness(1, 1:2);
      else
        % hier durch teilen durch max(t) - min(t) erfolgt eine
        % mittelwertbildung der fitness. das bruache ich bei udot nicht.
        % Bsp.: 2 simulationen wo am anfang der simulation 1 mal die
        % substratzufuhr geändert wird. anmerkung: substratzufuhr welche am
        % anfang geändert wird, ist in fitness(3) noch nicht drin, sondern
        % wird in udotnorm berechnet. dort gilt allerdings das selbe. also:
        % 1. Bsp.: Tp= 50 d. ich erhalte eine mittlere fitness und ein udot
        % 2. Bsp.: Tp= 150 d. ich erhalte in etwa die selbe fitness, da ich
        % durch max(t)-min(t) teile. und udot ist identisch. es wäre nicht
        % identisch wenn ich udot durch max(t) - min(t) geteilt hätte, dann
        % wäre udot nur 1/3 und macht damit einen geringeren anteil als wie
        % bei Tp= 50 d. 
        fitness(1, iobj)= (1 - w_term) * 1/(max(t) - min(t)) * fitness(1, iobj) + ...
                          w_term      .* y(end, iobj); % /2     %   25 %
      end
      
    end

  else
    fitness= y(end,:);
    
    if numel(fitness) > 1   % if multi-objective
      % falls fitness 3 oder höher dimensional ist, dann reduziere auf
      % 2dimensionalen vektor, durch summierung der höheren dimensionen
      fitness(2)= sum(fitness(2:end));
      % reduce fitness vector to a 2dimensional one
      fitness= fitness(1, 1:2);
    end
  end

else % ~use_history

  %%
  % for multiobjective optimization y is a matrix with number of columns
  % equal to number of objectives
  fitness= y(end,:);

  if numel(fitness) > 1   % if multi-objective
  
    % falls fitness 3 oder höher dimensional ist, dann reduziere auf
    % 2dimensionalen vektor, durch summierung der höheren dimensionen
    fitness(2)= sum(fitness(2:end));
    % reduce fitness vector to a 2dimensional one
    fitness= fitness(1, 1:2);

  end
  
end

%%


