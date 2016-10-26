%% save_sensorsData2ts
% Save data saved in sensors into a timeseries object/file
%
function save_sensorsData2ts(sensors, plant, varargin)
%% Release: 0.0

%%

error( nargchk(2, 5, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1})
  filename= varargin{1};
  checkArgument(filename, 'filename', 'char', '3rd');
else
  filename= 'ts_ADM1params.mat';
end

if nargin >= 4 && ~isempty(varargin{2})
  filename_state= varargin{2};
  checkArgument(filename_state, 'filename_state', 'char', 4);
else
  filename_state= 'ts_ADM1state.mat';
end

if nargin >= 5 && ~isempty(varargin{3})
  filename_stream= varargin{3};
  checkArgument(filename_stream, 'filename_stream', 'char', 5);
else
  filename_stream= 'ts_ADM1stream_2.mat';
end

%%
% check arguments

is_sensors(sensors, 1);
is_plant(plant, 2);

%%
% get data out of sensors

data= [];
states= [];
streams= [];

for idigester= 1:plant.getNumDigestersD()
  %%
  
  digester_id= char(plant.getDigesterID(idigester));
  
  params= double(sensors.getMeasurementStreams(sprintf('ADMparams_%s', digester_id)));

  data= [data, params'];
  
  %%
  
  state= double(sensors.getMeasurementStreams(sprintf('ADMstate_%s', digester_id)));

  states= [states, state'];
  
  %%
  
  stream= double(sensors.getMeasurementStreams(sprintf('ADMstream_%s_2', digester_id)));

  streams= [streams, stream'];
  
  %%
  
end

%%

time= double(sensors.getTimeStream());

%%

if exist('timeseries', 'file') == 2
  ts= timeseries(data, time);
  ts_state= timeseries(states, time);
  ts_stream= timeseries(streams, time);
else
  error('Timeseries Toolbox not installed!');
end

%%
% resample time series - 12 h/day

ts_res= resampleTS(ts, 2);
ts_state_res= resampleTS(ts_state, 2);
ts_stream_res= resampleTS(ts_stream, 2);

%%
% check whether a ts in a file already exist

if exist(filename, 'file')
  % if yes, then load the file
  ts_prev= load_file(filename);
  
  dispMessage(sprintf('Append timeseries from %.2f to %.2f.', ...
              double(ts_prev.Time(end)), double(ts_res.Time(1))), mfilename);

  try
    % append new data to already saved data
    ts_new= append(ts_prev, ts_res);
  catch ME
    save 'workspace_save_sensors2ts';
    
    rethrow(ME);
  end
else
  ts_new= ts_res;
end

% save appended ts into file
save_varname(ts_new, 'ts_ADM1params', filename);

%%

if exist(filename_state, 'file')
  % if yes, then load the file
  ts_prev= load_file(filename_state);
  
  dispMessage(sprintf('Append timeseries from %.2f to %.2f.', ...
              double(ts_prev.Time(end)), double(ts_state_res.Time(1))), mfilename);

  try
    % append new data to already saved data
    ts_new= append(ts_prev, ts_state_res);
  catch ME
    save 'workspace_save_sensors2ts';
    
    rethrow(ME);
  end
else
  ts_new= ts_state_res;
end

% save appended ts into file
save_varname(ts_new, 'ts_ADM1state', filename_state);

%%

if exist(filename_stream, 'file')
  % if yes, then load the file
  ts_prev= load_file(filename_stream);
  
  dispMessage(sprintf('Append timeseries from %.2f to %.2f.', ...
              double(ts_prev.Time(end)), double(ts_stream_res.Time(1))), mfilename);

  try
    % append new data to already saved data
    ts_new= append(ts_prev, ts_stream_res);
  catch ME
    save 'workspace_save_sensors2ts';
    
    rethrow(ME);
  end
else
  ts_new= ts_stream_res;
end

% save appended ts into file
save_varname(ts_new, 'ts_ADM1stream_2', filename_stream);

%%



%%


