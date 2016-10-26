%% pump_stream_config
% Configures the block pump stream (Energy).
%
function pump_stream_config()
%% Release: 1.3

%%

narginchk(0, 0);
error( nargoutchk(0, 0, nargout, 'struct') );

%%

this_block= gcb;

% get chosen values
values= get_param(gcb, 'MaskValues');

if isempty(values)
  return;
end


%% 
% extern stuff

datasource_type= char(values{4,1});

sys_dummy= char ( find_system(gcb, 'LookUnderMasks', 'all', ...
                  'FollowLinks', 'on', 'Name', 'pump stream - dummy') );
              
sys_input= char ( find_system(gcb, 'LookUnderMasks', 'all', ...
                  'FollowLinks', 'on', 'Name', 'SP') );

%%

if ~isempty(sys_dummy) || ~isempty(sys_input)
  
  if ~strcmp(datasource_type, 'extern')       % nicht extern

    if ~isempty(sys_input)    % falls eingangsblock vorhanden ist, dann löschen

      %%
      % eingang löschen

      pos= get_param(sys_input, 'Position');

      % delete line between input and the output port of the Demux
      delete_line(this_block, 'SP/1', 'pump stream - mux/2');

      % delete input block
      delete_block(sys_input);

      % dummy hinzufügen

      add_block('built-in/Constant', ...
                sprintf('%s/pump stream - dummy', this_block), ...
                'Position', pos);

      add_line(this_block, 'pump stream - dummy/1', ...
              'pump stream - mux/2', 'autorouting','on');

    end

  else % extern

    if ~isempty(sys_dummy)    % falls dummy vorhanden dann löschen und input einfügen

      %%
      
      pos= get_param(sys_dummy, 'Position');

      % dummy löschen

      % delete line between input and the output port of the Demux
      delete_line(this_block, 'pump stream - dummy/1', 'pump stream - mux/2');

      % delete output block
      delete_block(sys_dummy);

      % eingang hinzufügen

      add_block('built-in/Inport', sprintf('%s/SP', this_block), ...
                'Position', pos);

      set_param(sprintf('%s/SP', this_block), 'Port', '2');

      add_line(this_block, 'SP/1', 'pump stream - mux/2', 'autorouting','on');

    end

  end

else
  % das soll eigentlich nicht passieren
  error('Both blocks dummy and input cannot be found!');

end



%%
% hydraulic delay

use_hyd_delay= char(values{6,1});

sys_hyd_delay= char ( find_system(gcb, 'LookUnderMasks', 'all', ...
                'FollowLinks', 'on', 'Name', 'pump stream - hydraulic delay') );

%%

if strcmp( use_hyd_delay, 'on' )

  if isempty(sys_hyd_delay)   % hydraulic delay noch nicht vorhanden

    %%
    % add hydraulic delay

    % delete line between input and the output port of the Demux
    delete_line(this_block, 'MuxPump/1', 'pumped stream/1');

    add_block('biogas/Biogas Plant Components/Hydraulic Delay', ...
              sprintf('%s/pump stream - hydraulic delay', this_block), ...
              'Position', [700, 239, 865, 301]);

    add_line(this_block, 'MuxPump/1', ...
             'pump stream - hydraulic delay/1', 'autorouting','on');

    add_line(this_block, 'pump stream - hydraulic delay/1', ...
             'pumped stream/1', 'autorouting','on');

  end

else

  if ~isempty(sys_hyd_delay)  % wenn hydraulic delay existiert, dann löschen

    %%
    % delete hydraulic delay

    % delete line between input and the output port of the Demux
    delete_line(this_block, 'MuxPump/1', 'pump stream - hydraulic delay/1');

    % delete line between input and the output port of the Demux
    delete_line(this_block, 'pump stream - hydraulic delay/1', ...
                            'pumped stream/1');

    % delete output block
    delete_block(sys_hyd_delay);                    

    add_line(this_block, 'MuxPump/1', 'pumped stream/1', 'autorouting','on');

  end

end

%%


