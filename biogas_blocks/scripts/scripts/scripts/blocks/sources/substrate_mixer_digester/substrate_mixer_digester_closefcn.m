%% substrate_mixer_digester_closefcn
% Closes the block 'Substrate Mixer (Digester)'.
%
function substrate_mixer_digester_closefcn(varargin)
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

if ~isempty(hws) && ~isempty(gcb)

  %%

  if DEBUG_DISP
    disp(['Close block ', gcb]);
  end

  %%
  % get chosen values
  
  values= get_param_error('MaskValues');

  %%

  values(4,1)= {'off'};     % load
  values(5,1)= {'off'};     % being loaded
  values(6,1)= {'on'};      % being closed

  set_param_tc('MaskValues', values);
  
  %% TODO
  % warum mache ich das hier?

  try
    save_system(bdroot);
  catch ME
    warning('save_system:error', ['Could not save the system ', ...
             gcs, '!']);

    rethrow(ME);
  end

end

%%


