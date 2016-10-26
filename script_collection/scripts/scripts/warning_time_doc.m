%% Syntax
%       warning_time(message_id, message)
%       warning_time(message_id, message, a1, a2, ..., an)
%
%% Description
% |warning_time(message_id, message)| displays a warning together with the
% time the warning was thrown. 
%
%%
% @param |message_id| : see <matlab:doc('matlab/warning')>
%
%%
% @param |message| : char with the warning message to be displayed. see
% <matlab:doc('matlab/warning')>. 
%
%%
% @param |a1, a2, ..., an| : see <matlab:doc('matlab/warning')>. 
%
%% Example
% 
% 

warning_time('warning:id', 'my warning')

%%

warning_time('warning:id', 'my warning %s %s!', 'is here', 'and here')


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/warning">
% matlab/warning</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/dispmessage">
% script_collection/dispMessage</a>
% </html>
%
% and is called by:
%
% (all functions)
%
%% See Also
% 
% <html>
% <a href="matlab:doc script_collection/error_time">
% script_collection/error_time</a>
% </html>
%
%% TODOs
% # check links and appearance of documentation
% # improve documentation a bit
%
%% <<AuthorTag_DG/>>


