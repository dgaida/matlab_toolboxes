%% biogasM.optimization.popBiogas.getIndividualFromEquilibrium
% Get the individual from the equilibrium.
%
function u= getIndividualFromEquilibrium(obj, equilibrium, plant)
%% Release: 1.4

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check function arguments

is_equilibrium(equilibrium, '2nd');
is_plant(plant, '3rd');

%% 
% set lenGenom as parameter

lenGenomSubstrate= obj.pop_substrate.lenGenom;

%% TODO
% sometime in the future add param lenGenomPump to class popPlant...

lenGenomPump= 1;


%%
% get individual for substrate flow

%%
%

length_substrate= ...
        numel(obj.pop_substrate.substrate_network_max);

dataForIndividual= ...
            equilibrium.network_flux( 1, 1:length_substrate * lenGenomSubstrate )';

uNetworkSubstrateFlux= ...
    getIndividualByMask(obj, length_substrate * lenGenomSubstrate, ...
    obj.pop_substrate.substrate_ineq(:, 1:end - 1), ...
    obj.pop_substrate.substrate_eq(:, 1:end - 1), ...
    obj.pop_substrate.substrate_network_min, ...
    obj.pop_substrate.substrate_network_max, ...
    dataForIndividual, lenGenomSubstrate);

%%
% get individual for pump flow

length_plant= ...
        numel(obj.pop_plant.plant_network_max);

uNetworkPlantFlux= ...
    getIndividualByMask(obj, length_plant * lenGenomPump, ...
    obj.pop_plant.plant_ineq(:, 1:end - 1), ...
    obj.pop_plant.plant_eq(:, 1:end - 1), ...
    obj.pop_plant.plant_network_min, ...
    obj.pop_plant.plant_network_max, ...
    ones(length_plant * lenGenomPump,1), lenGenomPump);

len_u_plant= numel(uNetworkPlantFlux);

uNetworkPlantFlux= ...
    equilibrium.network_flux( 1, ...
    length_substrate * lenGenomSubstrate + 1:...
    length_substrate * lenGenomSubstrate + len_u_plant);

%%
% get individual from digester state

n_fermenter= plant.getNumDigestersD();

% hänge die Zustände der Fermenter hintereinander
for ifermenter= 1:n_fermenter

  fermenter_name= char(plant.getDigesterID(ifermenter));

  uState(1 + (ifermenter - 1) * biogas.ADMstate.dim_state: ...
                                biogas.ADMstate.dim_state * ifermenter, 1)= ...
             equilibrium.fermenter.( fermenter_name ).x0;

end

length_state= numel(uState);

uDigesterState= ...
    getIndividualByMask(obj, length_state, ...
    obj.pop_state.state_ineq(:, 1:end - 1), ...
    obj.pop_state.state_eq(:, 1:end - 1), ...
    obj.pop_state.digester_state_min, ...
    obj.pop_state.digester_state_max, ...
    uState);

%% 
% set individual by concatenating the individuals

u= [uNetworkSubstrateFlux; uNetworkPlantFlux; uDigesterState]';


%%

u= getPointsInConstrainedDimension(obj.conObj, u);

%%


