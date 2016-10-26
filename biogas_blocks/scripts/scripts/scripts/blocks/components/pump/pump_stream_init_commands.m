%% pump_stream_init_commands
% Initializes pump stream block by creating blocks and setting masks
%
function pump_stream_init_commands(varargin)
%% Release: 1.2

%%

narginchk(0, 1);
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% read out varargin

if nargin >= 1 && ~isempty(varargin{1}), 
  DEBUG_DISP= varargin{1}; 
  
  is0or1(DEBUG_DISP, 'DEBUG_DISP', 1);
else
  DEBUG_DISP= 0; 
end

%%

if ~isempty(bdroot)
  hws= get_param(bdroot, 'modelworkspace');
else
  hws= [];
end

if ~isempty(hws)

  %%

  if DEBUG_DISP
    disp(['pump_stream_init_commands() of block ', gcb]);
  end

  %current_block= gcb;
  %current_sys= gcs;

  %% TODO
  % Prüfen warum gcb geändert wird und was man dagegen machen kann, muss
  % die config Funktion aufgerufen werden? vielleicht nur bei der
  % hydraulic delay? änderung des gcb wirft eine warnung
  % Warning: The variable values of block plant_maasland/Biogasanlage
  % Maasland/main1/Pump Stream (Energy)/ADM1 
  % stream is empty! 
  %> In pump_stream_setmasks at 70

  % changes gcb
  % erstellt/löscht blöcke in pump stream block, bspw. hydraulic delay
  pump_stream_config();

  %%

%     if current_block == gcs
%         try
%             get_param(current_sys, 'CurrentBlock')
%             [pathstr, name]= fileparts(current_block);
%             set_param(current_sys, 'CurrentBlock', name);
%         catch ME
%             warning('Caught an error!');
%             rethrow(ME);
%         end
%     end

  %gcb

  %%
  % copy selected elements of pump stream mask through to mask of hydraulic
  % delay
  if (pump_stream_setmasks(1, 2, 7, 4, 8, 9, 10, 3, 4, 5, 6, 7) == 1)    
    error('Pump Stream (Energy) : Init');
  end

  %%

  if DEBUG_DISP
    disp(['end of pump_stream_init_commands() of block ', gcb]);
  end

end

%%


