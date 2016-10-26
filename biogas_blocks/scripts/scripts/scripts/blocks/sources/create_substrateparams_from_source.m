%% create_substrateparams_from_source
% Set structure |t_q| and |substrateparams_id| in reading source.
%
function [q_id, t_q]= ...
         create_substrateparams_from_source(substrate_id, params_type, ...
                                            datasource_type)
%% Release: 1.0

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

t_q= [];
q_id= [];

%%
% check input parameters

% createdailyhydrograph_mat/mdlInitializeSizes ruft die methode irgendwie
% mit substrate_id= [] auf...
checkArgument(substrate_id, 'substrate_id', 'char', '1st', 'on');

if isempty(substrate_id)
  return;
end

checkArgument(params_type, 'params_type', 'char', '2nd');
is_datasource_type(datasource_type, 3);

%%

volumeflowfilename= sprintf('probes_%s_%s.mat', substrate_id, params_type);
volumeflowfile= strtok(volumeflowfilename, '.');

%%

if strcmp(datasource_type, 'file')
    
  %%
  
  if ~exist(volumeflowfilename, 'file')
    return;
  end
  
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

  t_q.(substrate_id)= data.(volumeflowfile)(:,1);
  q_id.(substrate_id)= data.(volumeflowfile)(:,2:end);
  
elseif strcmp(datasource_type, 'workspace')
  %% TODO
  return;
elseif strcmp(datasource_type, 'extern')
  %% TODO
  return;
elseif strcmp(datasource_type, 'modelworkspace')  
  %% TODO
  return;
else
    
  error('Unknown datasource_type: %s', datasource_type);
    
end


%%


