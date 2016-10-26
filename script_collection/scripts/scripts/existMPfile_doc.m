%% Syntax
%       doesExist= existMPfile(function_name)
%       existMPfile(function_name, throw_error)
%
%% Description
% |doesExist= existMPfile(function_name)| checks if the function
% |function_name| either exists as m- or as p-file. If it exists at least
% as one of the two a |1| is returned, else |doesExist| is |0|.
%
%%
% @param |function_name| : char with the name of the function to be
% checked. The function may be given with or without file extension and
% with or without the full path. See the examples.
%
%%
% @return |doesExist| : 0 or 1
%
% * 0 : if the file |function_name| does not exist as m-file nor as p-file.
% * 1 : if the file |function_name| does exist as m-file or as p-file.
%
%%
% |existMPfile(function_name, throw_error)| throws an error, in case the
% file is not existent, if |throw_error| is 1. 0 is the default.
%
%%
% @param |throw_error| : double scalar: 0 or 1.
%
% * 0 : no error is thrown (default)
% * 1 : an error is thrown in case the file |function_name| is not existent
%
%% Example
%
% The first two examples return a 1, the last example a 0, in case this
% function is not located on C.

existMPfile('existMPfile')

%%

existMPfile('existMPfile.m')

%%

existMPfile(fullfile('C:', 'existMPfile.m'))

%%
% throws an error, in case this function is not located on C.

try
  existMPfile(fullfile('C:', 'existMPfile.m'), 1);
catch ME
  disp(ME.message);
end

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
% <a href="matlab:doc script_collection/is0or1">
% script_collection/is0or1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc validateattributes">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc exist">
% matlab/exist</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% <html>
% <a href="matlab:doc pcode">
% matlab/pcode</a>
% </html>
%
%% TODOs
% # create documentation for script file
%
%% <<AuthorTag_DG/>>


