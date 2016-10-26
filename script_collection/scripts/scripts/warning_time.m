%% warning_time
% Displays a warning together with the time the warning was thrown
%
function warning_time(message_id, message, varargin)
%% Release: 0.9

%%

error( nargchk(2, nargin, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(message, 'message', 'char', '2nd');

%%
% get time into the string
mymessage= dispMessage(message);

%%

warning(message_id, mymessage, varargin{:});

%%


