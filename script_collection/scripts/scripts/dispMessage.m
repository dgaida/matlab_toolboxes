%% dispMessage
% Display a message
%
function varargout= dispMessage(message, varargin)
%% Release: 1.7

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 2 && ~isempty(varargin{1})
  mscriptname= varargin{1};
  checkArgument(mscriptname, 'mscriptname', 'char', '2nd');
else
  mscriptname= '';
end

%%

if nargout >= 1
  % do not add \n at the end here
  varargout{1}= sprintf('%s - %s: %s', datestr(now), mscriptname, message);
else
  fprintf('%s - %s: %s\n', datestr(now), mscriptname, message);
  varargout= [];
end

%%


