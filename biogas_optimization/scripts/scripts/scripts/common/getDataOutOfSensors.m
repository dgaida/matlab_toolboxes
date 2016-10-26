%% getDataOutOfSensors
% 
%
function sensors_data= getDataOutOfSensors(plant_id, sensors, varargin)
%% Release: 0.0

%%

error( nargchk(2, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1})
  doplots= varargin{1};
  is0or1(doplots, 'doplots', 3);
else
  doplots= 0;
end

if nargin >= 4 && ~isempty(varargin{2})
  id_write= varargin{2};
else
  id_write= [];
end

%%
% check arguments



%%

plant= load_biogas_mat_files(plant_id, [], {'plant'});

%%

n_digester= plant.getNumDigestersD();
n_chps= plant.getNumCHPsD();

%%

for ichp= 1:n_chps
  chp_id= char(plant.getCHPID(ichp));
  Pel.(chp_id)= [];
end

for idigester= 1:n_digester
  digester_id= char(plant.getDigesterID(idigester));
  
  VFA_TA.(digester_id)= [];
  VFA.(digester_id)= [];
  OLR.(digester_id)= [];
  Spro.(digester_id)= [];
  Sac.(digester_id)= [];
  pH.(digester_id)= [];
  Snh4.(digester_id)= [];
  Snh3.(digester_id)= [];
end

%%

sim_biogas= [];
sim_ch4= [];
biogas_excess= [];
sim_h2= [];

sim_t= [];

%%

if iscell(sensors)
  sensors_cell= sensors;
end

%%

num_sensors= numel(sensors);

%%

for it= 1:num_sensors

  %%
  
  if exist('sensors_cell', 'var')
    sensors= sensors_cell{it};
  end

  %%
  
  for ichp= 1:n_chps
    chp_id= char(plant.getCHPID(ichp));
    
    Pel.(chp_id)= [Pel.(chp_id), double(...
      sensors.getMeasurementStream(['energyProduction_', chp_id]) ...
                 )];
  end
  
  %%

  for idigester= 1:n_digester
    digester_id= char(plant.getDigesterID(idigester));

    VFA_TA.(digester_id)= [VFA_TA.(digester_id), double(...
      sensors.getMeasurementStream(sprintf('VFA_TAC_%s_3', digester_id)))];
    
    VFA.(digester_id)= [VFA.(digester_id), double(...
      sensors.getMeasurementStream(sprintf('VFA_%s_3', digester_id)))];
    
    OLR.(digester_id)= [OLR.(digester_id), double(...
      sensors.getMeasurementStream(sprintf('OLR_%s', digester_id)))];
    
    Spro.(digester_id)= [Spro.(digester_id), double(...
      sensors.getMeasurementStream(['VFAmatrix_', digester_id, '_3'], '', 'Spro'))];
    
    Sac.(digester_id)= [Sac.(digester_id), double(...
      sensors.getMeasurementStream(['VFAmatrix_', digester_id, '_3'], '', 'Sac'))];
    
    pH.(digester_id)= [pH.(digester_id), double(...
      sensors.getMeasurementStream(['pH_', digester_id, '_3']))];
    
    Snh4.(digester_id)= [Snh4.(digester_id), double(...
      sensors.getMeasurementStream(['Snh4_', digester_id, '_3']))];
    
    Snh3.(digester_id)= [Snh3.(digester_id), double(...
      sensors.getMeasurementStream(['Snh3_', digester_id, '_3']))];
  end

  %%
  
  sim_biogas= [sim_biogas, double(sensors.getMeasurementStream('total_biogas_'))];

  sim_ch4= [sim_ch4, double(sensors.getMeasurementStream('total_biogas_', 2))];

  biogas_excess= [biogas_excess, double(sensors.getMeasurementStream('total_biogas_', 10))];

  sim_h2= [sim_h2, double(sensors.getMeasurementStream('total_biogas_', 1))];

  %%
  
  sim_t= [sim_t, double(sensors.getTimeStream())];

end

%%

sensors_data= {Pel, VFA_TA, VFA, OLR, Spro, Sac, pH, Snh4, Snh3, ...
               sim_biogas, sim_ch4, biogas_excess, sim_h2, sim_t};

%%

if doplots
  
  %%
  
  Pel_sum= 0;
  
  chp_ids= fieldnames(Pel);
  
  for ichp= 1:numel(chp_ids)
    Pel_sum= Pel_sum + Pel.(chp_ids{ichp});
  end
  
  plot_graph(sim_t, Pel_sum ./ 24, 'P_{el} [kW]', ['P_el_plant', id_write]);

  %%
  
  plot_graph(sim_t, sim_ch4, 'CH_4 content [%]', ['biogas_plant_ch4', id_write]);

  plot_graph(sim_t, sim_biogas, 'biogas [m^3/d]', ['biogas_plant', id_write]);
  
  %%
  
  digester_ids= fieldnames(Snh4);
  
  for idigester= 1:numel(digester_ids)
    digester_id= digester_ids{idigester};
      
    plot_graph(sim_t, Snh4.(digester_id), ...
               sprintf('NH_4-N %s [g/l]', digester_id), ...
               ['Snh4_', digester_id, id_write]);
           
    plot_graph(sim_t, VFA_TA.(digester_ids{idigester}), ...
               sprintf('VFA/TA %s [gHAceq/gCaCO3eq]', digester_id), ...
               ['VFA_TA_', digester_id, id_write]);      
             
    plot_graph(sim_t, Snh3.(digester_id), ...
               sprintf('NH_3 %s [g/l]', digester_id), ...
               ['Snh3_', digester_id, id_write]);
           
    plot_graph(sim_t, VFA.(digester_ids{idigester}), ...
               sprintf('VFA %s [gHAceq/l]', digester_id), ...
               ['VFA_', digester_id, id_write]);         
             
    plot_graph(sim_t, Sac.(digester_ids{idigester}), ...
               sprintf('acetic acid %s [g/l]', digester_id), ...
               ['Sac_', digester_id, id_write]);   
          
    plot_graph(sim_t, Spro.(digester_ids{idigester}), ...
               sprintf('propionic acid %s [g/l]', digester_id), ...
               ['Spro_', digester_id, id_write]);   
  end
  
  %%
  
end

%%



%%
%
function plot_graph(t, y, y_label, pic_name)

%%

fig('width', 13, 'fontsize', 10);

plot(t, y)
%xlim([250, 350])

min_y= fix( min( y( fix(0.1*numel(y)) : end ) )*0.995 );

ylim([min_y, ceil( max(y)*1.005 )])
xlabel('t [d]')
ylabel(y_label)

export_fig(pic_name, '-png', '-m3');%'-eps', '-m3');

%%


