%% getEquilibriumEstimateOfBiogasPlant
% Estimates current equilibrium of data of real biogas plant
%
function equilibrium= getEquilibriumEstimateOfBiogasPlant(plant_id, ...
  estimator_method, varargin)
%% Release: 0.0

%%
% this function is called in startNMPC and is needed for a real biogas
% plant

%error('to be implemented!')

%% 

narginchk(2, 3);
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1}), 
  postgresql= varargin{1}; 
  
  %% TODO - check argument
else
  postgresql= 1; 
end


%% TODO
% check arguments



%%

[plant, plant_network]= ...
  load_biogas_mat_files(plant_id, [], {'plant', 'plant_network'});


%%
%



%% 
% get data of 4 measurements from DB as well as feed
sensor_data= get4MeasurementsfromDB(plant_id);


%%
% get state estimate. this should work with a real plant and also with a
% simulated one. not yet tested for a real plant
x_hat= getStateEstimateOfBiogasPlant(plant, ...
                                     sensor_data, estimator_method, 1);

%%
% create equilibrium
% feed data is also in sensor_data

equilibrium= defineEquilibriumStruct(plant, plant_network, x_hat);

%% TODO
digester_id= 'tank1';

Qmaizemean= mean(sensor_data.(digester_id).Q.('maize'));
Qmanuremean= mean(sensor_data.(digester_id).Q.('manure'));
Qbiowastemean= mean(sensor_data.(digester_id).Q.('biowaste'));

equilibrium.network_flux= [Qmaizemean, Qmanuremean, Qbiowastemean];

equilibrium.network_flux_string= {'maize', 'manure', 'biowaste'};
         

%% 
% also create sensor_data_estim.mat here
% is also done in NMPC_getEquilibriumFromFiles which is the equivalent to
% this function when using a simulation model only

save(fullfile('..', 'sensor_data_estim.mat'), 'sensor_data');

%%
%% TODO
% get some interesting variables from state vectors (digester, ppostdigester)
% VFA, FOS/TAC, Ac, Pro, NH4-N, ...

% and save them into a table of the postgresql database
% then we can compare them with measured data

for itank= 1:size(x_hat, 2)

  %%
  
  xvec= x_hat(:, itank);
  
  digester_id= plant.getDigesterID(itank);
  
  %% TODO - write function in C# that prints important variables gotten from
  % state vector and print it here. Also biogas production, ch4, co2 conc. 

%   NH4= biogas.ADMstate.calcNH4(xvec, digester_id, plant, 'g/l');
% 
%   %%
%   
%   FOSTAC= biogas.ADMstate.calcFOSTACOfADMstate(xvec);
%   
%   %%
%   
%   pH= biogas.ADMstate.calcPHOfADMstate(xvec);
%   
%   %%
%   
%   TAC= biogas.ADMstate.calcTACOfADMstate(xvec, 'gCaCO3eq/l');
%   
%   %%
% 
%   VFA= biogas.ADMstate.calcVFAOfADMstate(xvec, 'gHAceq/l');
%   
%   %%
%   % get Sac, Spro, Sbu, Sva
%   
%   %%
% 
%   T= science.physValue('T',40);
%   V= science.physValue('V', 1, 'm^3');
%   [qgas_h2, qgas_ch4, qgas_co2, qgas]= ...
%     biogas.ADMstate.calcBiogasOfADMstate(rand(37,1), V, T);
% 
%   %%
%   
%   fprintf('NH4= %.3f g/l, FOS/TAC= %.3f gHAceq/gCaCO3eq\n', NH4, FOSTAC);
%   fprintf('pH= %.3f, TAC= %.3f gCaCO3eq/l, VFA= %.3f gHAceq/l\r\n', pH, TAC, VFA);
    
  %%
  
  [stringNumbers, pH, NH4, VFATA, VFA, TA, ...
      Sac, Sbu, Spro, Sva, gas_h2, ...
      gas_ch4, gas_co2, gas]= biogas.ADMstate.printAndReturn(xvec, digester_id, plant);
  
  disp(stringNumbers)

  %%
  
  %if itank == 1 % only write in db for tank 1, because table cannot be selected
    % at the moment
    
  data= [pH, NH4, VFATA, VFA, TA, Sac, Sbu, Spro, Sva, gas_h2, ...
         gas_ch4, gas_co2, gas];
  table_headline= {'ph', 'nh4_g_l', 'vfa_ta', 'vfa_g_l', 'ta_g_l', ...
                   'sac_g_l', 'sbu_g_l', 'spro_g_l', ...
                   'sva_g_l', 'gas_h2', 'gas_ch4', 'gas_co2', 'gas'};

  % writes in Substrate_mixture        
  %% TODO: change to writeindataset
  
  %writeInDatabase('postgres', sprintf('estimated_%s', char(digester_id)), data, table_headline);
  
  writeInDataset(sprintf('estimated_%s', char(digester_id)), data, table_headline);
  
  %end
  
  %%
    
end

%%
%getStateEstimateOfBiogasPlant(postgresql);

%%

%getFeedAndRecycleEstimateOfBiogasPlant();

%%


