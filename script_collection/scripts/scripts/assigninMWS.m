%% assigninMWS
% Assign a variable to model workspace of loaded Simulink model
%
function varargout= assigninMWS(variable_name, variable, varargin)
%% Release: 2.9

%%

error( nargchk(2, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

global IS_DEBUG;

%%
% read out varargin

if nargin >= 3 && ~isempty(varargin{1}), 
  throw_error= varargin{1}; 
  
  if IS_DEBUG
    is0or1(throw_error, 'throw_error', 3);
  end
else
  throw_error= 0;
end

if nargin >= 4 && ~isempty(varargin{2}), 
  silent= varargin{2}; 
  
  if IS_DEBUG
    is0or1(silent, 'silent', 4);
  end
else
  silent= 0;
end


%%
% check parameters

if IS_DEBUG
  
  checkArgument(variable_name, 'variable_name', 'char', '1st');

end

%%

mybdroot= bdroot;

if ~isempty(mybdroot)
  hws= get_param(mybdroot, 'modelworkspace');
else
  hws= [];
end


%%

if ~isempty(hws)
  try
    hws.assignin(variable_name, variable);
    
    if silent == 0
      dispMessage(sprintf('%s assigned to modelworkspace.', variable_name), mfilename);
    end
  catch ME
    warning_time('Simulink:assignError', ...
            ['Could not assign ''%s'' in the model ', ...
             'workspace of %s!'], variable_name, mybdroot);
    error_time('Simulink:assignError', ...
            ['Could not assign ''%s'' in the model ', ...
             'workspace of %s!'], variable_name, mybdroot);
    rethrow(ME);
  end
else

  if throw_error == 0
    % do nothing
  else
    warning_time('Simulink:noMWS', ...
            'The top-level Simulink system ''%s'' has no model workspace!', mybdroot);
    error_time('Simulink:noMWS', ...  
            'The top-level Simulink system ''%s'' has no model workspace!', mybdroot);
  end

end

%%

if nargout >= 1
  varargout{1}= mybdroot;
else
  varargout= {};
end

%%


