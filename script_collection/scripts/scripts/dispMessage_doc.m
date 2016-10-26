%% Syntax
%       dispMessage(message)
%       dispMessage(message, mscriptname)
%       mymessage= dispMessage(message, ...)
%
%% Description
% |dispMessage(message)| displays the given message with time and date.
% Function can be used for status/information messages. 
%
%%
% @param |message| : char with a message to be displayed. 
%
%%
% @param |mscriptname| : filename or name of method which calls this
% function. char. Default: ''.
%
%%
% @return |mymessage| : if there is a return value, then the message is not
% displayed but just written to |mymessage|. 
%
%% Example
% 
% 

dispMessage('example call')

%%

dispMessage('example call', mfilename)

%%

mymessage= dispMessage('example call', mfilename);

fprintf('mymessage: %s!\n', mymessage);

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
% <a href="matlab:doc matlab/fprintf">
% matlab/fprintf</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/sprintf">
% matlab/sprintf</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/now">
% matlab/now</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/datestr">
% matlab/datestr</a>
% </html>
%
% and is called by:
%
% (all functions)
%
%% See Also
% 
% <html>
% <a href="matlab:doc matlab/mfilename">
% matlab/mfilename</a>
% </html>
%
%% TODOs
% # check links and appearance of documentation
%
%% <<AuthorTag_DG/>>


