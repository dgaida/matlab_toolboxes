%% simBiogasPlantExtended
% Simulate a biogas plant created with the library of the _Biogas
% Plant Modeling_ Toolbox and save good equilibria to a database. 
%
function [fitness, equilibrium, varargout]= ...
         simBiogasPlantExtended(equilibrium, plant, substrate, ...
                                plant_network, substrate_network, ...
                                fitness_params, varargin)
%% Release: 1.3

%%

error( nargchk(6, 19, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%
% read out varargin

if nargin >= 7 && ~isempty(varargin{1}), 
  timespan= varargin{1}; 
  
  if ~isa(timespan, 'double') || numel(timespan) ~= 2
    error('The 7th parameter timespan is not a 2-dim double vector, but %s!', ...
          class(timespan));
  end
else
  timespan= [0, 100]; 
end

if nargin >= 8 && ~isempty(varargin{2})
  saveInEquilibrium= varargin{2}; 
  is0or1(saveInEquilibrium, 'saveInEquilibrium', 8);
else
  saveInEquilibrium= 1; 
end

if nargin >= 9 && ~isempty(varargin{3})
  nWorker= varargin{3};
  isN(nWorker, 'nWorker', 9);
else
  nWorker= 1;
end

if nargin >= 10 && ~isempty(varargin{4})
  %% TODO
  % delete this parameter
  fitness_function= varargin{4}; 
  checkArgument(fitness_function, 'fitness_function', 'function_handle', 10);
else
  fitness_function= @fitness_wolf_adapted;
end

if nargin >= 11 && ~isempty(varargin{5})
  threshold_fitness_after_sim= varargin{5}; 
  isR(threshold_fitness_after_sim, 'threshold_fitness_after_sim', 11);
else
  threshold_fitness_after_sim= 1;
end

if nargin >= 12 && ~isempty(varargin{6})
  setNetworkFluxInModelWorkspace= varargin{6}; 
  is0or1(setNetworkFluxInModelWorkspace, 'setNetworkFluxInModelWorkspace', 12);
else
  setNetworkFluxInModelWorkspace= 0;
end

if nargin >= 13 && ~isempty(varargin{7})
  setStateInModelWorkspace= varargin{7}; 
  is0or1(setStateInModelWorkspace, 'setStateInModelWorkspace', 13);
else
  setStateInModelWorkspace= 1;
end

if nargin >= 14 && ~isempty(varargin{8})
  %% TODO
  % do we need this parameter
  model_suffix= varargin{8};
else
  model_suffix= [];
end

if nargin >= 15 && ~isempty(varargin{9})
  control_horizon= varargin{9};
  isR(control_horizon, 'control_horizon', 15);
else
  control_horizon= timespan(end);
end

if nargin >= 16 && ~isempty(varargin{10})
  lenGenomSubstrate= varargin{10};
  isN(lenGenomSubstrate, 'lenGenomSubstrate', 16);
else
  lenGenomSubstrate= 1;
end

if nargin >= 17 && ~isempty(varargin{11})
  lenGenomPump= varargin{11};
  isN(lenGenomPump, 'lenGenomPump', 17);
else
  lenGenomPump= 1;
end

if nargin >= 18 && ~isempty(varargin{12})
  use_history= varargin{12};
  
  is0or1(use_history, 'use_history', 18);
else
  use_history= 0; % default 0
end

if nargin >= 19 && ~isempty(varargin{13})
  init_substrate_feed= varargin{13};
  %% TODO
  % check argument n_substrate x n_digester
else
  init_substrate_feed= [];
end


%%
% check input parameters

is_equilibrium(equilibrium, '1st');
is_plant(plant, '2nd');
is_substrate(substrate, '3rd');
is_plant_network(plant_network, 4, plant);
is_substrate_network(substrate_network, 5, substrate, plant);
is_fitness_params(fitness_params, 6);

%%
                            
networkFlux= equilibrium.network_flux;
fluxString=  equilibrium.network_flux_string;

                            
%% 
% simulate the system

closeModel= 0;

[fitness, equilibrium, fcn, sensors]= ...
             simBiogasPlant(equilibrium, plant, substrate, ...
                            plant_network, substrate_network, ...
                            timespan, 'default', ...
                            saveInEquilibrium, nWorker, ...
                            setNetworkFluxInModelWorkspace, ...
                            setStateInModelWorkspace, ...
                            closeModel, model_suffix, ...
                            control_horizon, lenGenomSubstrate, ...
                            lenGenomPump, use_history, init_substrate_feed, ...
                            fitness_params);
     


%%
% check the fitness, if its good, then save the equilibrium
%% TODO : sum(fitness) ist nicht besonders glücklich, ist aber auch relativ egal 
if sum(fitness) < threshold_fitness_after_sim
   
  %%

  equilibrium= saveStateInEquilibriumStruct(equilibrium, plant, ...
                                            plant_network, fitness);

  %% TODO
  % why is this done here? and why at all?
  
  equilibrium.network_flux= networkFlux;
  equilibrium.network_flux_string= fluxString;


  %% 
  %

%   try
    %plant_model= evalin('base', [bdroot, '_data']);

    %fitness_function= plant_model.getFitnessFunction();
    fitness_function= str2func(char(fitness_params.fitness_function));

%   catch ME
%     %rethrow(ME);
% 
%     warning('fitness_function:changedValue', ...
%             'Set fitness_function to @fitness_costs!');
%     fitness_function= @fitness_costs;
%     disp(ME.message)
%   end

  %fitness_function= plant_model.getFitnessFunction();


  %%
  % write in database

  substrate_network_genom= repmat(substrate_network, lenGenomSubstrate, 1);

  substrate_net= substrate_network_genom(:);

  % add all recirculated streams to the database, thus extend ones
  substrate_net= [substrate_net; ...
                  ones(numel(networkFlux) - numel(substrate_net), 1)];

  %% 
  % ist == 1 die richtige abfrage? wenn 2 fermenter gefüttert werden,
  % dürfte substrate_net bei 50/50 aufteilung 0.5 sein...
  % > 0 sollte besser sein
  % geändert von == 1 zu > 0
  %
  networkFluxTemp= networkFlux(substrate_net > 0);
  fluxStringTemp= fluxString(substrate_net > 0);

  %% 
  % why -1? why not 0?
  % wenn man nur elemente > 0 in datenbank schrieben will dann kann man
  % hier elemente raus schmeißen, ansonsten einfach alle durchziehen. 
%   [networkFluxThres, fluxStringThres]= ...
%                   getNetworkFluxThreshold(networkFluxTemp, fluxStringTemp, -1);

  networkFluxThres= networkFluxTemp;
  fluxStringThres= fluxStringTemp;
  
  %%

  %range_string= 1:numel(fluxStringThres);

  %%
  
  if (lenGenomSubstrate > 1)
    % such that we do not have duplicate names, e.g.
    % maize->digester and maize->digester become
    % maize->digester_1 and maize->digester_2
    
    for iel= 1:numel(fluxStringThres)

      str_temp= fluxStringThres(iel);

      fluxStringThres(iel)= {[str_temp{:}, '_', num2str(iel)]};

    end
  end

  %%

  fit_fun_str= func2str( fitness_function );

  %%

  plant_id= char(plant.id);

  %%

  if ( strcmp( fit_fun_str , ...
               func2str( @fitness_calibration) ) )

    %%  
    % versuchen in fluxStringThres und networkFluxThres
    % in opt. problem benutzte parameter des adm1 zu schreiben

    %popBiogas= evalin('base', 'popBiogas');

    [networkFluxThres, fluxStringThres]= get_ADM_params_out_of_file(plant);
    
    %% 
    %
    %u= popBiogas.conObj.conUB ./ 2;

    %p_opt= popBiogas.getADM1ParamsFromIndividual(u, plant);

%     p_opt= load_file( sprintf('adm1_params_opt_%s.mat', plant_id) );
% 
%     fluxStringThres= {''};
%     networkFluxThres= zeros(1, plant.getNumDigestersD());
% 
%     for ifermenter= 1:plant.getNumDigestersD()
% 
%       fermenter_id= char(plant.getDigesterID(ifermenter));
% 
%       nparams= numel( p_opt.(fermenter_id) );
% 
%       for iparam= 1:nparams
% 
%         networkFluxThres(1, (ifermenter - 1)*nparams + iparam)= ...
%                        p_opt.(fermenter_id)(iparam,1);
% 
%         fluxStringThres= {fluxStringThres{:}, ...
%                           sprintf('p%i_%s', ...
%                           0*(ifermenter - 1)*nparams + iparam, ...
%                           fermenter_id)}; 
% 
%       end
% 
%     end
% 
%     % kick out first empty entry {''}
%     fluxStringThres= fluxStringThres(2:end);

  end


  %%
  % eine fitness funktion sollte immer fitness_name lauten

  fit_fun_str= regexp(fit_fun_str, '(\w+)_', 'split');

  fit_fun_str= char(fit_fun_str(1,end));

  fit_fun_str= fit_fun_str(1, 1 : min( 10, size(fit_fun_str,2) ) );

  database_file= ['equilibria_', plant_id, '_', fit_fun_str];

  %%

  % only the flux > 0 is written into the database
  writetodatabase(database_file, fluxStringThres, ...
              networkFluxThres, plant, substrate, fitness_params, ...
              fitness_function, [], [], [], [], sensors, use_history, init_substrate_feed);



  %%

  fprintf('passed fitness: %.3f\n', fitness);

else

  fprintf('failed sim fitness: %.3f\n', fitness / threshold_fitness_after_sim);

  database_file= '';
  
  %% TODO
  % why is this done here? and why at all?
  % if I do not do it, the recirculations are missing in the network_flux
  % but I do no know why?
  
  equilibrium.network_flux= networkFlux;
  equilibrium.network_flux_string= fluxString;
  
end


%%
% if not close model in simbiogasplant, then close it here
% but only if running in parallel mode

if ~closeModel && (nWorker > 1)
  save_system(fcn);

  close_system(fcn);

  save([fcn, '.mat'], 'fcn');
end

%%

if nargout >= 3,
  varargout{1}= database_file;
end

%%


