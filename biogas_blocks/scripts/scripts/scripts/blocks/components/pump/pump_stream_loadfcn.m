%% pump_stream_loadfcn
% Load the 'Pump Stream (Energy)' block by creating the dropdown menus of  
% the block's mask.
%
function pump_stream_loadfcn(varargin)
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

%%

if ~isempty(hws)

  %%
  % get chosen values
  values= get_param_error('MaskValues');

  %%
  % is the block already loaded - 11 : loaded
  if strcmp( char(values(11,1)), 'on' )
    return;
  end

  %%

  if DEBUG_DISP
    disp(['Load block ', gcb]);
  end

  %%
  % sperre den block gegen andere veränderungen
  
  values(12,1)= {'on'};       % isbeingloaded
  values(13,1)= {'off'};      % isbeingclosed

  set_param_tc('MaskValues', values);
  
  %%

  set_param_tc('UserDataPersistent', 'on')
  
  %%
  % erstelle inhalte für drop down menus
  
  createfermenterpopup(1, 0.8, 1, 1);       

  createfermenterpopup(2, 0.4, 1, 1);       

  createvolumeflowtypepopup(3, 1);

  createdatasourcetypepopup(4, 1);

  createinitstatetypepopup(7, 1);  

  %%

  %pump_stream_init_commands();


  %if (pump_stream_setmasks(1, 2, 7, 4, 8, 9, ...   
  %                 10, 3, 4, 5, 6, 7) == 1)    

   %   error('Pump Stream (Energy) : LoadFcn');       

  %end


  %%

  if DEBUG_DISP
    disp(['Successfully load block ', gcb]);
  end

  %%
  % get chosen values
  values= get_param_error('MaskValues');

  %%
  % gebe block wieder frei
  
  values(11,1)= {'on'};       % is load
  values(12,1)= {'off'};      % is being load = off

  set_param_tc('MaskValues', values);

end        

%%


