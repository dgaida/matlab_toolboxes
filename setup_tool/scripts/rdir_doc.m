%% Syntax
%       [D] = rdir(ROOT,TEST)
%
%% Description
% |[D] = rdir(ROOT, TEST)| lists the files in a directory and its sub
% directories by recursive directory listing. 
%
%%
% @param |ROOT| : is the directory starting point and includes the 
% wildcard specification. The function returns a structure |D| similar to
% the one returned by the built-in <matlab:doc('dir') dir> command. 
% There is one exception, the name field will include 
% the relative path as well as the name to the file that was found.
% Pathnames and wildcards may be used. Wild cards can exist
% in the pathname too. A special case is the double * that
% will match multiple directory levels, e.g. c:\**\*.m. 
% Otherwise a single * will only match one directory level.
% e.g. C:\Program Files\Windows *\
%
%%
% @param |TEST| : is an optional test that can be performed on the 
% files. Two variables are supported, datenum & bytes.
% Tests are strings similar to what one would use in a 
% if statement. e.g. 'bytes>1024 & datenum>now-7'
%
% If not output variables are specified then the output is 
% sent to the screen.
%
%% Examples
% examples:
%   

D= rdir('*.m');
for ii=1:length(D), disp(D(ii).name); end;

%%
% to find all files in the current directory and sub directories
% 

D= rdir('**\*');
disp(D)

%%
% If no output is specified then the files are sent to 
% the screen.
% 

rdir('c:\program files\windows *\*.exe');
rdir('c:\program files\windows *\**\*.dll');

%% 
% Using the test function to find files modified today
% 

rdir('c:\win*\*','datenum>floor(now)');

%%
% Using the test function to find files of a certain size
%   

rdir('c:\program files\win*\*.exe','bytes>1024 & bytes<1048576');

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('matlab/find')">
% matlab/find</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/dir')">
% matlab/dir</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('setup_tool/fdir')">
% setup_tool/fdir</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('doc_tool/getrelpathtohtmlfile')">
% doc_tool/getRelPathToHTMLFile</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('matlab/dir')">
% matlab/dir</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('setup_tool')">
% setup_tool</a>
% </html>
%
%% Author
% Matlab File Exchange (File ID: #19550) Author: G. Brown
%
%% TODOs
% # improve documentation
% # understand code
%
%% <<AuthorTag_DG/>>


