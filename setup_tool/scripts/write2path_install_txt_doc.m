%% Syntax
%       write2path_install_txt(bibpath)
%       write2path_install_txt(bibpath, inuninstall)
%       write2path_install_txt(bibpath, inuninstall, fileID)
%       write2path_install_txt(bibpath, inuninstall, fileID, file_op_cl)
%
%% Description
% |write2path_install_txt(bibpath)| opens, writes in and closes file
% 'path_install.txt'. This file contains all subfolders of the toolbox
% located in the path |bibpath|. Furthermore,
% it sets the path including all subfolders in the MATLAB path. Not all
% subfolders located in |bibpath| are folders belonging to the toolbox,
% only those are, that include an empty txt file |InPath.txt|. 
%
%%
% @param |bibpath| : path to the entry folder of the toolbox, e.g. 
% 'C:/Programme/MATLAB/R2009a/toolbox/myToolbox'. It has to be
% the path in which the |install_myToolbox.m| file is located. 
%
%%
% |write2path_install_txt(bibpath, inuninstall)| 
% 
%%
% @param |inuninstall| : <matlab:doc('function_handle') function_handle>,
% which decides if the path is added or deleted 
%
% * @rmpath to uninstall
% * @addpath to install
%
% The default value is @addpath.
%
%%
% |write2path_install_txt(bibpath, inuninstall, fileID)| 
% 
%%
% @param |fileID| : ID of the file to be written in, is e.g. returned by
% |fileID= fopen(...)|
% 
%%
% @param |file_op_cl| : 0 or 1
%
% * 0 : does not open and close the file 'path_install.txt'. This had to be
% done before and after calling this function and returned file ID must be
% given by |fileID|. 
% * 1 : opens and closes file 'path_install.txt'. (Default). 
%
%% Example
%
% If the current directory (<matlab:doc('pwd') pwd>) is the path to this
% file, then you can call the function as 
%
% |write2path_install_txt(pwd)|
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="gettoolboxfolderstructure.html">
% getToolboxFolderStructure</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="setpath_tool.html">
% setpath_tool</a>
% </html>
%
%% See Also
%
% <html>
% <a href="install_tool.html">
% install_tool</a>
% </html>
% ,
% <html>
% <a href="addpath2toolbox_fast.html">
% addpath2toolbox_fast</a>
% </html>
%
%% TODOs
% # Improve documentation a little bit
%
%% <<AuthorTag_DG/>>


