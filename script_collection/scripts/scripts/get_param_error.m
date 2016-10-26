%% get_param_error
% Call get_param of gcb, if param is empty, then an error is thrown
%
function value= get_param_error(param, varargin)
%% Release: 1.4

%%

narginchk(1, 2);
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 2 && ~isempty(varargin{1})
  block= varargin{1};
  % check argument
  checkArgument(block, 'block', 'char', '2nd');
else
  block= gcb;
end

%%
% check argument

checkArgument(param, 'param', 'char', '1st');

%%

value= get_param(block, param);

if isempty(value)
  error('Could not read the parameter %s of block %s!', param, block);
end

%%



%%


