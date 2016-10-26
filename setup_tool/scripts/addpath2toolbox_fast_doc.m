%% Syntax
%       addpath2toolbox_fast(bibpath)
%       err_flag= addpath2toolbox_fast(bibpath)
%
%% Description
% |addpath2toolbox_fast(bibpath)| adds paths of a toolbox to MATLAB path
% reading 'path_install.txt'. The txt file must exist in the path
% |bibpath|. 
%
%%
% @param |bibpath| : path to the entry folder of the toolbox, e.g. 
% 'C:/Programme/MATLAB/R2009a/toolbox/myToolbox'. It has to be
% the path in which the |path_install.txt| file is located.
%
%%
% @return |err_flag| : 0, -1
%
% * 0 : no error occured
% * -1 : an error occured reading the file path_install.txt. Maybe the file
% does not exist. Is also returned if a warning is thrown by the MATLAB
% function <matlab:doc('addpath') addpath>. 
%
%% Example
%
% get the path in which 'path_install.txt' should be located. A 0 is
% returned, so everything is OK.

mypwd= setup_tool.getToolboxPath();

disp(addpath2toolbox_fast(mypwd))


%%
%
% if the given path does not contain the txt file, then an error flag is
% returned (-1).

cd(mypwd)
cd('..')

disp(addpath2toolbox_fast(pwd))


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('addpath')">
% matlab/addpath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('importdata')">
% matlab/importdata</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('lastwarn')">
% matlab/lastwarn</a>
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
% <a href="write2path_install_txt.html">
% write2path_install_txt</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


