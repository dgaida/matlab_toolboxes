%% pump_energy_loadfcn
% Load the 'Pump (Energy)' block by creating the dropdown menu of the 
% block's mask.
%
function pump_energy_loadfcn(varargin)
%% Release: 0.9

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
  % get chosen values
  values= get_param_error('MaskValues');

  %%
  % is the block already loaded
  if strcmp( char(values(3,1)), 'on' )
    return;
  end

  %%

  if DEBUG_DISP
    disp(['Load block ', gcb]);
  end

  %%

  values(4,1)= {'on'};
  values(5,1)= {'off'};

  set_param_tc('MaskValues', values);

  %%

  set_param_tc('UserDataPersistent', 'on');

  %%

  createfermenterpopup(1, 0.3, 1, 1);      

  pump_energy_setmask();

  %%

  if DEBUG_DISP
    disp(['Successfully load block ', gcb]);
  end

  %%
  % get chosen values
  values= get_param_error('MaskValues');

  values(3,1)= {'on'};
  values(4,1)= {'off'};

  set_param_tc('MaskValues', values);

end

%%


