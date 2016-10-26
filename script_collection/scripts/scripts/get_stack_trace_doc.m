%% Syntax
%       msg= get_stack_trace(s)
%       
%% Description
% |msg= get_stack_trace(s)| returns the trace to where the error |s|
% happened.
%
%%
% @param |s| : Either a struct containing a field called |stack| or a
% <matlab:doc('MException') MException> object. Useful to analyze errors.
% The output is not as nice as when MATLAB prints a stack trace when an
% error occurs, but maybe sometimes this function could be helpful.
%
%%
% @return |msg| : char with the stack trace
% 
%% Example
%
% 

try
  checkDimensionOfVariable(ones(1,2), [1, 3])
catch ME
  disp('-x-x-x-x-x-')
  disp(get_stack_trace(ME));
end

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc which">
% matlab/which</a>
% </html>
%
% and is called by:
%
% -
%
%% See Also
%
% <html>
% <a href="matlab:doc MException">
% matlab/MException</a>
% </html>
% ,
% <html>
% <a href="matlab:doc try">
% matlab/try</a>
% </html>
%
%% TODOs
% # Add documentation in script file.
% # document code a little better
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <a href=
% "http://www.mathworks.com/matlabcentral/fileexchange/30555-testit/content/testit/get_stack_trace.m">
% www.mathworks.com/matlabcentral/fileexchange/.../get_stack_trace.m</a> 
% </html>
%


