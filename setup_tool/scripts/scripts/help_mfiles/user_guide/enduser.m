%% Introduction
% This toolbox contains the install and uninstall functions of the GECO-C
% MATLAB toolboxes, see <matlab:doc('gecoc_tool_def') gecoc_tool_def>.
% Usually you do not get in touch with this toolbox, you 
% just use it indirectly, when you install other toolboxes.
%
%
%% When to use the toolbox
% The files in this toolbox are called on three occasions:
%
% # Upon installation of a toolbox. See the file
% <matlab:doc('setup_tool/install_tool') install_tool> and functions called
% therein. 
% # On MATLAB startup. If a toolbox is installed in the
% <matlab:doc('matlab/startup') startup.m> file a few lines are written for
% the toolbox which sets the path to the toolbox. See the function
% <matlab:doc('setup_tool/setpath_tool') setpath_tool> and functions called
% therein. 
% # Upon uninstallation of a toolbox. So far there is no script which
% uninstalls a toolbox. However, there is a txt file 'uninstall_tool.txt'
% which describes how a toolbox can be uninstalled. The reason why no
% function does exist is that no function can guarantee whether the toolbox
% is really uninstalled afterwards, because of various things. 
%
% If you obtain error messages upon installation of a toolbox or at the
% startup of MATLAB you might want to have a look into these functions. 
%
%
%% Important txt files
% 
% # installed_versions.txt : Is created upon installation of the toolbox by
% the function <matlab:doc('setup_tool/install_tool') install_tool>. It is
% located in the MATLAB installation folder under 'toolbox/toolbox_id' and
% contains absolute pathes to all installed versions of the toolbox
% 'toolbox_id'. This file might be useful to remember which toolbox
% versions are installed and to change between versions. 
% # start_version.txt : Is created upon installation of the toolbox by
% the function <matlab:doc('setup_tool/install_tool') install_tool>. It is
% located in the MATLAB installation folder under 'toolbox/toolbox_id' and
% contains the absolute path to the toolbox version which is installed at
% the MATLAB startup. 
% # path_install.txt : Is created upon installation of the toolbox by
% the function <matlab:doc('setup_tool/install_tool') install_tool>. It is
% located in the main folder of the toolbox. It contains a list of all
% subfolders that belong to the toolbox. This file is opened at Startup of
% MATLAB to set the MATLAB path to all subfolders listed in the file. Not
% all subfolders are listed in this file, but only those that include the
% txt file 'InPath.txt', see below. 
% # InPath.txt : Is located in subfolders of the toolbox and is provided by
% the developer of the toolbox. If a subfolder contains this file, then
% this subfolder is added to the MATLAB path at startup. All subfolders
% containing a InPath.txt file are listed in the path_install.txt file. The
% file InPath.txt itself is empty. 
%
%% Useful functions
% This toolbox contains the functions <matlab:doc('setup_tool/rdir')
% |rdir|>, <matlab:doc('setup_tool/fdir') |fdir|> and
% <matlab:doc('setup_tool/getallsubfolders') getAllSubfolders> which are
% quite useful in general. 
%


