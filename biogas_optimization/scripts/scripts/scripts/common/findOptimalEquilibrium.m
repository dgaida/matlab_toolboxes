%% findOptimalEquilibrium
% Find the (global,) optimal operating point (equilibrium) of a biogas
% plant model created with the _Biogas Plant Modeling_ Toolbox.
%
function [equilibrium, u, fitness, varargout]= ...
                       findOptimalEquilibrium(plant_id, method, varargin)
%% Release: 1.3

tic;                   
                   
%%

error( nargchk(2, 16, nargin, 'struct') );
error( nargoutchk(0, nargout, nargout, 'struct') );

%% 
% read out varargin

if nargin >= 3 && ~isempty(varargin{1}), 
  useInitPop= varargin{1}; 
  is0or1(useInitPop, 'useInitPop', 3);
else
  useInitPop= 0;
end

if nargin >= 4 && ~isempty(varargin{2}), 
  parallel= varargin{2}; 
  validatestring(parallel, {'none', 'multicore', 'cluster'}, mfilename, 'parallel', 4);
else
  parallel= 'none';
end

if nargin >= 5 && ~isempty(varargin{3}), 
  nWorker= varargin{3}; 
  isN(nWorker, 'nWorker', 5);
else 
  nWorker= 2; 
end

if nargin >= 6 && ~isempty(varargin{4}), 
  pop_size= varargin{4}; 
  isN(pop_size, 'pop_size', 6);
else
  pop_size= 5; 
end

if nargin >= 7 && ~isempty(varargin{5}), 
  nGenerations= varargin{5}; 
  isN(nGenerations, 'nGenerations', 7);
else
  nGenerations= 5;
end

if nargin >= 8 && ~isempty(varargin{6}), 
  OutputFcn= varargin{6}; 
  checkArgument(OutputFcn, 'OutputFcn', 'function_handle', 8);
else
  OutputFcn= []; 
end

if nargin >= 9 && ~isempty(varargin{7}), 
  timespan= varargin{7}; 
else
  timespan= [0 250]; % in days
end

if nargin >= 10 && ~isempty(varargin{8}), 
  optParams= varargin{8}; % optimization parameters
else
  optParams= []; % 
end

%%

if nargin >= 11 && ~isempty(varargin{9})
  model_suffix= varargin{9};
else
  model_suffix= [];
end

%%

if nargin >= 12 && ~isempty(varargin{10})
  nSteps= varargin{10};
  isN(nSteps, 'nSteps', 12);
else
  nSteps= 1;
end

if nargin >= 13 && ~isempty(varargin{11})
  timespan_steps= varargin{11};
  isR(timespan_steps, 'timespan_steps', 13, '+');
  %% TODO
  % must also be smaller timespan(end) - timespan(1)
else
  timespan_steps= timespan(end);
end

%%

if nargin >= 14 && ~isempty(varargin{12})
  use_history= varargin{12};
  
  is0or1(use_history, 'use_history', 14);
else
  use_history= 0; % default 0
end

if nargin >= 15 && ~isempty(varargin{13})
  init_substrate_feed= varargin{13};
  %% TODO
  % check argument n_substrate x n_digester
else
  init_substrate_feed= [];
end

if nargin >= 16 && ~isempty(varargin{14}) % 
  nObjectives= varargin{14};
  isN(nObjectives, 'nObjectives', 16);
else
  nObjectives= 2;     % number of objectives in optimization problem
end

%%

% no parallel computing?
if strcmp(parallel, 'none')
  nWorker= 1;
end


%%
% check if the parameters have valid values

checkArgument(plant_id, 'plant_id', 'char || cell', '1st');
plant_id= char(plant_id);

checkArgument(method, 'method', 'char || cell', '2nd');
method= char(method);

%% 
% check if parameter combinations are chosen for which there is not yet an
% implementation -> Implement them and erase the queries here...!

%if (~strcmp(parallel, 'none') && strcmp(method, 'PSO'))
%    error('The parallel code for the PSO method is not yet implemented.');
%end

if strcmp(parallel, 'cluster')
  error('The parallel code for the cluster is not yet implemented/tested.');
end


%%
% change nObjectives value in fitness_params.mat/xml and save files again

set_nObjectives_in_fitness_params(plant_id, method, {pwd}, nObjectives);


%% 
% load all struct *.mat files

if useInitPop == 1
    
  [substrate, plant, substrate_network, plant_network, ...
   substrate_network_min, substrate_network_max, ...
   plant_network_min, plant_network_max, ...
   digester_state_min, digester_state_max, params_min, params_max, ...
   substrate_eq, substrate_ineq, fitness_params, equilibria]= ...
                                load_biogas_mat_files(plant_id);

else

  [substrate, plant, substrate_network, plant_network, ...
   substrate_network_min, substrate_network_max, ...
   plant_network_min, plant_network_max, ...
   digester_state_min, digester_state_max, params_min, params_max, ...
   substrate_eq, substrate_ineq, fitness_params]= ...
                                load_biogas_mat_files(plant_id);

end

%%
% set linear constraint manure bonus if fitness_params.manurebonus == 1
%% TODO
% würde meines erachtens mehr sinn machen hier manurebonus aus plant zu
% nehmen, da das anzeigt ob prinzipiell mit güllebonus gerechnet werden
% soll oder nicht
% manurebonus in fitness_params zeigt nur an ob das aktuelle substrat für
% den güllebonus qualifiziert. da aber noch keine simulation vorher gemacht
% wurde hängt der wert in fitness_params vom zufall bzw. einer
% vorvergangheit ab.
% FAZIT: DAS IST SO FALSCH!!!
% ICH denke, dass es nicht ratsam ist, güllebonus als lineare
% ungleichungsrandbedingung zu formulieren. der grund ist, dass in fitness
% funktion ganz genau berechnet werden kann was es bedeutet wenn für eine
% substratzufuhr kein güllebonus gezahl werden kann. deshalb gibt es keinen
% grund diese substratzufuhren von vorherein auszuschließen
% substrate_ineq wird ohnehin nur für popBiogas genutzt (falls dort eine
% population erstellt wird) und für methoden welche explizit
% randbedingungen berücksichtigen (bsp.: GA, fmincon)
%substrate_ineq= setLinearManureBonusConstraint(...
 %               substrate, plant, fitness_params.manurebonus, nSteps);
              
%save(['substrate_ineq_', plant_id, '.mat'], 'substrate_ineq');

%%
% load the model(s)

fcn= ['plant_', plant_id];

load_biogas_system(fcn, parallel, nWorker);


%%
% habe hier substrate_ineq auf [] gesetzt (vor substrate_eq) da das vorher
% nur güllebonus war, dieser wird jetzt nicht mehr als randbedingung
% betrachtet, s. diskussion oben

[popBiogas]= biogasM.optimization.popBiogas(0, ...
                    substrate_network_min, substrate_network_max, ...
                    plant_network_min, plant_network_max, ...
                    digester_state_min, digester_state_max, ...
                    params_min, params_max, ...
                    [], substrate_eq, ...
                    @(obj)@(u)nonlcon_substrate(u, plant, substrate, ...
                                        obj, fitness_params.TS_feed_max), ...
                    [], [], @(u)nonlcon_plant(u), ...
                    [], [], [], ...
                    @(u)nonlcon_params(u), ...
                    parallel, nWorker, [], nSteps);

% the second time needed for nonlcon_substrate
[popBiogas]= biogasM.optimization.popBiogas(0, ...
                    substrate_network_min, substrate_network_max, ...
                    plant_network_min, plant_network_max, ...
                    digester_state_min, digester_state_max, ...
                    params_min, params_max, ...
                    [], substrate_eq, ...
                    @(u)nonlcon_substrate(u, plant, substrate, ...
                            popBiogas, fitness_params.TS_feed_max), ...
                    [], [], @(u)nonlcon_plant(u), ...
                    [], [], [], ...
                    @(u)nonlcon_params(u), ...
                    parallel, nWorker, [], nSteps);

                
% %% TODO
% % is this needed?
% assignin('base', 'popBiogas', popBiogas);


%%
% set bounds for individual   

LB_individual= getconLB(popBiogas.conObj);
UB_individual= getconUB(popBiogas.conObj);

nvars= size(LB_individual, 2);         	% Number of variables



%% 
% create the initial population

if useInitPop == 1

  % u0 is the initial population
  u0(1:size(equilibria, 2),1)= 0;

  % create initial population
  for ieq= 1:size(equilibria, 2)

    uTemp= getIndividualFromEquilibrium(...
                            popBiogas, equilibria(1,ieq), plant);

    %% TODO
    % check if the individual uTemp is in the bounds, and if not, then
    % readjust the bounds or readjust the individual?

    u0(ieq,1:size(uTemp,2))= uTemp;

  end

  pop_size= max(size(u0, 1), pop_size);     	% population size

else

  u0= [];

  %pop_size= 5;                           % population size
    
end



%%
% define the fitness function
        
ObjectiveFunction= ...
    @(u)fitnessFindOptimalEquilibrium(u, popBiogas, plant, substrate, ...
                       plant_network, substrate_network, ...
                       fitness_params, timespan, useInitPop, nWorker, ...
                       method, model_suffix, timespan_steps, use_history, init_substrate_feed);

                   
                   
%% 
% start optimization method
                   
switch (method)

  %%

  case 'fmincon'

    uStart= ( UB_individual - LB_individual ) ./ 2 + LB_individual;

    [u, fitness, varargout]= startFMinCon(ObjectiveFunction, uStart, ...
                                 LB_individual, ...
                                 UB_individual, ...
                                 nGenerations, 60*60*14, 1e-10, ...150
                                 getconA(popBiogas.conObj), ...
                                 getconb(popBiogas.conObj), ...
                                 getconAeq(popBiogas.conObj), ...
                                 getconbeq(popBiogas.conObj), ...
                                 parallel, nWorker, OutputFcn);

  %%
  
  case 'fminsearch'

    uStart= ( UB_individual - LB_individual ) ./ 2 + LB_individual;

    [u, fitness, varargout]= startFMinSearch(ObjectiveFunction, uStart, ...
                                 LB_individual, UB_individual, ...
                                 nGenerations, 1e-10, OutputFcn);

  %%

  case 'GA'

    [u, fitness, varargout]= startGA(ObjectiveFunction, nvars, ...
                                 LB_individual, ...
                                 UB_individual, u0, pop_size, ...
                                 nGenerations, 60*60*14, 1e-10, ...150
                                 getconA(popBiogas.conObj), ...
                                 getconb(popBiogas.conObj), ...
                                 getconAeq(popBiogas.conObj), ...
                                 getconbeq(popBiogas.conObj), ...
                                 parallel, nWorker, OutputFcn);

  %%

  case 'PSO'

    [u, fitness, varargout]= startPSO(ObjectiveFunction, nvars, ...
                                 LB_individual, ...
                                 UB_individual, u0, pop_size, ...
                                 nGenerations, 60*60*14, 1e-99, ...
                                 parallel, nWorker);

  %% TODO
  % Methode noch nicht komplett in toolbox integriert
  case 'StdPSO_Kriging'
    
    [u, fitness, varargout]= startStdPSOKriging(ObjectiveFunction, nvars, ...
                                 LB_individual, ...
                                 UB_individual, pop_size, ...
                                 nGenerations);
  
  %% TODO
  % Methode noch nicht komplett in toolbox integriert
  case 'PSO_Kriging'
    
    [u, fitness, varargout]= startPSOKriging(ObjectiveFunction, nvars, ...
                                 LB_individual, ...
                                 UB_individual, pop_size, ...
                                 nGenerations);
  
  %%

  case 'ISRES'

    [u, fitness, varargout]= startISRES(ObjectiveFunction, ...
                                 LB_individual, ...
                                 UB_individual, u0, pop_size, ...
                                 nGenerations, parallel, nWorker);

  %%

  case 'DE'          

    [u, fitness, varargout]= startDE(ObjectiveFunction, nvars, ...
                                 LB_individual, ...
                                 UB_individual, u0, pop_size, ...
                                 nGenerations, parallel, nWorker);

  %%

  case 'CMAES'          

    [u, fitness, varargout]= startCMAES(ObjectiveFunction, ...
                                 u0, LB_individual, ...
                                 UB_individual, pop_size, ...
                                 nGenerations, parallel, nWorker);                             

  %%

  case 'PS'          

    [u, fitness, varargout]= startPatternSearch(ObjectiveFunction, ...
                                 u0, LB_individual, ...
                                 UB_individual, ...pop_size, ...
                                 nGenerations, 60*60*14, 1e-10, ...150
                                 getconA(popBiogas.conObj), ...
                                 getconb(popBiogas.conObj), ...
                                 getconAeq(popBiogas.conObj), ...
                                 getconbeq(popBiogas.conObj), ...
                                 parallel, nWorker); 

  %%
  
  case 'SMS-EMOA'          

    [paretoset, paretofront, varargout]= ...
                    startSMSEMOA(ObjectiveFunction, 2, ...
                                 u0, LB_individual, ...
                                 UB_individual, pop_size, ...
                                 nGenerations);                             

    %%
    % Get optimal individual out of paretofront
    
    [u, fitness]= get_optimum_oo_paretofront(paretofront, paretoset, fitness_params);
    
    %% TODO
    % Vorsicht mit dem speichern der paretomenge
    % wenn LB und UB in nächster NMPC Iteration sich verändern, dann passt
    % die paretomenge überhaupt nicht mehr, also evtl. besser paretomenge
    % überhaupt nicht zu speichern?
    % dafür habe ich die rescale_paretoset_SMSEMOA.m methode
    save('init_popSMSEMOA.txt', 'paretoset', '-ascii');

  %%
  
  %%
  
  case {'SMS-EGO', 'EHVI-EGO'}

    %% TODO
    % in hilfe schreiben, dass pop_size hier nicht genutzt wird, oder
    % pop_size mit nGenerations multiplizieren als Alternative
    
    [paretoset, paretofront, varargout]= ...
                    startSMSEGO(ObjectiveFunction, LB_individual, ...
                                UB_individual, nGenerations);                             

    %%
    % Get optimal individual out of paretofront
    
    [u, fitness]= get_optimum_oo_paretofront(paretofront, paretoset, fitness_params);
    
  %%

  otherwise
    
    error('Unknown method: %s!', method);
    
end



%%
% save the best individual as equilibrium structure

equilibrium= popBiogas.getEquilibriumFromIndividual(u, plant, substrate, ...
                    plant_network, fitness);

% Eintrag für hydraulic_delay stimmt nicht, es sollte der default Vektor
% sein
save(['equilibrium_' plant_id '_optimum.mat'], 'equilibrium');

%%
% save optimal adm1 parameters

p_opt= popBiogas.getADM1ParamsFromIndividual(u, plant);
            
save( sprintf('adm1_params_opt_%s_optimum.mat', plant_id), 'p_opt');

%%

if strcmp(parallel, 'none')
  close_biogas_system(fcn);
end


%%

toc

%%


