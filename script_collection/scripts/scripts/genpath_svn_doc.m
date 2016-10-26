%% Syntax
%       p= genpath_svn()
%       genpath_svn(folderName)
%
%% Description
% |p= genpath_svn()| returns a path string that includes all the folders
% and subfolders below |matlabroot/toolbox|, including empty subfolders.
% The behaviour is exactly the same as <matlab:doc('genpath') genpath>.
% Does not include folders, containing '.svn' (SVN repository). 
%
%%
% @return |p| : the returned path string, a char. 
%
%%
% |genpath_svn(folderName)| returns a path string that includes
% |folderName| and multiple levels of subfolders below folderName. The path
% string does not include folders named |private| or folders that begin
% with the |@| character (class folders) or the |+| character (package
% folders). Also does not include folders, containing '.svn' (SVN
% repository). 
%
%%
% @param |folderName| : char with the path to a folder. 
%
%% Example
%
% 

genpath_svn(pwd)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc genpath">
% matlab/genpath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc cellfun">
% matlab/cellfun</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% -
%
%% TODOs
% # create documentation for script file
% # check documentation
%
%% <<AuthorTag_DG/>>


