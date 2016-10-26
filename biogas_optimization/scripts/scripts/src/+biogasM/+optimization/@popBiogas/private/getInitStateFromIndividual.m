%% biogas.optimization.popBiogas.private.getInitStateFromIndividual
% Gets the initial states of the digesters from the individual
%
function equilibrium= getInitStateFromIndividual(obj, u, plant, plant_network, ...
                            fitness, lenFluxIndividual)
%% Release: 1.4

%%

error( nargchk(6, 6, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

validateattributes(u, {'double'}, {'2d'}, mfilename, 'individual',  1);

is_plant(plant, '2nd');
is_plant_network(plant_network, 3, plant);
checkArgument(fitness, 'fitness', 'double', '4th');

isN0(lenFluxIndividual, 'lenFluxIndividual', 5);

%%

n_fermenter= plant.getNumDigestersD();


%%

digester_state_min= obj.pop_state.digester_state_min;
digester_state_max= obj.pop_state.digester_state_max;


%%
% set state of fermenters

%[dummy, digesterStateMask]= getIndividualByMask( [], ...
 %                           digester_state_min, digester_state_max );

[dummy, digesterStateMask]= getIndividualByMask( obj, [], ...
                            obj.pop_state.state_ineq(:, 1:end - 1), ...
                            obj.pop_state.state_eq(:, 1:end - 1), ...
                            digester_state_min, digester_state_max );

digesterStateMask= reshape(digesterStateMask, ...
                           biogas.ADMstate.dim_state, n_fermenter);

% index in the individual vector u
i_individual= lenFluxIndividual + 1;

%%

for ifermenter= 1:n_fermenter

  fermenter_name= char(plant.getDigesterID(ifermenter));

  %%

  for istate= 1:size(digesterStateMask, 1)

    %%
    
    if digesterStateMask(istate, ifermenter) == 1

      equilibrium.fermenter.( fermenter_name ).x0(istate,1)= ...
                              u(1, i_individual)';

      i_individual= i_individual + 1;

    else

      equilibrium.fermenter.( fermenter_name ).x0(istate,1)= ...
                        digester_state_max(istate, ifermenter);

    end

  end

  %%
  % if total pressure is equal to 0, then set it to 1.
  if equilibrium.fermenter.( fermenter_name ).x0(biogas.ADMstate.pos_pTOTAL, 1) == 0

    equilibrium.fermenter.( fermenter_name ).x0(biogas.ADMstate.pos_pTOTAL, 1)= 1;

  end

end



%% 
% set state of hydraulic delays to default
%
% plant_network= [ 0 1 0 ]
%                [ 1 0 1 ]
%
% das erste - 1, da es aus dem Endlager heraus keine rückführung zu anderen
% fermentern geben soll, ein Endlager hat nur eingänge, das ist inherent in
% der plant_network zu erkennen, da die 3. Reihe im Bsp. oben fehlt.
% 
% die zweite - 1, da angenommen wird, dass in der letzten Spalte der letzte
% fermenter, das heißt der Nachgärer eingetragen ist und flüsse welche in
% den nachgärer gehen im modell nicht als rückführungen modelliert werden.
%
for idigester_in= 1:size(plant_network, 2) - 2

  %%
  
  for idigester_out= idigester_in + 1:size(plant_network, 1)

    %%
    
    if plant_network(idigester_out, idigester_in) > 0

      %%
      
      fermenter_name_start=   char(plant.getDigesterID(idigester_out));

      fermenter_name_destiny= char(plant.getDigesterID(idigester_in));

      defaultState= double(biogas.ADMstate.getDefaultADMstate())';

      % just a dummy to make equilibrium a structure with the
      % correct format
      equilibrium.hydraulic_delay.( ...
          [fermenter_name_start '_' fermenter_name_destiny] ...
          ).x0= defaultState(1:biogas.ADMstate.dim_stream, 1);

    end

  end

end

%%

equilibrium.fitness= fitness;

%%

    
