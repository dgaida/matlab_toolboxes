%% Syntax
%       error_time(message_id, message)
%       error_time(message_id, message, a1, a2, ..., an)
%
%% Description
% |error_time(message_id, message)| displays an error together with the
% time the error was thrown. 
%
%%
% @param |message_id| : see <matlab:doc('matlab/error')>
%
%%
% @param |message| : char with the error message to be displayed. see
% <matlab:doc('matlab/error')>. 
%
%%
% @param |a1, a2, ..., an| : see <matlab:doc('matlab/error')>. 
%
%% Example
% 
% 

error_time('error:id', 'my error')

%%

error_time('error:id', 'my error %s %s!', 'is here', 'and here')


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
% <a href="matlab:doc matlab/error">
% matlab/error</a>
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
% <a href="matlab:doc script_collection/warning_time">
% script_collection/warning_time</a>
% </html>
%
%% TODOs
% # check links and appearance of documentation
% # improve documentation a bit
%
%% <<AuthorTag_DG/>>


