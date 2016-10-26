%% hydraulic_delay_closefcn
% Close the 'Hydraulic Delay' block.
%
function hydraulic_delay_closefcn(varargin)
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

  values(10,1)= {'on'};

  try
    set_param(gcb, 'MaskValues', values);
  catch ME
    warning('Set:MaskValues', ...
           ['Could not set the parameter MaskValues of block ', ...
            gcb, '! Tried to set ', char(values(10,1))]);

    rethrow(ME);
  end


  %%

  try
    createfermenterpopup(1, 0.8, 1, 0, 'Close', 8:9);       
  catch ME
    disp(ME.message);
    rethrow(ME);
  end
  
  %%
  
  try
    createfermenterpopup(2, 0.4, 1, 0, 'Close', 8:9);       
  catch ME
    disp(ME.message);
    rethrow(ME);
  end
  
  %%
  
end

%%


