%% configmixer
% In dieser Funktion wird die Zahl der Eingänge des Mixers der
% Benutzerauswahl angepasst. 
%
function configmixer()
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

n_inputs= values{1,1};

sys_mux= char ( find_system(gcb, 'LookUnderMasks', 'all', ...
                'FollowLinks', 'on', 'Name', 'Mux') );

%%
% the number of inputs is contrained up to 100

for i_input= str2double(n_inputs) + 1:str2double(n_inputs) + 100 + 1

  %%
  % find input blocks which are to much
  
  sys_input= char ( find_system(this_block, 'LookUnderMasks', 'all', ...
          'FollowLinks', 'on', 'Name', sprintf('stream in%i', i_input)) );

  %%
  
  if isempty(sys_input)
    break;
  else

    %%
    % delete line between input and the input port of the Mux
    
    delete_line(this_block, sprintf('stream in%i/1', i_input), ...
                            sprintf('Mux/%i', i_input));

    % delete input block
    delete_block(sys_input);

  end

end


%%

try
  % set the by the user specified number of inputs of the mux
  set_param(sys_mux, 'Inputs', n_inputs);
catch ME
  warning('set_param:Inputs', 'Could not set the parameter Inputs!');

  rethrow(ME);
end


%%

% add inputs, if there are to few
for i_input= 1:str2double(n_inputs)

  %%
  
  sys_input= char ( find_system(this_block, 'LookUnderMasks', 'all', ...
          'FollowLinks', 'on', 'Name', sprintf('stream in%i', i_input)) );

  %%
  
  if isempty(sys_input)

    %%
    
    try
      add_block('built-in/Inport', ...
                sprintf('%s/stream in%i', this_block, i_input), ...
                'Position', pos1 + [0 25*(i_input - 1) 0 25*(i_input - 1)]);
    catch ME
      warning('mixer:add_block', 'configmixer add_block!');

      rethrow(ME);
    end
    
    %%
    
    try
      set_param(sprintf('%s/stream in%i', this_block, i_input), ...
                        'Port', sprintf('%i', i_input));
    catch ME
      warning('set_param:Port', 'Could not set the parameter Port!');

      rethrow(ME);
    end
    
    %%
    
    try
      add_line(this_block, sprintf('stream in%i/1', i_input), ...
                      sprintf('Mux/%i', i_input), 'autorouting','on');
    catch ME
      warning('mixer:add_line', 'configmixer add_line!');

      rethrow(ME);
    end
    
    %%
    
  else

    %%
    % get Position of 1st block
    
    if i_input == 1
      pos1= get_param(sys_input, 'Position');
    end

  end
    
end

%%


