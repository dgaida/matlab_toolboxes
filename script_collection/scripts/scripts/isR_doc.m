%% Syntax
%       isR(argument, argument_name, argument_number)
%       isR(argument, argument_name, argument_number, plusminus)
%
%% Description
% |isR(argument, argument_name, argument_number)| checks if the given
% |argument| is a real scalar number. The argument has the name
% |argument_name| and is the |argument_number| th argument of the calling
% function. 
%
%%
% @param |argument| : The argument that will be checked. Should be a double
% scalar with any value.
%
%%
% @param |argument_name| : char with the name of the argument. 
%
%%
% @param |argument_number| : number of the argument in the calling
% function. double scalar integer. 
%
%%
% |isR(argument, argument_name, argument_number, plusminus)| checks if the
% given |argument| belongs to $R^+$ or $R^-$, depending on |plusminus|. 
%
%%
% @param |plusminus| : char, default: [].
%
% * '+' : checks if |argument| belongs to $R^+$ : all values >= 0
% * '-' : checks if |argument| belongs to $R^-$ : all values <= 0
%
%% Example
% 
% This call is ok

isR(0.54, 'myVariable', 3)

%%
% The next four calls throw an error

try
  isR([0 1], 'myVariable', 1)
catch ME
  disp(ME.message)
end

%%
%

try
  isR(0.6i, 'myVariable', 1)
catch ME
  disp(ME.message)
end

%%
%

try
  isR(-1.5, 'myVariable', 1, '+')
catch ME
  disp(ME.message)
end

%%
%

try
  isR(1.5, 'myVariable', 1, '-')
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
% <a href="matlab:doc validatestring">
% matlab/validatestring</a>
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
% <a href="matlab:doc script_collection/isn">
% script_collection/isN</a>
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


