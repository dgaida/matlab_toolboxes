%% adm1_loadfcn
% Loads the ADM1DE model by creating the dropdown menus of the block's
% mask.
%
function adm1_loadfcn(adm1_model, varargin)
%% Release: 1.4

%%
% read out varargin

if nargin >= 2 && ~isempty(varargin{1}), 
  DEBUG_DISP= varargin{1}; 
  is0or1(DEBUG_DISP, 'DEBUG_DISP', 2);
else
  DEBUG_DISP= 0; 
end

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );


%% 
% check input parameters

validatestring(adm1_model, {'ADM1DE', 'ADM1xp'}, mfilename, 'adm1_model', 1);


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
  if strcmp( char(values(5,1)), 'on' )
    return;
  end


  %%
  
  if DEBUG_DISP
    disp(['Load block ', gcb]);
  end

  %%

  if strcmp(adm1_model, 'ADM1DE')
    values(6,1)= {'on'};
    values(7,1)= {'off'};
  else
    values(3,1)= {'on'};
    values(4,1)= {'off'};
  end

  try
    set_param(gcb, 'MaskValues', values);
  catch ME
    warning('Set:MaskValues', ...
           ['Could not set the parameter MaskValues of block ', ...
            gcb, '! Tried to set ', char(values(3,1))]);

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
    createfermenterpopup(1, 0.7, 1, 1);       
  catch ME
    disp(ME.message);
    rethrow(ME);
  end
  
  if strcmp(adm1_model, 'ADM1DE')
    
    try
      createinitstatetypepopup(2, 1);  

      createdatasourcetypepopup(3, 1);
    catch ME
      disp(ME.message);
      rethrow(ME);
    end
  
  else

    % ADM1xp 

    %adm1xp_setmask();

  end


  %%

%     if strcmp(adm1_model, 'ADM1DE')
%         adm1_with_gui_setmasks(1,2,3,4);
%     else
%         adm1_with_gui_setmasks(1);
%     end


  %%
  if DEBUG_DISP
    disp(['Successfully load block ', gcb]);
  end


  %%
  % get chosen values
  values= get_param(gcb, 'MaskValues');

  if isempty(values)
    error('Could not read the parameter MaskValues of block %s!', gcb);
  end

  if strcmp(adm1_model, 'ADM1DE')
    values(5,1)= {'on'};
    values(6,1)= {'off'};
  else
    values(2,1)= {'on'};
    values(3,1)= {'off'};
  end

  try
    set_param(gcb, 'MaskValues', values);
  catch ME
    warning('Set:MaskValues', ...
           ['Could not set the parameter MaskValues of block ', ...
            gcb, '! Tried to set ', char(values(2,1))]);

    rethrow(ME);
  end

end

%%


