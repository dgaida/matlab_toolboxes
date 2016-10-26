%% Syntax
%       isZ(argument, argument_name, argument_number)
%       isZ(argument, argument_name, argument_number, lb)
%       isZ(argument, argument_name, argument_number, lb, ub)
%
%% Description
% |isZ(argument, argument_name, argument_number)| checks if the given
% |argument| is an integer ...,-3,-2,-1,0,1,2,3,... The argument has the name
% |argument_name| and is the |argument_number| th argument of the calling
% function. 
%
%%
% @param |argument| : The argument that will be checked. Should be a double
% scalar with values: ...,-3,-2,-1,0,1,2,3,...
%
%%
% @param |argument_name| : char with the name of the argument. 
%
%%
% @param |argument_number| : number of the argument in the calling
% function. double scalar integer. 
%
%%
% |isZ(argument, argument_name, argument_number, lb)| checks if the given
% |argument| is an integer ...,-3,-2,-1,0,1,2,3,... which satisfies a lower
% boundary |lb|. 
%
%%
% @param |lb| : lower boundary, double scalar integer. 
%
%%
% |isZ(argument, argument_name, argument_number, lb, ub)| checks if the given
% |argument| is an integer ...,-3,-2,-1,0,1,2,3,... which satisfies a lower
% |lb| and an upper boundary. If |lb| is empty, then |argument| only has to
% satisfy the upper boundary |ub|. 
%
%%
% @param |ub| : upper boundary, double scalar integer. 
%
%% Example
% 
% These two calls are ok

isZ(1, 'myVariable', 3)

isZ(-10, 'myVariable', 1)

%%
% this call throws an error

try
  isZ(0.6, 'myVariable', 1)
catch ME
  disp(ME.message)
end

%%
%

try
  isZ(-1, 'myVariable', 1, 1)
catch ME
  disp(ME.message)
end

%%
%

isZ(2, 'myVariable', 1, 1, 3)

isZ(-2, 'myVariable', 1, [], 3)

%%

try
  isZ(-1, 'myVariable', 1, 1, 3)
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
% <a href="matlab:doc script_collection/isn">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isn0">
% script_collection/isN0</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isr">
% script_collection/isR</a>
% </html>
%
%% TODOs
% # create documentation of script file
%
%% <<AuthorTag_DG/>>


