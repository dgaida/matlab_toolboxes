%% configdivider
% In dieser Funktion wird die Zahl der Ausgänge des Dividers der
% Benutzerauswahl angepasst. 
%
function configdivider()
%% Release: 1.4

%%

error( nargchk(0, 0, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

this_block= gcb;

% get chosen values
values= get_param(gcb, 'MaskValues');

if isempty(values)
  return;
end

n_outputs= values{1,1};

sys_demux= char ( find_system(gcb, 'LookUnderMasks', 'all', ...
                  'FollowLinks', 'on', 'Name', 'Demux') );

                
%%
% the number of outputs is contrained up to 100

for i_output= str2double(n_outputs) + 1:str2double(n_outputs) + 100 + 1

  %%
  % find output blocks which are to much
  
  sys_output= char ( find_system(this_block, 'LookUnderMasks', 'all', ...
          'FollowLinks', 'on', 'Name', sprintf('stream out%i', i_output)) );

  %%
  
  if isempty(sys_output)
    break;
  else

    %%
    % delete line between input and the output port of the Demux
    
    delete_line(this_block, sprintf('Demux/%i', i_output), ...
                            sprintf('stream out%i/1', i_output));

    % delete output block
    delete_block(sys_output);

  end
    
end


%%

try
  % set the by the user specified number of outputs of the demux
  set_param(sys_demux, 'Outputs', n_outputs);
catch ME
  warning('set_param:Outputs', 'Could not set the parameter Outputs!');

  rethrow(ME);
end


%%

% add outputs, if there are to few
for i_output= 1:str2double(n_outputs)

  %%
  
  sys_output= char ( find_system(this_block, 'LookUnderMasks', 'all', ...
          'FollowLinks', 'on', 'Name', sprintf('stream out%i', i_output)) );

  %%
  
  if isempty(sys_output)

    %%
    
    try
      add_block('built-in/Outport', ...
                sprintf('%s/stream out%i', this_block, i_output), ...
                'Position', pos1 + [0 40*(i_output - 1) 0 40*(i_output - 1)]);
    catch ME
      warning('divider:add_block', 'configdivider add_block!');

      rethrow(ME);
    end
    
    %%
    
    try
      set_param(sprintf('%s/stream out%i', this_block, i_output), ...
                        'Port', sprintf('%i', i_output));
    catch ME
      warning('set_param:Port', 'Could not set the parameter Port!');

      rethrow(ME);
    end
    
    %%
    
    try
      add_line(this_block, sprintf('Demux/%i', i_output), ...
               sprintf('stream out%i/1', i_output), 'autorouting','on');
    catch ME
      warning('divider:add_line', 'configdivider add_line!');

      rethrow(ME);
    end
    
    %%
    
  else

    %%
    % get Position of 1st block
    
    if i_output == 1
      pos1= get_param(sys_output, 'Position');
    end

  end

end

%%


