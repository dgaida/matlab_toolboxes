%% NMPC_create_ref_biogas_1_slave
% Creates or appends data to file ../ref_biogas_1_slave.mat
%
function NMPC_create_ref_biogas_1_slave(sensors, plant, varargin)
%% Release: 1.0

%%

narginchk(2, 4);
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1})
  init_sim= varargin{1};
  is0or1(init_sim, 'init_sim', 3);
else
  init_sim= 0;
end

if nargin >= 4 && ~isempty(varargin{2})
  var_name= varargin{2};
  checkArgument(var_name, 'var_name', 'char', 4);
else
  var_name= 'ref_biogas_1_slave';
end

%%

is_sensors(sensors, 1);
is_plant(plant, 2);

%%

file_name= fullfile('..', sprintf('%s.mat', var_name));

%%
% diese ch4 produktion gilt als sollwert für den slave controller

%%

n_digester= plant.getNumDigestersD();
    
sum_ch4= 0;   % methane production of all digesters together

%%

for idigester= 1:n_digester
  digester_id= char(plant.getDigesterID(idigester));
  % get ch4 for digester
  ch4_values= double(sensors.getMeasurementStream(sprintf('biogas_%s', digester_id), 1));

  sum_ch4= sum_ch4 + ch4_values;
end

%%

time= double(sensors.getTimeStream());
% 0.5 day sampling time
time_inter= time(1):0.5:time(end);

%%
% resample and interpolate
sum_ch4inter= interp1(time, sum_ch4, time_inter);

%%
% load file if it exists
if exist(file_name, 'file')
  ch4_ref= load_file(file_name);
  
  if init_sim
    error('init_sim == 1, but file %s already did exist!', file_name);
  end
else
  ch4_ref= [];
end

if init_sim
  ch4_ref= [-50 -1; sum_ch4inter(end) sum_ch4inter(end)];
else
  % append new data
  ch4_ref= [ch4_ref, [time_inter; sum_ch4inter(:)']];
end

%%
% save file again
save_varname(ch4_ref, var_name, file_name);

%%



%%


