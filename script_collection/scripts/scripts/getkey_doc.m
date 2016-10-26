%% Syntax
%       ch= getkey
%       ch= getkey('non-ascii')
%
%% Description
% |ch = getkey| waits for a keypress and returns the ASCII code. Accepts
% all ascii characters, including backspace (8), space (32), enter (13),
% etc, that can be typed on the keyboard. Non-ascii keys (ctrl, alt, ..)
% return a NaN. 
%
%%
% @return |ch| is a double. 
%
%%
% |ch = getkey('non-ascii')| uses non-documented matlab features to return
% a string describing the key pressed. In this way keys like ctrl, alt,
% tab etc. can also distinguished. 
%
%%
% @return |ch| : is a string.
%
%%
% This function is kind of a workaround for getch in C. It uses a modal,
% but non-visible window, which does show up in the taskbar.
% C-language keywords: KBHIT, KEYPRESS, GETKEY, GETCH
%
%% Example
%

fprintf('\nPress any key: ');
ch = getkey;
fprintf('%c\n',ch);

fprintf('\nPress the Ctrl-key: ');
if strcmp(getkey('non-ascii'),'control'),
 fprintf('OK\n');
else
 fprintf(' ... wrong key ...\n');
end

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc uiwait">
% matlab/uiwait</a>
% </html>
% ,
% <html>
% <a href="matlab:doc figure">
% matlab/figure</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
%
% <html>
% <a href="matlab:doc input">
% matlab/input</a>
% </html>
% ,
% <html>
% <a href="http://www.mathworks.com/matlabcentral/fileexchange/8297-getkeywait">
% www.mathworks.com/matlabcentral/fileexchange/8297-getkeywait</a>
% </html>
%
%%
% for Matlab 6.5 and higher
%
% version 1.2 (apr 2009)
%
% author : Jos van der Geest
% 
% email  : jos@jasen.nl
%
%%
% History
%
% 2005 - creation
%
% dec 2006 - modified lay-out and help
%
% apr 2009 - tested for more recent MatLab releases 
%
%% TODOs
% # check documentation
% # there is a new release online
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <a href="http://www.mathworks.com/matlabcentral/fileexchange/7465-getkey">
% www.mathworks.com/matlabcentral/fileexchange
% </a>
% </html>
%


