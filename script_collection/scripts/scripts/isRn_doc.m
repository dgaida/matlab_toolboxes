%% Syntax
%       isRn(argument, argument_name, argument_number)
%       isRn(argument, argument_name, argument_number, plusminus)
%
%% Description
% |isRn(argument, argument_name, argument_number)| checks if the given
% |argument| is a real vector. The argument has the name
% |argument_name| and is the |argument_number| th argument of the calling
% function. 
%
%%
% @param |argument| : The argument that will be checked. Should be a double
% vector with any value. May also be a one dimensional
% vector, thus a scalar. Because we do not check for the dimension, it is
% better to use <isr.html isR> if the argument must be a scalar. 
%
%%
% @param |argument_name| : char with the name of the argument. 
%
%%
% @param |argument_number| : number of the argument in the calling
% function. double scalar integer. 
%
%%
% |isRn(argument, argument_name, argument_number, plusminus)| checks if the
% given |argument| belongs to $R^{n+}$ or $R^{n-}$, depending on |plusminus|. 
%
%%
% @param |plusminus| : char, default: [].
%
% * '+' : checks if |argument| belongs to $R^{n+}$ : all values >= 0
% * '-' : checks if |argument| belongs to $R^{n-}$ : all values <= 0
%
%% Example
% 
% This call is ok

isRn([0.54, 1, 0.1, -0.2], 'myVariable', 3)

%%
% The next three calls throw an error

try
  isRn([0.6i, 1, -0.1], 'myVariable', 1)
catch ME
  disp(ME.message)
end

%%
%

try
  isRn([-1.5, 1, 0], 'myVariable', 1, '+')
catch ME
  disp(ME.message)
end

%%
%

try
  isRn([1.5, -3.11, pi], 'myVariable', 1, '-')
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
% <a href="matlab:doc script_collection/isr">
% script_collection/isR</a>
% </html>
% ,
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


