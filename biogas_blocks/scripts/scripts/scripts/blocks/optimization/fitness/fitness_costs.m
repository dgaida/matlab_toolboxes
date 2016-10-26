%% fitness_costs
% Calculate the fitness of the models actual state during a simulation.
%
function [fitness, varargout]= fitness_costs(plant, substrate, fitness_params)
%% Release: 1.0

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, nargout, nargout, 'struct') );

%%
% check arguments

is_plant(plant, '1st');
is_substrate(substrate, '2nd');
is_fitness_params(fitness_params, '3rd');

%%
% the fitness of the state only depends on measurments and the produced
% energy

%%

try
  sensors= evalinMWS('sensors');
catch ME
  rethrow(ME);
end


%%
[Stability_punishment, ...
energyBalance, energyProd_fitness, ...
energyConsumption, energyThConsumptionHeat, energyConsumptionPump, ...
energyConsumptionMixer, energyProdMicro, ...
moneyEnergy, fitness_constraints, fitness]= ...
     biooptim.objectives.getObjectives(sensors, plant, substrate, fitness_params);

%%
% must be a row vector - yes it is!

fitness= double(fitness);

%%

n_fermenter= plant.getNumDigestersD();

%%

biogas_digester= zeros(1, n_fermenter);

%%

for ifermenter= 1:n_fermenter

  %%
  
  fermenter_id= char( plant.getDigesterID(ifermenter) );
  
  %%

  biogas_digester(ifermenter)= ...
    sensors.getCurrentMeasurementD(['biogas_', fermenter_id], '', 'biogas_m3_d');
         
  %%
  
end


%% TODO
% anstatt biogasExcess / 20000
% prüfen ob biogasExcess > 10 % der max. zu verarbietenden Biogasmenge,
% d.h. > 110 % produzierte biogasmenge isngesamt, dann mit 1 * gewicht
% bestrafen 

%%
% lossBiogasExcess measured in €/d
%energyBalance= energyBalance + lossBiogasExcess / 1000; % tausend € / d   


%%

if nargout >= 3

  %%
  
  simtime= double( sensors.getCurrentTime() );

  %%
  
  [sensorsData, sensorsSymbolsUnits]= getCurrentSensorMeasurements(sensors);
  
  %%
  
  data= [simtime, ...SS_COD_degradationRate, VS_COD_degradationRate, ...
         energyConsumption, energyThConsumptionHeat, energyConsumptionPump, ...
         energyConsumptionMixer, energyProdMicro, ...
         sensorsData, biogas_digester, energyProd_fitness, ...
         energyConsumption * plant.myFinances.priceElEnergy.Value, ...
         moneyEnergy, Stability_punishment, ...
         energyBalance, fitness_constraints];

  varargout{1}= numerics.math.round_float( data, 3 );


  %%

  try
    digester_ids= evalinMWS('digester_ids', 0);
  catch ME
    rethrow(ME);
  end

  %%

  biogas_digester_string= [repmat('biogas_', n_fermenter, 1), ...
              char(digester_ids)];

  biogas_digester_cell= cellstr(biogas_digester_string);


  %%
  data_string= [{'simtime'}, ...'SS_degradation', 'XS_degradation'}, ...
                 {'energyConsumption_kWh_d', 'energyThConsumptionHeat_kWh_d', 'energyConsumptionPump_kWh_d', ...
                  'energyConsumptionMixer_kWh_d', 'energyProdMicro_kWh_d'}, ...
                 sensorsSymbolsUnits', biogas_digester_cell', ...
                 {'elEnergy_fitness', 'cost_E_per_day', 'yield_E_per_day', ...
                  'Stability_punishment', 'energyBalance_kE_d', ...
                  'fitness_constraints'}];

  varargout{2}= data_string;

elseif nargout == 2
  error(['You cannot call this function with 2 output arguments. ', ... 
         'Call it either with 1 or at least 3 output arguments']);
end

%%    
  

