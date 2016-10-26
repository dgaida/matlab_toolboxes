%% appendSensorData
% Append new data to sensor data
%
function sensor_data= appendSensorData(sensor_data, new_sensor_data)
%% Release: 1.8

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check input arguments

checkArgument(sensor_data, 'sensor_data', 'struct', '1st');
checkArgument(new_sensor_data, 'new_sensor_data', 'struct', '2nd');

%%

if ~( isfield(sensor_data, 'time') && isfield(sensor_data, 'stream') && ...
      isfield(sensor_data, 'Q') )
  workingWithStruct= 1;
  
  s_sensor_data= sensor_data;
  s_new_sensor_data= new_sensor_data;
  
  % die felder müssen fermenter namen sein. die felder time, stream, Q sind
  % dann felder der fermenter namen. fermenter sollten nicht time, stream
  % oder Q heißen
  if ( isfield(new_sensor_data, 'time') || isfield(new_sensor_data, 'stream') || ...
        isfield(new_sensor_data, 'Q') )
    
    save('workspace_sensor_data.mat');
      
    error('new_sensor_data must have the same format as sensor_data!');
    
  end
  
  fermenters= fieldnames(s_sensor_data);
  n_fermenter= numel(fermenters);
else
  workingWithStruct= 0;
  
  n_fermenter= 1;
end

%%

for ifermenter= 1:n_fermenter

  %%
  
  if workingWithStruct
    sensor_data= s_sensor_data.(fermenters{ifermenter});
    new_sensor_data= s_new_sensor_data.(fermenters{ifermenter});
  end
    
  %%

  sensor_data.time= [sensor_data.time; sensor_data.time(end) + ...
                                       new_sensor_data.time(2:end)];

  %%

  entries= fieldnames(sensor_data);

  for ientry= 1:numel(entries)

    if ~strcmp(entries{ientry}, 'time') && ~strcmp(entries{ientry}, 'Q') ...
                                        && ~strcmp(entries{ientry}, 't_q')

      sensor_data.(entries{ientry})= [sensor_data.(entries{ientry}); ...
                                      new_sensor_data.(entries{ientry})(2:end,:)];

    end

  end

  %%

  entries= fieldnames(sensor_data.Q);

  for ientry= 1:numel(entries)

    sensor_data.Q.(entries{ientry})= [sensor_data.Q.(entries{ientry}); ...
                                    new_sensor_data.Q.(entries{ientry})(2:end)];

    sensor_data.t_q.(entries{ientry})= [sensor_data.t_q.(entries{ientry}); ...
                    sensor_data.t_q.(entries{ientry})(end) + ...
                      new_sensor_data.t_q.(entries{ientry})(2:end)];

  end

  %%
  
  if workingWithStruct
    s_sensor_data.(fermenters{ifermenter})= sensor_data;
  end
  
  %%

end

%%

if workingWithStruct
  sensor_data= s_sensor_data;
end

%%


