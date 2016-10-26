%% get4MeasurementsfromSensors
% Get measurement streams for pH, CH4 and CO2 concentration and CH4
% production out of sensors
%
function [pH, ch4, co2, ch4p]= get4MeasurementsfromSensors(sensors, plant, varargin)
%% Release: 1.1

%%

narginchk(2, 4);
error( nargoutchk(0, 4, nargout, 'struct') );

%%
% check arguments

if isa(sensors, 'biogas.sensors')
  %% 
  % wurde ein biogas.sensors objekt übergeben oder ein struct 'sensor_data'?
  sim_obj= 1;
elseif isstruct(sensors)
  sim_obj= 0;         % dataset matrix
else
  checkArgument(sensors, 'sensors', 'biogas.sensors || struct', '1st');
end

is_plant(plant, '3rd');

%%

if nargin >= 3 && ~isempty(varargin{1})
  sample_time= varargin{1};
  isR(sample_time, 'sample_time', 3, '+');
else
  % sample time in hours
  sample_time= 1;
end

if nargin >= 4 && ~isempty(varargin{2})
  noisy= varargin{2};
  checkArgument(noisy, 'noisy', 'logical', 4);
else
  noisy= false;
end

%%

n_fermenter= plant.getNumDigestersD();

%%

if sim_obj
  % hole die zeit aus irgendeiner variablen, zeit ist überall gleich
  ts= double( sensors.getTimeStream() )';
else
  ts= sensors.time;
end

%%
% erstelle ein äquidistanten zeitvektor
% sample_time wird in stunden gemessen, ts in tagen
% deshalb umrechnungsfaktor 1/24 von stunden in tagen
t= (min(ts):sample_time*1/24:max(ts))';

%%

pH=   zeros(numel(t), n_fermenter);

ch4=  zeros(numel(t), n_fermenter);
ch4p= zeros(numel(t), n_fermenter);
co2=  zeros(numel(t), n_fermenter);


%%

for idigester= 1:n_fermenter

  id_fermenter= char(plant.getDigesterID(idigester));

  % pH Wert
  if sim_obj
    pHs= sensors.getMeasurementStream(['pH_', id_fermenter, '_3'], noisy);
    pHs= double(pHs)';
  else
    pHs= sensors.pH;
  end
  %obj_simulator.measurements.(id_fermenter).out.pH(2,:)';
  % add random noise
  %% TODO
  % use randn and not rand
  %% TODO
  % wird nicht mehr benötigt, übernommen durch noisy
  %pHs= pHs + noise_out(1) .* ( rand(size(pHs,1), 1) - 0.5 ) .* mean(pHs);
  % resample
  pH(:,idigester)= interp1(ts, pHs, t, 'linear');

  %%
  %ch4s= obj_simulator.measurements.(id_fermenter).biogas(3,:)';
  % prozentuale methanproduktion
  %ch4s= obj_simulator.measurements.(id_fermenter).biogas_percentage(3,:)';
  
  if sim_obj
    ch4s= double( sensors.getMeasurementStream(['biogas_', id_fermenter], '', 'CH4_%', noisy) )';
  else
    ch4s= sensors.ch4;
  end
  
  %% TODO
  % use randn and not rand
  %% TODO
  % wird nicht mehr benötigt, übernommen durch noisy
  %ch4s= ch4s + noise_out(2) .* ( rand(size(ch4s,1), 1) - 0.5 ) .* mean(ch4s);
  ch4(:,idigester)= interp1(ts, ch4s, t, 'linear');

  %% 
  %co2s= obj_simulator.measurements.(id_fermenter).biogas(4,:)';
  % prozentuale co2 produktion
  %co2s= obj_simulator.measurements.(id_fermenter).biogas_percentage(4,:)';
  
  if sim_obj
    co2s= double( sensors.getMeasurementStream(['biogas_', id_fermenter], '', 'CO2_%', noisy) )';
  else
    co2s= sensors.co2;
  end
  
  %% TODO
  % use randn and not rand
  %% TODO
  % wird nicht mehr benötigt, übernommen durch noisy
  %co2s= co2s + noise_out(3) .* ( rand(size(co2s,1), 1) - 0.5 ) .* mean(co2s);
  co2(:,idigester)= interp1(ts, co2s, t, 'linear');

  %% 
  %ch4ps= obj_simulator.measurements.(id_fermenter).biogas_percentage(3,:)';
  % gesamte biogasproduktion de fermenters
  %ch4ps= sum(obj_simulator.measurements.(id_fermenter).biogas(2:4,:), 1)'; 
  
  if sim_obj
    ch4ps= double( sensors.getMeasurementStream(['biogas_', id_fermenter], '', 'biogas_m3_d', noisy) )';
  else
    ch4ps= sensors.biogas;
  end
  
  %% TODO
  % use randn and not rand
  %% TODO
  % wird nicht mehr benötigt, übernommen durch noisy
  %ch4ps= ch4ps + noise_out(4) .* ( rand(size(ch4ps,1), 1) - 0.5 ) .* mean(ch4ps);
  ch4p(:,idigester)= interp1(ts, ch4ps, t, 'linear');

end

%%



%%


