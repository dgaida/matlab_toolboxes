%% substrate_mixer_digester_loadfcn
% Load the 'Substrate Mixer (Digester)' block.
%
function substrate_mixer_digester_loadfcn(varargin)
%% Release: 1.1

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

% Since the library has no modelworkspace the code is only called for the
% block in the model and not for the block inside the library
if ~isempty(hws) && ~isempty(gcb)
    
  %%
  % get chosen values
  values= get_param_error('MaskValues');
  
  % values must be a column vector
  if size(values, 1) < 7
    error('Size of values is too small (must be 7): %i', size(values, 1));
  end

  %%
  % is the block already loaded
  if strcmp( char(values(4,1)), 'on' )
    if DEBUG_DISP
      disp(['Block ', gcb, ' already loaded!']);
    end
  
    return;
  end

  %%

  if DEBUG_DISP
    disp(['Load block ', gcb]);
  end

  %%

  values(5,1)= {'on'};
  values(6,1)= {'off'};

  set_param_tc('MaskValues', values);
  
  %%

  set_param_tc('UserDataPersistent', 'on');
  
  %%

  try
    createvolumeflowtypepopup(1, 1);
    createdatasourcetypepopup(2, 1);
  catch ME
    disp(ME.message);
    rethrow(ME);
  end

  %%

  if DEBUG_DISP
    disp(['Successfully load block ', gcb]);
  end

  %%

  % get chosen values
  values= get_param_error('MaskValues');

  values(4,1)= {'on'};
  values(5,1)= {'off'};

  set_param_tc('MaskValues', values);
  
  %%

  try
    substrate_mixer_digester_init_commands(DEBUG_DISP);
  catch ME
    disp(ME.message);
    rethrow(ME);
  end
    
  %%
    
  if DEBUG_DISP
    disp(['Successfully ran ', mfilename, ' for block ', gcb]);
  end
    
end

%%


