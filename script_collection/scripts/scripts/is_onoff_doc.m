%% Syntax
%       is_onoff(argument, argument_name, argument_number)
%
%% Description
% |is_onoff(argument, argument_name, argument_number)| checks if the given
% |argument| is 'on' or 'off'. The argument has the name |argument_name| and is
% the |argument_number| th argument of the calling function. 
%
%%
% @param |argument| : The argument that will be checked. Should be a char
% with value 'on' or 'off'. 
%
%%
% @param |argument_name| : char with the name of the argument. 
%
%%
% @param |argument_number| : number of the argument in the calling
% function. double scalar integer. 
%
%% Example
% 
% These calls are ok

is_onoff('on', 'myVariable', 3)

%%

is_onoff('off', 'myVariable', 3)

%%
% The next two calls throw an error

try
  is_onoff(true, 'myVariable', 1)
catch ME
  disp(ME.message)
end

%%
%

try
  is_onoff(0, 'myVariable', 1)
catch ME
  disp(ME.message)
end

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc validateattributes">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc validatestring">
% matlab/validatestring</a>
% </html>
% ,
% <html>
% <a href="matlab:doc error">
% matlab/error</a>
% </html>
% ,
% <html>
% <a href="matlab:doc ischar">
% matlab/ischar</a>
% </html>
%
% and is called by:
%
% (all functions)
%
%% See Also
% 
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isn0">
% script_collection/isN0</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isn">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isr">
% script_collection/isR</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isz">
% script_collection/isZ</a>
% </html>
%
%% TODOs
% # create documentation of script file
%
%% <<AuthorTag_DG/>>


