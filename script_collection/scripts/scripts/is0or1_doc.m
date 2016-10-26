%% Syntax
%       is0or1(argument, argument_name, argument_number)
%
%% Description
% |is0or1(argument, argument_name, argument_number)| checks if the given
% |argument| is 0 or 1. The argument has the name |argument_name| and is
% the |argument_number| th argument of the calling function. 
%
%%
% @param |argument| : The argument that will be checked. Should be a double
% scalar with value 0 or 1. May also be a logical scalar, thus true or
% false. 
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

is0or1(1, 'myVariable', 3)

%%

is0or1(true, 'myVariable', 3)

%%
% The next two calls throw an error

try
  is0or1(2, 'myVariable', 1)
catch ME
  disp(ME.message)
end

%%
%

try
  is0or1(0.6, 'myVariable', 1)
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


