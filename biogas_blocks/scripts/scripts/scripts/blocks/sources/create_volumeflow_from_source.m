%% create_volumeflow_from_source
% Set structure |t_q| and |q_id| in reading source.
%
function [q_id, t_q]= create_volumeflow_from_source(volumeflow_id, vol_type, ...
                                       datasource_type)
%% Release: 1.2

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

t_q= [];
q_id= [];

%%
% check input parameters

% createdailyhydrograph_mat/mdlInitializeSizes ruft die methode irgendwie
% mit volumeflow_id= [] auf...
checkArgument(volumeflow_id, 'volumeflow_id', 'char', '1st', 'on');

if isempty(volumeflow_id)
  return;
end

is_volumeflow_type(vol_type, 2);
is_datasource_type(datasource_type, 3);

%%

volumeflowfilename= sprintf('volumeflow_%s_%s.mat', volumeflow_id, vol_type);
volumeflowfile= strtok(volumeflowfilename, '.');

%%

if strcmp(datasource_type, 'file')
    
  %%
  
  try
    data= load ( volumeflowfilename );
  catch ME
    warning('load:error', ['Cannot load file ', volumeflowfilename]);

    rethrow(ME);
  end

  if ~isfield(data, volumeflowfile)
    error('%s is not a field of data!', volumeflowfile);
  end

  t_q.(volumeflow_id)= data.(volumeflowfile)(1,:);
  q_id.(volumeflow_id)= data.(volumeflowfile)(2,:);
  
% load from workspace
elseif strcmp(datasource_type, 'workspace')
   
  %%
  
  try
    data= evalin('base', volumeflowfile);
  catch ME

    warning('evalin:base', ['The variable ', volumeflowfile, ...
             ' does not exist in the base workspace. You have to ', ...
             'load the file into the workspace or set the ', ...
             'datasource type to file.']);

    error('The variable %s does not exist in the base workspace', ...
                                    volumeflowfile);

    rethrow(ME);

  end

  t_q.(volumeflow_id)= data(1,:);
  q_id.(volumeflow_id)= data(2,:);
  
elseif strcmp(datasource_type, 'extern')

  %%
  % erkennungsmerkmal des extern Modus
  
  t_q.(volumeflow_id)= -1;
  q_id.(volumeflow_id)= 0;

elseif strcmp(datasource_type, 'modelworkspace')

  [q_id, t_q]= ...
         eval_substrateProperty_inMWS(volumeflow_id, vol_type, 'volumeflow');
    
else
    
  error('Unknown datasource_type: %s', datasource_type);
    
end


%%


