%% evalinMWS
% Evaluate a variable in the model workspace of loaded Simulink model.
%
function value= evalinMWS(variable, varargin)
%% Release: 2.9

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

global IS_DEBUG;

%%
% read out varargin

if nargin >= 2 && ~isempty(varargin{1}), 
  throw_error= varargin{1}; 
  
  if IS_DEBUG
    is0or1(throw_error, 'throw_error', 2);
  end
else
  throw_error= 0; 
end


%%
% check parameters

if IS_DEBUG
  checkArgument(variable, 'variable', 'char', '1st');
end

%%

bd_root= bdroot;

if ~isempty(bd_root)
  hws= get_param(bd_root, 'modelworkspace');
else
  hws= [];
end


%%

if ~isempty(hws)
  value= hws.evalin(variable);
else
  value= [];

  if throw_error == 0
    return;
  else
    warning('Simulink:noMWS', ...
            'The top-level Simulink system ''%s'' has no model workspace!', bdroot);
    error(  'The top-level Simulink system ''%s'' has no model workspace!', bdroot);
  end
end

if isempty(value)
  warning('Simulink:MWSevalError', ...
          'Could not evaluate ''%s'' in the model workspace of %s!', ...
                                              variable, bdroot);
  error(  'Could not evaluate ''%s'' in the model workspace of %s!', ...
                                              variable, bdroot);
end

%%

    
  