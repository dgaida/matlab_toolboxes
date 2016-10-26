%% fitness_calibration
% Calculate the fitness of the models actual state during a simulation.
%
function [fitness, varargout]= ...
          fitness_calibration(plant, substrate, fitness_params)
%% Release: 0.6

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, nargout, nargout, 'struct') );

%%
% check arguments

is_plant(plant, '1st');
is_substrate(substrate, '2nd');
checkArgument(fitness_params, 'fitness_params', 'struct', '3rd');

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

[SS_COD_fitness, VS_COD_fitness, ...
SS_COD_degradationRate, VS_COD_degradationRate, ...
pHWert_fitness, FOS_TAC_fitness, ...
TS_fitness, VFA_fitness, TAC_fitness, OLR_fitness, HRT_fitness, ...
N_fitness, Stability_punishment, ...
energyBalance, energyProd_fitness, ...
energyConsumption, energyThermProduction, energyProduction, ...
sellCurrent]= ...
     getFitnessRelatedTerms(sensors, plant, substrate, fitness_params);


%%

n_fermenter= plant.getNumDigestersD();

%%

biogas_digester= zeros(1, n_fermenter);%NET.createArray('science.physValue', n_fermenter);

%%

for ifermenter= 1:n_fermenter

  %%
  
  fermenter_id= char( plant.getDigesterID(ifermenter) );
 
  
  %%

  biogas_digester(ifermenter)= ...
    sensors.getCurrentMeasurementD(['biogas_', fermenter_id], '', 'biogas_m3_d');
  
%   biogas_v= sensors.getCurrentMeasurementVector(['biogas_', fermenter_id]);
%   
%   biogas_digester(ifermenter)= ...
%          biogas_v.Get(0).Value + biogas_v.Get(1).Value + biogas_v.Get(2).Value;

  
  %%
  
end

%%

%biogas_digester= double( science.physValue.getValues( biogas_digester ) );


%%
% Calculation of methane amount in Biogas

biogas_v= sensors.getCurrentMeasurementVector('total_biogas_');

methaneConcentration= biogas_v.Get(2).Value;

h2Concentration= biogas_v.Get(1).Value;

%plant_model.getValue('biogas_total_percentage', '3:3');

%%
% Calculation of biogas production

%biogasProduction= biogas_v.Get(0).Value;
%plant_model.getValue('biogas_total', '2:2');

%%
% Calculation of exceeded biogas production

%% 
%biogasExcess= biogas_v.Get(biogas_v.Length - 1).Value;
%plant_model.getValue('biogas_total', '3:3');


%%

ref_gas_bhkw1= load_file('reference_gas_stream_bhkw1.mat');
ref_gas_bhkw2= load_file('reference_gas_stream_bhkw2.mat');

ref_gas= ref_gas_bhkw1 + ref_gas_bhkw2;

%%

sim_gas= double(sensors.getMeasurementStream('total_biogas_'));
%measurements.biogas.total_biogas(2,:);

% resample sim_gas on days

sim_t= double(sensors.getTimeStream('total_biogas_'));
%measurements.biogas.total_biogas(1,:);

t_sample= [min(sim_t):1:max(sim_t)];

%

if numel(t_sample) > 3

  sim_gas= interp1(sim_t, sim_gas, t_sample, 'linear');
  ref_gas= interp1(ref_gas(1,:), ref_gas(2,:), t_sample, 'linear');

  %%

  steps= min( size(sim_gas, 2), size(ref_gas, 2));

  % first time step is 0, so start with 2
%   diff_gas= numerics.math.calcNormalizedRMSE( sim_gas(2:steps), ...
%                                               ref_gas(2,2:steps) );

  diff_gas= calcModifiedNashSutcliffeCoeff( ref_gas(2:steps), ...
                                            sim_gas(2:steps) );
                                            
                                          
  %%
  % ch4 in % 
  ref_ch4_orig= load_file('reference_ch4_total_p.mat');

  %%
  
  % 0 based index. 0: total biogas, 1: h2 ppm, 2: ch4 %, ...
  sim_ch4= double(sensors.getMeasurementStream('total_biogas_', 2));
  %measurements.biogas.total_percentage(3,:);

  % resample

  sim_ch4= interp1(sim_t, sim_ch4, t_sample, 'linear');
  ref_ch4= interp1(ref_ch4_orig(1,:), ref_ch4_orig(2,:), t_sample, 'linear');

  steps= min( size(sim_ch4, 2), size(ref_ch4, 2));

  %%
  % TODO
  %
  % evtl. anstatt differenz von ch4 in % differenz in m3/d bilden,
  % allerdings hängt das auch von der messung vor ort ab
  %
%   diff_ch4= numerics.math.calcNormalizedRMSE( sim_ch4(2:steps), ...
%                                               ref_ch4(2,2:steps) );

  diff_ch4= calcModifiedNashSutcliffeCoeff( ref_ch4(2:steps), ...
                                            sim_ch4(2:steps) );
                                            
                                          
  %%
  % h2 in ppm 
  ref_h2= load_file('reference_h2_total_ppm.mat');

  %%
  
  % 0 based index. 0: total biogas, 1: h2 ppm, 2: ch4 %, ...
  sim_h2= double(sensors.getMeasurementStream('total_biogas_', 1));
  %measurements.biogas.total_percentage(3,:);

  % resample

  sim_h2= interp1(sim_t, sim_h2, t_sample, 'linear');
  ref_h2= interp1(ref_h2(1,:), ref_h2(2,:), t_sample, 'linear');

  steps= min( size(sim_h2, 2), size(ref_h2, 2));

  %%
  % diff of h2 in ppm
%   diff_h2= numerics.math.calcNormalizedRMSE( sim_h2(2:steps), ...
%                                              ref_h2(2,2:steps) );
                                           
  diff_h2= calcModifiedNashSutcliffeCoeff( ref_h2(2:steps), ...
                                           sim_h2(2:steps) );
                                          
                                                    
  %%

  ref_power_bhkw1= load_file('reference_power_bhkw_1.mat');
  ref_power_bhkw2= load_file('reference_power_bhkw_2.mat');

  ref_power= ref_power_bhkw1 + ref_power_bhkw2;

  %%

  sim_power= 0;

  for ibhkw= 1:plant.getNumCHPsD()

    bhkw_name= char( plant.getCHPID(ibhkw) );

    %%
    % electrical energy production [kWh/d]

    sim_power= sim_power + ...
               double(sensors.getMeasurementStream(['energyProduction_', bhkw_name]));
    %energy.produced.(bhkw_name).energy(2,:);

  end

  %%

  sim_power= interp1(sim_t, sim_power, t_sample, 'linear');
  ref_power= interp1(ref_power(1,:), ref_power(2,:), t_sample, 'linear');

  steps= min( size(sim_power, 2), size(ref_power, 2));

%   diff_power= numerics.math.calcNormalizedRMSE( sim_power(2:steps), ...
%                                                 ref_power(2,2:steps) );

  diff_power= calcModifiedNashSutcliffeCoeff( ref_power(2:steps), ...
                                              sim_power(2:steps) );

  %%
  
  diff_FOS_TACs= 0;
  diff_VFAs= 0;
  diff_Sacs= 0;
  diff_Spros= 0;
  diff_Sbus= 0;
  diff_Svas= 0;
  diff_TACs= 0;

  %%
  
  for ifermenter= 1:n_fermenter

    %%
  
    fermenter_id= char( plant.getDigesterID(ifermenter) );
 
    %%
    
    if exist(fullfile(pwd, sprintf('reference_%s_probes.mat', fermenter_id)), 'file')
      
      %%
      % time
      % Sac [g/l]
      % Spro [g/l]
      % Sbu [g/l]
      % Sva [g/l]
      % SHAceq [g/l]
      % TAC [g/l]
      % VFA/TAC []
      %
      ref_probes= load_file( sprintf('reference_%s_probes.mat', fermenter_id) );

      %%

      FOS_TAC= double(sensors.getMeasurementStream(['VFA_TAC_', fermenter_id]));

      diff_FOS_TACs= diff_FOS_TACs + calcDiffFitness(FOS_TAC, 8, ...
                                     sim_t, t_sample, ref_probes);

      clear FOS_TAC;

      %%

      VFA= double(sensors.getMeasurementStream(['VFA_', fermenter_id, '_3']));

      diff_VFAs= diff_VFAs + calcDiffFitness(VFA, 6, ...
                                             sim_t, t_sample, ref_probes);

      clear VFA;

      %%

      Sac= double(sensors.getMeasurementStream(['VFAmatrix_', fermenter_id, '_3'], '', 'Sac'));

      diff_Sacs= diff_Sacs + calcDiffFitness(Sac, 2, ...
                                             sim_t, t_sample, ref_probes);

      clear Sac;
      
      %%
      
      Spro= double(sensors.getMeasurementStream(['VFAmatrix_', fermenter_id, '_3'], '', 'Spro'));

      diff_Spros= diff_Spros + calcDiffFitness(Spro, 3, ...
                                               sim_t, t_sample, ref_probes);

      clear Spro;

      %%

      Sbu= double(sensors.getMeasurementStream(['VFAmatrix_', fermenter_id, '_3'], '', 'Sbu'));

      diff_Sbus= diff_Sbus + calcDiffFitness(Sbu, 4, ...
                                             sim_t, t_sample, ref_probes);

      clear Sbu;

      %%
      
      Sva= double(sensors.getMeasurementStream(['VFAmatrix_', fermenter_id, '_3'], '', 'Sva'));

      diff_Svas= diff_Svas + calcDiffFitness(Sva, 5, ...
                                             sim_t, t_sample, ref_probes);
      
      clear Sva;

      %%
      
      TAC= double(sensors.getMeasurementStream(['TAC_', fermenter_id, '_3']));

      diff_TACs= diff_TACs + calcDiffFitness(TAC, 7, ...
                                             sim_t, t_sample, ref_probes);
      
      clear TAC;

      %%
      
    end
    
  end
  
  %%
  
  
  
  %%
  % stopping criteria

  if ( size(sim_ch4, 2) >= size(ref_ch4_orig, 2) )
      set_param(bdroot, 'SimulationCommand', 'stop');
  end

else

  diff_gas= 0;
  diff_ch4= 0;
  diff_power= 0;
  diff_h2= 0;

  diff_FOS_TACs= 0;
  diff_VFAs= 0;
  diff_Sacs= 0;
  diff_Spros= 0;
  diff_Sbus= 0;
  diff_Svas= 0;
  diff_TACs= 0;
  
end

%%
% early stopping criterion

stop_simulation= 0;

aceto_ratio= 70 .* ones(n_fermenter,1);

%%

if double( sensors.getCurrentTime() ) > 10

  %%
  
  mean_FOSTACs= 0;
  
  for ifermenter= 1:n_fermenter
      
    fermenter_id= char( plant.getDigesterID(ifermenter) );

    FOS_TACs= double(sensors.getMeasurementStream(['VFA_TAC_', fermenter_id]));

    mean_FOSTACs= max(mean_FOSTACs, median(FOS_TACs));
    
    %%
    % should be 70 % / 30 %
    [aceto_ratio(ifermenter)]= calc_aceto_hydro_ratio(sensors, plant, fermenter_id);
        
    %%
  
  end
  
  if mean_FOSTACs > 1.1 || any(aceto_ratio < 50) || any(aceto_ratio > 95) ...% < 40 %, usually 70 %
     || stop_simulation == 1
    stop_simulation= 1;
  else
    mean_FOSTACs= 0;
  end
  
  %%
  
else
  
  mean_FOSTACs= 0;
  %aceto_ratio= 70;
  
end

%%

fitness= fitness_params.w_pH * pHWert_fitness + ...
         fitness_params.w_CH4 * (methaneConcentration < 45) + ...
         ...10 * diff_gas + 10 * diff_ch4 + 10 * diff_power + 0.1 * diff_h2 + ...
         diff_gas + diff_ch4 + diff_power + diff_h2 + ...
         diff_FOS_TACs + diff_VFAs + diff_Sacs + diff_Spros + ...
         0.05 * diff_Sbus + 0.01 * diff_Svas + 0.05 * diff_TACs + 1.0 .* (mean_FOSTACs > 1.1) + ...
         1.0 .* any(aceto_ratio < 50) + ...
         1.0 .* any(aceto_ratio > 95) + ...
         2 * (h2Concentration > 10000); % ppm == 1 %

%%

if double( sensors.getCurrentTime() ) > 10

  if fitness > 200 || stop_simulation == 1 ...0 
     || methaneConcentration < 10 || ...
     h2Concentration > 50000 % > 5 %
    set_param(bdroot, 'SimulationCommand', 'stop');
  end
  
end

%%
% normiere fitness zwischen 0 und 1     
%fitness= fitness / 20;

%%

if nargout >= 3

  %% TODO
  %% TEST
  
  filename= sprintf('test%i.mat', fix(100 * rand(1)));
  save(filename, 'sim_gas', 'sim_ch4', 'sim_power', 'sim_h2', 'fitness');
  
  %%
  
  simtime= double( sensors.getCurrentTime() );

  %%
  
  [sensorsData, sensorsSymbolsUnits]= getCurrentSensorMeasurements(sensors);
  
  %%
  
  data= [simtime, SS_COD_degradationRate, VS_COD_degradationRate, ...
         energyConsumption, energyProduction, ...biogasExcess, ...
         ...methaneConcentration, ...
         ...biogasProduction, ...
         sensorsData, ...
         biogas_digester, ...
         ...substrate_costs, ...
         SS_COD_fitness, VS_COD_fitness, pHWert_fitness, ...
         FOS_TAC_fitness, VFA_fitness, TAC_fitness, ...
         OLR_fitness, HRT_fitness, N_fitness, ...
         energyProd_fitness, ...
         TS_fitness, ...
         (methaneConcentration < 50), ...
         (VS_COD_degradationRate < 65), ...
         energyConsumption * plant.myFinances.priceElEnergy.Value, ...
         energyProduction * sellCurrent + ...
         energyThermProduction * plant.myFinances.revenueTherm.Value, ...
         Stability_punishment, ...
         diff_gas, diff_ch4, diff_power, diff_h2, ...
         diff_FOS_TACs, diff_VFAs, diff_Sacs, diff_Spros, ...
         diff_Sbus, diff_Svas, diff_TACs, mean_FOSTACs, ...
         energyBalance];

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
  data_string= [{'simtime', 'SS_degradation', 'XS_degradation'}, ...
                 {'energyConsumption', 'energyProduction'..., ...
                 ...'biogasExcess', ...
                 ...'methaneConcentration', ...
                 ...'biogasProduction'
                 }, ...
                 sensorsSymbolsUnits', ...
                 biogas_digester_cell', ...
                 {'SS_COD_fitness', 'VS_COD_fitness', 'pHWert_fitness', ...
                  'FOS_TAC_fitness', 'VFA_fitness', 'TAC_fitness', ...
                  'OLR_fitness', 'HRT_fitness', 'N_fitness', ...
                  'elEnergy_fitness', ...
                  'TS_fitness', ...
                  'CH4_fitness', 'VS_degrade_fitness', ...
                  'cost_E_per_day', 'yield_E_per_day', ...
                  'Stability_punishment', ...
                  'rmse_gas', 'rmse_ch4', 'rmse_power', 'rmse_h2', ...
                  'diff_FOS_TACs', 'diff_VFAs', 'diff_Sacs', 'diff_Spros', ...
                  'diff_Sbus', 'diff_Svas', 'diff_TACs', 'mean_FOSTACs', ...
                  'energyBalance'}];

  varargout{2}= data_string;

elseif nargout == 2
    error(['You cannot call this function with 2 output arguments. ', ... 
           'Call it either with 1 or at least 3 output arguments']);
end

%%

    
    