%% Syntax
%       folderList= getAllSubfolders(current_path)
%       getAllSubfolders(current_path, rel_abs)
%       getAllSubfolders(current_path, rel_abs, inc_svn)
%
%% Description
% |folderList= getAllSubfolders(current_path)| returns a cell array
% of strings (<matlab:doc('cellstr') cellstr>) containing all subfolders of
% |current_path|. On default SVN folders are not listed, see parameter
% |inc_svn|. The paths are gotten calling the function
% <matlab:doc('setup_tool/fdir') fdir>. 
%
%%
% @param |current_path| : char with the path to a folder
%
%%
% @return |folderList| : cell array of strings containing all subfolders of
% |current_path|. Here the absolute path to each folder is given, see
% argument |rel_abs|. 
%
%%
% |getAllSubfolders(current_path, rel_abs)| returns a cell array
% of strings containing all subfolders of |current_path|. The paths are
% either relative or absolute.
%
%%
% @param |rel_abs| : char
%
% * 'rel' : relative paths are returned, relative to |current_path|
% * 'abs' : absolute paths are returned (Default)
%
%%
% |getAllSubfolders(current_path, rel_abs, inc_svn)| lets you specify
% whether svn folders should be included as well. SVN folders are detected
% looking for '.svn'.
%
%%
% @param |inc_svn| : scalar double
%
% * 0, do not include SVN folders (Default)
% * 1, include SVN folders
%
%% Example
%
% # Get the complete (absolute) pathes to all subfolders in current
% directory. 

paths= getAllSubfolders(pwd);

disp(paths);
disp( iscellstr(paths) );

%%
% # Get the relative pathes to all subfolders in current directory.

getAllSubfolders(pwd, 'rel')


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="fdir.html">
% setup_tool/fdir</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validatestring')">
% matlab/validatestring</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('make_release_notes')">
% doc_tool/make_release_notes</a>
% </html>
% ,
% <html>
% <a href="gettoolboxfolderstructure.html">
% setup_tool/getToolboxFolderStructure</a>
% </html>
%
%% See Also
%
% <html>
% <a href="install_tool.html">
% setup_tool/install_tool</a>
% </html>
% ,
% <html>
% <a href="setpath_tool.html">
% setup_tool/setpath_tool</a>
% </html>
%
%% TODOs
% # svn folders could also be different, not only '.svn'
%
%% <<AuthorTag_DG/>>


