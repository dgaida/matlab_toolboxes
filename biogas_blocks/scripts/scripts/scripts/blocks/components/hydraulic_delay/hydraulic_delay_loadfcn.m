%% hydraulic_delay_loadfcn
% Load the 'Hydraulic Delay' block by creating the dropdown menus of the 
% block's mask.
%
function hydraulic_delay_loadfcn(varargin)
%% Release: 1.4

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
if ~isempty(hws)

  %%
  % get chosen values
  values= get_param(gcb, 'MaskValues');

  if isempty(values)
    error('Could not read the parameter MaskValues of block %s!', gcb);
  end


  %%
  % is the block already loaded
  if strcmp( char(values(8,1)), 'on' )
    return;
  end


  %%

  if DEBUG_DISP
    disp(['Load block ', gcb]);
  end

  %%

  values(9,1)= {'on'};        % block is actually being loaded
  values(10,1)= {'off'};      % block is not actually being closed

  try
    set_param(gcb, 'MaskValues', values);
  catch ME
    warning('Set:MaskValues', ...
           ['Could not set the parameter MaskValues of block ', ...
            gcb, '! Tried to set ', char(values(9,1))]);

    rethrow(ME);
  end


  %%

  try
    set_param(gcb, 'UserDataPersistent', 'on');
  catch ME
    warning('Set:UserDataPersistent', ...
           ['Could not set the parameter UserDataPersistent of block ', ..., 
            gcb, '!']);
    rethrow(ME);
  end


  %%

  try
    createfermenterpopup(1, 0.8, 1, 1);       

    createfermenterpopup(2, 0.4, 1, 1);       

    createinitstatetypepopup(3, 1);  

    createdatasourcetypepopup(4, 1);
  catch ME
    disp(ME.message);
    rethrow(ME);
  end

  %%

  if DEBUG_DISP
    disp(['Successfully load block ', gcb]);
  end


  %%

  %%
  % get chosen values
  values= get_param(gcb, 'MaskValues');

  if isempty(values)
    error('Could not read the parameter MaskValues of block %s!', gcb);
  end

  values(8,1)= {'on'};
  values(9,1)= {'off'};

  try
    set_param(gcb, 'MaskValues', values);
  catch ME
    warning('Set:MaskValues', ...
           ['Could not set the parameter MaskValues of block ', ...
            gcb, '! Tried to set ', char(values(8,1))]);

    rethrow(ME);
  end

end

%%


