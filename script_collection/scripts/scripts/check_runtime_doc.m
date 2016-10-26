%% Syntax
%       [runtime]= check_runtime(func_handle)
%       [...]= check_runtime(func_handle, args)
%       [...]= check_runtime(func_handle, args, iterations)
%       [...]= check_runtime(func_handle, args, iterations, nTests)
%       [runtime, runtimes]= check_runtime(...)
%
%% Description
% |[runtime]= check_runtime(func_handle)| checks the runtime of the given
% function |func_handle|. To determine the runtime of the given function,
% measured in sec, the function is called |nTests| * |iterations| times. For
% more details see the description of the function arguments below. The
% function plots a histogram of the |nTests| obtained runtimes of the given
% function using <matlab:doc('hist') matlab/hist>.
%
% Remark: Using this function it was prooved that it is faster to use a
% global variable to check whether we are in debug mode or not, than to add
% an extra argument to each function which signalizes whether we are in
% debug mode or not. 
%
%%
% @param |func_handle| : <matlab:doc('matlab/function_handle')
% function_handle> of the to be called function. 
%
%%
% @param |args| : arguments of the function |func_handle| as cell. If the
% function has no arguments, then set to []. Default: []. 
%
%%
% @param |iterations| : the function is called that many times to get a
% better estimate of the run time of the function. For very fast functions
% it should be large, for slow functions it should be 1. A natural number
% >= 1. Default: 10. 
%
%%
% @param |nTests| : To get the distribution of the runtime of the given
% function |func_handle| 
% it is called |nTests| * |iterations| times. As default it is called 10 *
% |iterations| times. 
%
%%
% @return |runtime| : the median runtime of the function in seconds. 
%
%%
% @return |runtimes| : |nTests| dimensional vector with the runtimes of the
% function. 
% 
%% Example
% 
% The global flag IS_DEBUG is used inside the function
% <matlab:doc('script_collection/checkargument')
% script_collection/checkArgument>. If IS_DEBUG == 1, then the function is
% slower, this shown here. 

global IS_DEBUG;

IS_DEBUG= 1;

check_runtime(@(a, b)checkArgument(a, b, 'char', '1st'), {6, 'myVar'}, 500, 30);

%%
% assigninMWS calls checkArgument, so this call will also be slower than
% the call below. 

check_runtime(@()assigninMWS('a', 6), [], 500, 30);

%%
% set IS_DEBUG to 0, to see that the following calls are faster as the ones
% above.  

IS_DEBUG= 0;

check_runtime(@(a, b)checkArgument(a, b, 'char', '1st'), {6, 'myVar'}, 500, 30);

%%

check_runtime(@()assigninMWS('a', 6), [], 500, 30);

%%
% set IS_DEBUG back to 1 for other scripts

IS_DEBUG= 1;

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc feval">
% matlab/feval</a>
% </html>
% ,
% <html>
% <a href="matlab:doc tic">
% matlab/tic</a>
% </html>
% ,
% <html>
% <a href="matlab:doc toc">
% matlab/toc</a>
% </html>
% ,
% <html>
% <a href="matlab:doc hist">
% matlab/hist</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isn">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc median">
% matlab/median</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% <html>
% <a href="matlab:doc script_collection/assigninmws">
% script_collection/assigninMWS</a>
% </html>
%
%% TODOs
% # check documentation
%
%% <<AuthorTag_DG/>>


