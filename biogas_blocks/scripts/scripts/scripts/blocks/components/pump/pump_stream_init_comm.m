%% pump_stream_init_comm
% Initializes the 'Pump Stream (Energy)' block
%
function pump_stream_init_comm(varargin)
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
% 

if ~isempty(bdroot)
  hws= get_param(bdroot, 'modelworkspace');
else
  hws= [];
end

if isempty(hws)
 return; 
end

%%

if DEBUG_DISP
  disp(['Initialization commands of block ', gcb]);
end

values= get_param_error('MaskValues');

%%

if strcmp( char(values(11,1)), 'off' )    % meaning of all values? 

  if strcmp( char(values(12,1)), 'off' )

    if strcmp( char(values(13,1)), 'off' )

      % create masks
      pump_stream_loadfcn(DEBUG_DISP);

    end

  end

else

  if strcmp( char(values(13,1)), 'off' )

    % creates all blocks in pump block and passes parameters through masks
    pump_stream_init_commands(DEBUG_DISP);

  end

end

%%

clear values;

%%


