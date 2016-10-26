%% adm1_closefcn
% Close the ADM1DE, ADM1xp model.
%
function adm1_closefcn(adm1_model, varargin)
%% Release: 1.4

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% read out varargin

if nargin >= 2 && ~isempty(varargin{1}), 
  DEBUG_DISP= varargin{1}; 
  is0or1(DEBUG_DISP, 'DEBUG_DISP', 2);
else
  DEBUG_DISP= 0; 
end


%% 
% check input parameters

validatestring(adm1_model, {'ADM1DE', 'ADM1xp'}, mfilename, 'adm1_model', 1);


%%

if ~isempty(bdroot)
  hws= get_param(bdroot, 'modelworkspace');
else
  hws= [];
end

%%

if ~isempty(hws)

  %%

  if DEBUG_DISP
    disp(['Close block ', gcb]);
  end

  %%
  % get chosen values
  values= get_param(gcb, 'MaskValues');

  if isempty(values)
    error('Could not read the parameter MaskValues of block %s!', gcb);
  end


  %%

  if strcmp(adm1_model, 'ADM1DE')
    values(7,1)= {'on'};
  else
    values(4,1)= {'on'};
  end


  try
    set_param(gcb, 'MaskValues', values);
  catch ME
    warning('Set:MaskValues', ...
           ['Could not set the parameter MaskValues of block ', ...
            gcb, '! Tried to set ', char(values(4,1))]);

    rethrow(ME);
  end


  %%

  try
    if strcmp(adm1_model, 'ADM1DE')
      createfermenterpopup(1, 0.7, 1, 0, 'Close', 5:6);      
    else
      createfermenterpopup(1, 0.7, 1, 0, 'Close', 2:3);   
    end
  catch ME
    disp(ME.message);
    rethrow(ME);
  end
  
end

%%


