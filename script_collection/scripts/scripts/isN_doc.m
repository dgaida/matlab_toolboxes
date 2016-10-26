%% Syntax
%       isN(argument, argument_name, argument_number)
%
%% Description
% |isN(argument, argument_name, argument_number)| checks if the given
% |argument| is a natural number 1,2,3,... The argument has the name
% |argument_name| and is the |argument_number| th argument of the calling
% function. 
%
%%
% @param |argument| : The argument that will be checked. Should be a double
% scalar with value > 0: 1, 2, 3, ... 
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
% This call is ok

isN(1, 'myVariable', 3)

%%
% The next two calls throw an error

try
  isN(0, 'myVariable', 1)
catch ME
  disp(ME.message)
end

%%
%

try
  isN(0.6, 'myVariable', 1)
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
% <a href="matlab:doc script_collection/is0or1">
% script_collection/is0or1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isn0">
% script_collection/isN0</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isnn">
% script_collection/isNn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isn0n">
% script_collection/isN0n</a>
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


