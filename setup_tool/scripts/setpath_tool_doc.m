%% Syntax
%       setpath_tool(bibpath)
%       setpath_tool(bibpath, inuninstall)
%       setpath_tool(bibpath, inuninstall, fileID)
%       setpath_tool(bibpath, inuninstall, fileID, do_fast)
%
%% Description
% |setpath_tool(bibpath)| sets the path to the toolbox located in the path
% |bibpath|. If the toolbox located there is installed (see
% <install_tool.html |install_tool|>), this 
% function is called on every MATLAB startup via the
% <matlab:edit('startup.m') |startup.m|> file (see also:
% <matlab:doc('matlab/startup') matlab/startup>). The complete path of the 
% toolbox is read out of the function <gettoolboxfolderstructure.html
% |getToolboxFolderStructure|>. 
%
%%
% @param |bibpath| : path to the entry folder of the toolbox, e.g. 
% 'C:/Programme/MATLAB/R2009a/toolbox/myToolbox'. It has to be
% the path in which the |install_myToolbox.m| file is located.
%
%%
% |setpath_tool(bibpath, inuninstall)| sets or removes the paths to
% the toolbox, depending on the parameter |inuninstall|.
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
% |setpath_tool(bibpath, inuninstall, fileID)| additionally logs in
% the file |fileID| what pathes were set.
% 
%%
% @param |fileID| : ID of the file to be written in, is e.g. returned by
% |fileID= fopen(...)|
% 
%%
% @param |do_fast| : 0 or 1
%
% * 0 : the paths of the toolbox is determined by going through all
% subfolders of the toolbox looking for the file |InPath.txt|. 
% * 1 : reads paths of toolbox out of file |path_install.txt| calling
% <addpath2toolbox_fast.html addpath2toolbox_fast>. This makes the startup
% of MATLAB much faster. 
%
%% Example
%
% If the current directory (<matlab:doc('pwd') pwd>) is the path to this
% file, then you can call the function as 
%
% |setpath_tool(pwd)|
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="addpath2toolbox_fast.html">
% addpath2toolbox_fast</a>
% </html>
% ,
% <html>
% <a href="write2path_install_txt.html">
% write2path_install_txt</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="setpath_setup_tool.html">
% setpath_setup_tool</a>
% </html>
%
%% See Also
%
% <html>
% <a href="install_tool.html">
% install_tool</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


