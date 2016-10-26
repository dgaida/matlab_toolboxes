%% Syntax
%       shutdown()
%       shutdown(numsec)
%       shutdown(-1)
%
%% Description
% |shutdown| turns off the computer in 60 seconds. The system shudown
% command is executed with the appropriate options to force any running
% applications to close, so be sure so save your data and close other
% applications before beginning your unattended Matlab calculation (and
% design your Matlab calculation to save its own data before terminating).
% You can use this function BEFORE starting your calculation, by estimating
% the required execution time, or you can use this function AFTER the
% calculation (recommended) by calling it when your calculation is
% complete. 
% 
%%
% |shutdown(numsec)| turns off the computer in |numsec| seconds. 
%
%%
% @param |numsec| : optional number of seconds to pause after system
% shutdown window is displayed (default is 60 seconds). If numsec is -1,
% then the command aborts a shutdown countdown currently in progress.
%
%%
% |shutdown(-1)| aborts the shutdown; don't turn off the computer. 
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% -
%
% and is called by:
%
% (the user)
%
%% See Also
%   
%
%% TODOs
% 
%
%% Author
% Michael Kleder, Oct 2005
%
%% <<AuthorTag_DG/>>


