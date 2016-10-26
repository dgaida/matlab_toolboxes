%% Syntax
%       getToolboxFolderStructure(tool_path)
%       rel_path_m= getToolboxFolderStructure(tool_path)
%
%% Description
% |rel_path_m= getToolboxFolderStructure(tool_path)| returns a cell array
% of strings (<matlab:doc('cellstr') cellstr>) containing all subfolders of
% |tool_path| which should be included to the toolbox's path
% (<matlab:doc('matlab/path') MATLAB path>). 
% Therefore the function first looks for all subfolders, 
% calling <getallsubfolders.html |getAllSubfolders|> and then looks inside
% these subfolders for the file |InPath.txt|. If this file can be found in
% a subfolder then the path to this subfolder is added to |rel_path_m|.
%
%%
% @param |tool_path| : path to the entry folder of the toolbox, e.g. 
% 'C:/Programme/MATLAB/R2009a/toolbox/myToolbox'. It has to be
% the path in which the <getallsubfolders.html |getAllSubfolders.m|> file
% is located. 
%
%%
% @return |rel_path_m| : cell array of strings containing all subfolders of
% |tool_path| which are inside the toolbox's path. 
%
%% Example
%
% If the current directory (<matlab:doc('pwd') pwd>) is the path to this
% file, then you can call the function as 
%

getToolboxFolderStructure(pwd)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="getallsubfolders.html">
% setup_tool/getAllSubfolders</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('gettoolboxdevelopmentstatus')">
% doc_tool/getToolboxDevelopmentStatus</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('publish_toolbox')">
% doc_tool/publish_toolbox</a>
% </html>
% ,
% <html>
% <a href="setpath_tool.html">
% setup_tool/setpath_tool</a>
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
% <a href="matlab:doc('matlab/path')">
% matlab/path</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


