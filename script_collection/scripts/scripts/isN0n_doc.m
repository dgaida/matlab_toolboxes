%% Syntax
%       isN0n(argument, argument_name, argument_number)
%
%% Description
% |isN0n(argument, argument_name, argument_number)| checks if the given
% |argument| is a n-dimensional  vector of natural number including zero
% 0,1,2,3,... The argument has the name |argument_name| and is the
% |argument_number| th argument of the calling function. 
%
%%
% @param |argument| : The argument that will be checked. Should be a double
% vector with values >= 0: 0, 1, 2, 3, ... May also be a one dimensional
% vector, thus a scalar. Because we do not check for the dimension, it is
% better to use <isn0.html isN0> if the argument must be a scalar. 
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

isN0n([1, 2, 3], 'myVariable', 3)

%%

isN0n([0, 4, 2, 1], 'myVariable', 1)

%%
% The next two calls throw an error

try
  isN0n([-1, 2, 0], 'myVariable', 1)
catch ME
  disp(ME.message)
end

%%
%

try
  isN0n([0.6, 100, 2, 10], 'myVariable', 1)
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
% <a href="matlab:doc script_collection/isrn">
% script_collection/isRn</a>
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


