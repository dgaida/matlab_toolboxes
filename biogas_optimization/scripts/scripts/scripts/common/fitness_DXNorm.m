%% fitness_DXNorm
% Fitness function to minimize DXNorm
%
function fitness= fitness_DXNorm(x, plant, plant_network, goal_variables, LB, UB)
%% Release: 1.3

%%

error( nargchk(6, 6, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check input params

validateattributes(x, {'double'}, {'2d'}, mfilename, 'individual',  1);

is_plant(plant, '2nd');
is_plant_network(plant_network, 3, plant);
checkArgument(goal_variables, 'goal_variables', 'cellstr', 4);

plant_id= char(plant.id);

%%
% with PSO a Individual consists out of many individuals -> the swarm
% CMAES is similar

uswarm= x;

% uswarm is always a row vector, in case it is a swarm, then it is a
% matrix, where the number of rows define the size of the swarm

% only SO optimization is used here
fitness= zeros(size(uswarm, 1), 1);

%%

fcn= ['plant_', plant_id];

%%

equilibrium= defineEquilibriumStruct(plant, plant_network);

n_digester= plant.getNumDigestersD();

%%

for iIndividual= 1:size(uswarm, 1)

  %%
  % first 37 components for digester1, then 37 comp. for digester2
  % the values are measured in the default measurement unit, thus g/l, etc.
  xnorm= uswarm(iIndividual, :);

  %%
  % denormalize x. it is normalized in findMinDXNorm
  
  x= xnorm .* ( UB - LB ) ./ 10 + LB;
  x= x(:)';
  
  %%
  
  x= reshape(x, biogas.ADMstate.dim_state, n_digester);

  %%

  x_new= zeros(size(x));

  for idigester= 1:n_digester
 
    for iel= 1:numel( x(:,idigester) )
      % fromUnit ist default measurement unit -> OK!
      % toUnit ist getUnitOfADMstatevariable(), das ist die einheit in der
      % adm1 modell seine zustandsvariablen misst
      x_new(iel,idigester)= ...
        getVectorOutOfStream(x(:,idigester), goal_variables{iel}, [], [], [], ...
                          getDefaultMeasurementUnit(goal_variables{iel}), ...
                          char(biogas.ADMstate.getUnitOfADMstatevariable(iel)));
    end

    fermenter_id= char( plant.getDigesterID(idigester) );
  
    equilibrium.fermenter.(fermenter_id).x0= x_new(:, idigester);
    
  end
    
  %%
  % set equilibrium in workspace
  
  % es wird angenommen, dass Substratzufuhr noch in model workspace des
  % modells steht...
  % die annhame geht nicht mehr, da wir hier mit dem modell in dem
  % überordner arbeiten und nicht mit dem modell aus dem uo mpc.
  
  setInitStateInWorkspace(equilibrium, plant, plant_network, 'default');
 
  % deshalb kopiere volumeflow files aus UO mpc in aktuellen ordner
  % nein mahce ich nicht. in NMPC_TmrFcn wird const volumeflow aus
  % aktuellem equilibrium geholt und in const volumeflow files geschrieben.
  % das const feed was ich hier aus UO mpc holen könnte, wäre nicht das
  % richtige. sondern das wäre der finale feed, falls mehrere feeds über Tc
  % bestimmt werden. 
  %copy_volumeflow_files(plant_id, 'mpc', pwd, 'const');
  
  %%
  % set volumeflow type to const
  % the plant must be load therefore. it is already load in findMinDXNorm
  
  set_volumeflow_type(fcn, 'const');

  %%

  try
    fitness(iIndividual,1)= calcDXNorm(fcn);
  catch ME
    close_biogas_system(fcn);

    rethrow(ME);
  end
  
  %%

end

%%

save('fit_DXNorm.mat', 'fitness');

%%


