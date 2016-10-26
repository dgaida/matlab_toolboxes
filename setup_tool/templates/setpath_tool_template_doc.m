%% Syntax
%       setpath_<<toolbox_id/>>(tool_path)
%       setpath_<<toolbox_id/>>(tool_path, inuninstall)
%       setpath_<<toolbox_id/>>(tool_path, inuninstall, fileID)
%
%% Description
% |setpath_<<toolbox_id/>>(tool_path)| sets the path to the 
% _<<toolbox_name/>>_ Toolbox, which must be located at the path 
% |tool_path|. This means, that it adds the folders of the toolbox to the
% MATLAB <matlab:doc('path') path>. If the toolbox located there is
% installed (see <install_<<toolbox_id/>>.html |install_<<toolbox_id/>>|>),
% this function is called on every MATLAB startup via the
% <matlab:edit('startup.m') |startup.m|> m-file. The complete path of the
% toolbox is read out of the function
% <matlab:doc('setup_tool/gettoolboxfolderstructure') 
% |setup_tool/getToolboxFolderStructure|>. This function only calls the
% function <matlab:doc('setpath_tool') setpath_tool>, for more help have a
% look there. 
%
%%
% @param |tool_path| : path to the entry folder of the toolbox, e.g. 
% 'C:/Programme/MATLAB/R2009a/toolbox/<<toolbox_id/>>'. It has to be
% the path in which the |install_<<toolbox_id/>>.m| file is located. This
% path is returned by the method 
% <matlab:doc('<<toolbox_id/>>/getToolboxPath') 
% <<toolbox_id/>>/getToolboxPath>. 
%
%%
% |setpath_<<toolbox_id/>>(tool_path, inuninstall)| sets or removes the paths to
% the toolbox, depending on the parameter |inuninstall|.
% 
%%
% @param |inuninstall| : <matlab:doc('function_handle') function_handle>,
% which decides if the paths are added or deleted to/from the MATLAB
% <matlab:doc('path') path> 
%
% * |@rmpath| to uninstall, see <matlab:doc('rmpath') rmpath>
% * |@addpath| to install, see <matlab:doc('addpath') addpath>
%
% The default value is |@addpath|.
%
%%
% |setpath_<<toolbox_id/>>(tool_path, inuninstall, fileID)| additionally logs in
% the file |fileID| what paths were set.
% 
%%
% @param |fileID| : ID of the file to be written in, is e.g. returned by
% |fileID= <matlab:doc('fopen') fopen>(...)|. The file must be open before
% this function is called. 
% 
%% Example
%
% If the current directory (<matlab:doc('pwd') pwd>) is the path to this
% file, then you can call the function as 
%
% |setpath_<<toolbox_id/>>(pwd)|
%
% to add the folders of the toolbox to the MATLAB path. 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('setup_tool/setpath_tool')">
% setup_tool/setpath_tool</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('install_tool')">
% setup_tool/install_tool</a>
% </html>
% ,
% <html>
% <a href="matlab:edit('startup.m')">
% startup.m</a>
% </html>
%
%% See Also
%
% <html>
% <a href="install_<<toolbox_id/>>.html">
% install_<<toolbox_id/>></a>
% </html>
% ,
% <html>
% <a href="matlab:doc('path')">
% matlab/path</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('addpath')">
% matlab/addpath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('rmpath')">
% matlab/rmpath</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


