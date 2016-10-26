%% getInitPopOfEquilibria
% Get the initial population for an optimization problem, which tries to 
% minimize a fitness defined in a simulation model created with the library
% of the 'Biogas Plant Modeling' toolbox.
%
function equilibria= getInitPopOfEquilibria(plant_id, varargin)
%getInitPopOfEquilibria    Get the initial population for an optimization
%                          problem.
%
%   getInitPopOfEquilibria gets the initial population for an optimization
%       problem, which tries to minimize a fitness defined in a simulation
%       model created with the library of the 'Biogas Plant Modeling'
%       toolbox. 
%
%   equilibria= getInitPopOfEquilibria(plant_id)
%   
%   equilibria= getInitPopOfEquilibria(plant_id, parallel)
%
%   equilibria= getInitPopOfEquilibria(plant_id, parallel, nWorker)
%
%   equilibria= getInitPopOfEquilibria(plant_id, parallel, nWorker,
%   setting) 
%
%   Example:
%
%   |equilibria= getInitPopOfEquilibria('sunderhook', 'multicore', 4)|
%
%   |equilibria= getInitPopOfEquilibria('sunderhook', [], [], 'setCalib')|
%
%   See also FINDOPTIMALEQUILIBRIUM, SIMBIOGASPLANT
%
%   Copyright 2009-2012 Daniel Gaida
%   $Revision: 0.9 $  $Date: 2012/05/02 15:33:38 $

%% Release: 0.9

%% 

tic

%%

error( nargchk(1, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );


%%
% read out varargin

if nargin > 1 && ~isempty(varargin{1}), 
  parallel= varargin{1}; 
  validatestring(parallel, {'none', 'multicore', 'cluster'}, mfilename, 'parallel', 2);
else
  parallel= 'none';
end

if nargin > 2 && ~isempty(varargin{2}), 
  nWorker= varargin{2}; 
  isN(nWorker, 'nWorker', 3);
else
  nWorker= 2; 
end;

if strcmp(parallel, 'none')
  nWorker= 1;
end

if nargin >= 4
  setting= varargin{3}; % option for load_biogas_mat_files
  checkArgument(setting, 'setting', 'char', '4th');
else
  setting = [];
end

%%

checkArgument(plant_id, 'plant_id', 'char', '1st');

%% TODO 
% implement the cluster option and then erase these 3 lines

if ( strcmp(parallel, 'cluster') )   
  error(['Sorry, but this function is not yet implemented for ', ...
         'the option ', parallel]);
end

    
%% 
% load struct files

[substrate, plant, substrate_network, plant_network, ...
 substrate_network_min, substrate_network_max, ...
 plant_network_min, plant_network_max, ...
 digester_state_min, digester_state_max, params_min, params_max, ...
 substrate_eq, substrate_ineq, fitness_params]= ...
          load_biogas_mat_files(plant_id, setting);
                            
                            

%% TODO
% implement further linear and nonlinear equality and inequality
% constraints 
% (Bsp. Ungleichung für Güllebonus, nichtlin. Ungleichung für pH-Wert,
% beide erledigt) 



%%
% load the model(s)

fcn= ['plant_', plant_id];

load_biogas_system(fcn, parallel, nWorker);



%% 
% set some variables

n_substrate_mix= 1;%50;%0;%000;

n_eq_per_substrate_mix= 2;%2;%5;%00;

threshold_fitness_after_sim= 12.85;

timespan= [0 750];



%%
%

try

  equilibria= evalin('base', 'equilibria');

catch ME

  equilibria= defineEquilibriumStruct(plant, plant_network);

  assignin('base', 'equilibria', equilibria);

end



%% 
% set bounds for individual
[popBiogas]= biogasM.optimization.popBiogas(0, ...
                    substrate_network_min, substrate_network_max, ...
                    plant_network_min, plant_network_max, ...
                    digester_state_min, digester_state_max, ...
                    params_min, params_max, ...
                    substrate_ineq, substrate_eq, ...
                    ...%@(u)nonlcon_substrate(u, plant, substrate, @obj, 30), ...
                    @(obj)@(u)nonlcon_substrate(u, plant, substrate, ...
                                        obj, fitness_params.TS_feed_max), ...
                    ...@(u,obj)nonlcon_substrate(u, plant, substrate, obj, 30), ...
                    [], [], @nonlcon_plant, ...
                    [], [], [], ...
                    @(u)nonlcon_params(u), ...
                    parallel, nWorker);
        
%%

[popBiogas]= biogasM.optimization.popBiogas(...
                    [n_substrate_mix,0,n_eq_per_substrate_mix], ...
                    substrate_network_min, substrate_network_max, ...
                    plant_network_min, plant_network_max, ...
                    digester_state_min, digester_state_max, ...max
                    params_min, params_max, ...
                    substrate_ineq, substrate_eq, ...
                    @(u)nonlcon_substrate(u, plant, substrate, ...
                            popBiogas, fitness_params.TS_feed_max), ...
                    [], [], @(u)nonlcon_plant(u), ...
                    [], [], [], ...
                    ...@(x)digester_state_nonlcon(x, ...
                    ...popBiogas, plant, substrate, plant_network, ...
                    ...fitness_params.pH_min, fitness_params.pH_max, ...
                    ...fitness_params.CH4_min, fitness_params.CH4_max, ...
                    ...fitness_params.CO2_min, fitness_params.CO2_max, ...
                    ...fitness_params.xdot_norm), ...
                    @(u)nonlcon_params(u), ...
                    parallel, nWorker);
   
% [UB_individual, LB_individual, lenIndividualFlux, ...
%  substrate_network_min, substrate_network_max, ...
%  eq_for_individual, ineq_for_individual]= getBoundsForIndividual(...
%                             plant_network_min, plant_network_max, ...
%                             substrate_network_min, substrate_network_max, ...
%                             digester_state_min, digester_state_max, ...
%                             substrate_eq, substrate_ineq);


%save popBiogas popBiogas;

%toc

%return;

%%

% LB_individual= getLB(popBiogas);
% UB_individual= getUB(popBiogas);
% 
% lenIndividualFlux= ...
%     popBiogas.pop_substrate.nCols + popBiogas.pop_plant.nCols;
%                                      
                                     
%% 
% create the population to try

% nvars= length(UB_individual);
% pop_size= n_substrate_mix;
% 
% [u, fitness, varargout]= startGA([], nvars, ...
%                                      LB_individual, ...
%                                      UB_individual, [], pop_size, ...
%                                      1, [], [], ...
%                                      eq_for_individual, ...
%                                      ineq_for_individual);
%                                  
% population= varargout{3};
% 
% 
% 
% individual_flux(1:n_substrate_mix,1:lenIndividualFlux)= ...
%     ones(n_substrate_mix, lenIndividualFlux) * diag( LB_individual(1,1:lenIndividualFlux) ) + ...
%     rand(n_substrate_mix, lenIndividualFlux) * ...
%     diag( UB_individual(1,1:lenIndividualFlux) - LB_individual(1,1:lenIndividualFlux) );
%         
% for isubstrate= 1:n_substrate_mix
%     
%     individual_flux(isubstrate, :)= checkIndividualForConstraints( ...
%                                     individual_flux(isubstrate, :), ...
%                                     eq_for_individual, ...
%                                     ineq_for_individual, ...
%                                     LB_individual(1,1:lenIndividualFlux), ...
%                                     UB_individual(1,1:lenIndividualFlux) );
%     
% end
% 
% individual_flux= repmat(individual_flux, n_eq_per_substrate_mix, []);
% 
% individual_flux= sortrows(individual_flux, 1);
% 
% individual_state(1:n_eq_per_substrate_mix,1:size(UB_individual, 2) - lenIndividualFlux)= ...
%     ones(n_eq_per_substrate_mix, size(UB_individual, 2) - lenIndividualFlux) * ...
%     diag( LB_individual(1,lenIndividualFlux + 1:size(UB_individual, 2)) ) + ...
%     rand(n_eq_per_substrate_mix, size(UB_individual, 2) - lenIndividualFlux) * ...
%     diag( UB_individual(1,lenIndividualFlux + 1:size(UB_individual, 2)) - ...
%           LB_individual(1,lenIndividualFlux + 1:size(UB_individual, 2)) );
%         
% individual_state= repmat(individual_state, n_substrate_mix, []);
% 
% individual= [individual_flux, individual_state];


individual= popBiogas.conObj.conData;


%% 
% for each substrate mix

iIndividual= -n_eq_per_substrate_mix;

if strcmp( parallel, 'multicore' )
  matlabpool( 'open', nWorker );
end

%%

for isubstrate_mix= 1:n_substrate_mix

  %%
  
  iIndividual= iIndividual + n_eq_per_substrate_mix;

  equilibrium= popBiogas.getEquilibriumFromIndividual(...
              individual(iIndividual + 1,:), plant, substrate, ...
              plant_network, 0);

  %%

  if nWorker > 1

    %%
    
    for ilab= 1:nWorker

        fcn_lab= [fcn, '_', sprintf('%i', ilab)];

        close_system(fcn_lab);

        load_system(fcn_lab);

        %% TODO
        % 1,1 
        %
        [substrate_network]= ...
          setNetworkFluxInWorkspace(equilibrium, ...
                            1, 1, substrate, plant, substrate_network);

        save_system(fcn_lab);

    end

  else

    %%
    
    close_biogas_system(fcn);

    %close_system(fcn);

    load_system(fcn);

    %% TODO
    % 1,1 
    %
    [substrate_network]= ...
          setNetworkFluxInWorkspace(equilibrium, ...
                            1, 1, substrate, plant, substrate_network);

    save_system(fcn);

  end



  %% 
  % for each equilibrium

  if nWorker > 1

    parfor ieq= 1:min(n_eq_per_substrate_mix, size(individual,1))

        equilibrium= popBiogas.getEquilibriumFromIndividual(...
                individual(iIndividual + ieq,:), plant, substrate, ...
                plant_network, 0);

        simBiogasPlantExtended(equilibrium, plant, substrate, ...
                                plant_network, substrate_network, ...
                                fitness_params, timespan, 1, nWorker, ...
                                ...%@fitness_wolf_adapted, ...
                                @fitness_calib, ...
                                threshold_fitness_after_sim);

    end

  else

    for ieq= 1:min(n_eq_per_substrate_mix, size(individual,1))

        equilibrium= popBiogas.getEquilibriumFromIndividual(...
                individual(iIndividual + ieq,:), plant, substrate, ...
                plant_network, 0);

        simBiogasPlantExtended(equilibrium, plant, substrate, ...
                                plant_network, substrate_network, ...
                                fitness_params, timespan, 1, nWorker, ...
                                ...%@fitness_wolf_adapted, ...
                                @fitness_calib, ...
                                threshold_fitness_after_sim);

    end

  end
    
end % for isubstrate_mix= 1:n_substrate_mix


%%

if strcmp(parallel, 'none')
  close_biogas_system(fcn);
end


%%

if strcmp( parallel, 'multicore' )
  matlabpool close
end

%%


