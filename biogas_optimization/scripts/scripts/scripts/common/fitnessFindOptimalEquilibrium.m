%% fitnessFindOptimalEquilibrium
% Fitness function used to find the optimal equilibrium point of a biogas
% plant
%
function [fitness, varargout]= fitnessFindOptimalEquilibrium(u, popBiogas, ...
                  plant, substrate, plant_network, substrate_network, ...
                  fitness_params, timespan, savePop, nWorker, method, ...
                  varargin)
%% Release: 1.3

%%

error( nargchk(11, 15, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%
% check input parameters?

% could be a vector or a matrix (population)! so do not use isRn
validateattributes(u, {'double'}, {'2d'}, mfilename, 'individual',  1);

checkArgument(popBiogas, 'popBiogas', 'biogasM.optimization.popBiogas', '2nd');

is_plant(plant, '3rd');
is_substrate(substrate, 4);
is_plant_network(plant_network, 5, plant);
is_substrate_network(substrate_network, 6, substrate, plant);

is_fitness_params(fitness_params, 7);

if ~isa(timespan, 'double') || numel(timespan) ~= 2
  error('The 8th parameter timespan is not a 2-dim double vector, but %s!', ...
        class(timespan));
end

is0or1(savePop, 'savePop', 9);
isN(nWorker, 'nWorker', 10);
checkArgument(method, 'method', 'char', 11);


%%
%

if nargin >= 12 && ~isempty(varargin{1})
  model_suffix= varargin{1};
else
  model_suffix= [];
end

%

if nargin >= 13 && ~isempty(varargin{2})
  control_horizon= varargin{2};
  isR(control_horizon, 'control_horizon', 13, '+');
else
  control_horizon= timespan(end);
end

%%

if nargin >= 14 && ~isempty(varargin{3})
  use_history= varargin{3};
  
  is0or1(use_history, 'use_history', 14);
else
  use_history= 0; % default 0
end

if nargin >= 15 && ~isempty(varargin{4})
  init_substrate_feed= varargin{4};
  %% TODO
  % check argument n_substrate x n_digester
else
  init_substrate_feed= [];
end


%% 
% with PSO a Individual consists out of many individuals -> the swarm,
% CMAES is similar

uswarm= u;

% uswarm is always a row vector, in case it is a swarm, then it is a
% matrix, where the number of rows define the size of the swarm

%% TODO
% bisher nur 2dimensionale fitnessfunktion erlaubt, wenn fitness mehr
% dimensionen hat, dann werden diese summiert, so dass immer 2dimensional
% heraus kommt
fitness= zeros(size(uswarm, 1), min(double(fitness_params.nObjectives), 2));
%fitness= zeros(size(uswarm, 1), double(fitness_params.nObjectives));

%%

fitness_function= str2func(char(fitness_params.fitness_function));

plant_id= char( plant.id );

%%

if popBiogas.pop_state.nCols == 0
  saveInEquilibrium= 0;
else
  saveInEquilibrium= 1;
end

%% TODO
% default value of manure bonus
% da unten fitness_params.mat datei überschreiben wird, muss hier default
% wert manuell auf 1 gesetzt werden, sonst wird bei wiederholter anwendung
% von dieser funktion def_manurebons immer vom letzten durchgang abhängig
% sein.
%def_manurebonus= 1;%fitness_params.manurebonus;

%% TODO
% wenn der MATLAB pool offen ist, ist das noch kein absolutes indiz dafür,
% dass im parallel modus gearbeitet werden soll. es kann sein, dass der
% matlabpool von einer vorherigen fehl geschlagenen simulation noch offen
% ist und vergessen wurde zu schließen. allerdings wird diese prüfung hier
% genutzt, damit nmpc nicht immer wieder den pool öffnen und schließen
% müssen, sondern der pool einmal am anfang des nmpc loops geöffnet wird
% und geschlossen am ende der schleife
%
if getMATLABVersion() < 708 || ~getIsMatlabPoolOpen() 
    
  %%
  
  for iIndividual= 1:size(uswarm, 1)

    %%
    
    u= uswarm(iIndividual, :);

    %%
    % convert the individual into an equilibrium structure

    equilibrium= popBiogas.getEquilibriumFromIndividual(u, ...
                    plant, substrate, plant_network, 0);


    %% 
    % get the adm1 parameters structure

    p_opt= popBiogas.getADM1ParamsFromIndividual(u, plant);

    % speichern in plant_sunderhook bla bla it einer set methode, da
    % die parameter eh da irgendwo drin stehen

    save( sprintf('adm1_params_opt_%s.mat', plant_id), 'p_opt');

    %%

    plant= init_ADMparams_from_mat_file(plant);
    
    %% TODO
    % das sollte nicht von der Methode abhängen! evtl. einen weiteren
    % Parameter zur fitness funktion hinzufügen, in abhängigkeit der
    % methode
    %
    fitness(iIndividual,:)= popBiogas.evalIndividualForConstraints(u, ...
            strcmp(method, 'PSO') || strcmp(method, 'CMAES') || ...
            strcmp(method, 'StdPSO_Kriging') || ...
            strcmp(method, 'PSO_Kriging')  || strcmp(method, 'SMS-EMOA') || ...
            strcmp(method, 'SMS-EGO') || strcmp(method, 'EHVI-EGO'));
    
    %% TODO
    % ich nehme an, dass nur güllebonus welcher nicht erreicht wird dazu
    % führt, dass nicht simuliert wird, das dürfte fast immer stimmen,
    % sollte aber noch sicher gestellt werden.
    %% TODO
    % stimmt jetzt nicht mehr, da güllebonus nicht mehr als lineare
    % ungleichungsnebenbedingung betrachtet wird, sondern in C# objectives
    % immer direkt online geprüft wird und dann in finanziellen erlös
    % umgerechnet wird, deshalb macht randbedingung keinen sinn mehr
    
    % das wird gemacht, da kriging modelle große probleme bekommen, wenn
    % fitness landschaft sehr zerklüftet ist. hier wird simulation
    % durchgeführt, aber ohne güllebonus, besser als individuum vorher zu
    % bestrafen.
    
    if fitness(iIndividual,1) > 0
      
      popBiogas.conObj.getPointsInFullDimension(u)
      
      %fitness_params.manurebonus= false;  % no manurebonus available for this mix
      
      %%
      
      fitness(iIndividual,:)= 0;    % reset fitness to 0
      
    else
      % reset to default value, set before loop
      % definiert nur, dass der substratmix bekommen könnte. ob tatsächlich
      % güllebonus beantragt wurde wird in plant definiert
      %fitness_params.manurebonus= true;  
    end
    
    %%
    % assign value to workspace/modelworkspace
    
    %fitness_params.saveAsXML(sprintf('fitness_params_%s.xml', plant_id));
    %save(sprintf('fitness_params_%s.mat', plant_id), 'fitness_params');

    
%     if getMATLABVersion() >= 711
%       assignin('base', 'fitness_params', fitness_params);
%     end
% 
%     try % not possible for new matlab version
%       hws.assignin('fitness_params', fitness_params);
%     catch ME
%       % ignore ME for new version
%       if getMATLABVersion() < 711
%         rethrow(ME);
%       end
%     end
% 
%     %%
%     
%     
%     %% TEST
%     %% TODO
%     if getMATLABVersion() >= 711
%       fitness_params= evalin('base', 'fitness_params');
%     end
% 
%     %% TODO
%     if (fitness_params.manurebonus == 0)
%       fitness_params.manurebonus
%     end
    
    
    
    %% 
    % simulate the system

    if fitness(iIndividual,1) < 1

      %% 
      
      fit= simBiogasPlantExtended(equilibrium, plant, substrate, ...
                                plant_network, substrate_network, ...
                                fitness_params, timespan, ...
                                saveInEquilibrium, nWorker, ...
                                fitness_function, ...
                                500, 1, 1, model_suffix, ...
                                control_horizon, ...
                                popBiogas.pop_substrate.lenGenom, 1, ...
                                use_history, init_substrate_feed);

      fitness(iIndividual,:)= fitness(iIndividual,:) + fit(:)';

    else
      disp('Warning: Not simulating, because invalid substrate mix!');

      popBiogas.conObj.getPointsInFullDimension(u)

      fitness(iIndividual,:)= fitness(iIndividual,1) + 100;
    end
   
  end
    
else
    
  %%
  
  error('Not yet implemented!');
    
  %%
  
%   parfor iIndividual= 1:size(uswarm, 1)
% 
%     %%
%     
%     u= uswarm(iIndividual, :);    
%     
%     %%
%     % convert the individual into an equilibrium structure
% 
%     %% TODO
%     % problem with plant in parfor loop
%     
%     equilibrium= popBiogas.getEquilibriumFromIndividual(u, ...
%                     plant, substrate, plant_network, 0);
% 
%     %% 
%     % get the adm1 parameters structure
% 
%     p_opt= popBiogas.getADM1ParamsFromIndividual(u, plant);
% 
%     % speichern in plant_sunderhook bla bla it einer set methode, da
%     % die parameter eh da irgendwo drin stehen
% 
%     %% TODO
%     % does not work
%     %save( sprintf('adm1_params_opt_%s.mat', plant_id), 'p_opt');
% 
%     %%
% 
%     plant= init_ADMparams_from_mat_file(plant);
%     
%     %%
%     
%     fitness(iIndividual,1)= popBiogas.evalIndividualForConstraints(u, ...
%             strcmp(method, 'PSO') || strcmp(method, 'CMAES') || ...
%             strcmp(method, 'StdPSO_Kriging') || strcmp(method, 'PSO_Kriging'));
%     
% 
%     %% 
%     % simulate the system
% 
%     if fitness(iIndividual,1) < 1
% 
%       fit= simBiogasPlantExtended(equilibrium, plant, substrate, ...
%                                 plant_network, substrate_network, ...
%                                 fitness_params, timespan, ...
%                                 saveInEquilibrium, nWorker, ...
%                                 fitness_function, ...
%                                 200, ...18.5, 
%                                 1, 1, model_suffix, ...
%                                 control_horizon, ...
%                                 popBiogas.pop_substrate.lenGenom, 1);
% 
%       fitness(iIndividual,1)= fitness(iIndividual,1) + fit;
% 
%     else
%       disp('Warning Parallel: Not simulating, because invalid substrate mix!');
% 
%       popBiogas.conObj.getPointsInFullDimension(u)
% 
%       fitness(iIndividual,1)= fitness(iIndividual,1) + 100;
%     end
% 
%   end

end
    

%%

if nargout >= 2 && ( strcmp(method, 'ISRES') || strcmp(method, 'DE') )
  if ~isempty(popBiogas.conObj.conA)
    varargout{1}= ...
              (popBiogas.conObj.conA * uswarm' - popBiogas.conObj.conb)';
  else
    varargout{1}= zeros(size(uswarm, 1), 1);
  end
elseif nargout >= 2
  error('You have to return a further argument for this method!');
end

%%


