%% substrate_mixer_digester_init_commands
% Configure the blocks which this block contains.
%
function substrate_mixer_digester_init_commands(varargin)
%% Release: 1.3

%%

error( nargchk(0, 1, nargin, 'struct') );
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
    disp(['Init block ', gcb]);
  end

  %%

  try
    substrate= hws.evalin('substrate');    
    plant=     hws.evalin('plant');    
  catch ME
    try
      substrate= evalin('base', 'substrate');
      plant=     evalin('base', 'plant');
    catch ME1
      warning('evalin:error', ['Could not load one of the variables ', ...
               'out of the model''s workspace!']);
      rethrow(ME);
    end
  end

  %%

  try
    config_substrate_mixer_digester(substrate, plant, DEBUG_DISP);
  catch ME
    disp(ME.message);
    rethrow(ME);
  end

  %%

  if DEBUG_DISP
    disp(['Successfully init block ', gcb]);
  end
    
end  

%%


