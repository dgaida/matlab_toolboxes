%% set_param_tc
% Set param of gcb surrounded in a try catch
%
function set_param_tc(param, value, varargin)
%% Release: 1.3

%%

narginchk(2, 3);
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1})
  block= varargin{1};
  % check argument
  checkArgument(block, 'block', 'char', '2nd');
else
  block= gcb;
end

%%
% check params

checkArgument(param, 'param', 'char', '1st');
% value can be a lot

%%

try
  set_param(block, param, value);
catch ME
  %% TODO
  % char(value) often fails to print something, see examples
  warning(sprintf('set_param:%s', param), ...
         ['Could not set the parameter ', param, ' of block ', ...
          block, '! Tried to set ', char(value), '!']);

  rethrow(ME);
end

%%



%%


