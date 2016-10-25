%% Syntax
%       fileList= getAllFiles(dirName)
%
%% Description
% |fileList= getAllFiles(dirName)| gets path + filename to all files inside
% given folder and all subfolders as <matlab:doc('cellstr') cell array of
% strings>. Filters out svn folders looking for '.svn'. 
%
%%
% @param |dirName| : char with the path to a folder
%
%%
% @return |fileList| : <matlab:doc('cellstr') cell array of strings> of
% path + filename. Each cell element contains one path respectively file. 
%
%% Example
%
% Get all files inside folder scripts/tool of this toolbox folder
%

getAllFiles( fullfile(io_tool.getToolboxPath(), 'scripts', 'tool') )


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc dir">
% matlab/dir</a>
% </html>
% ,
% <html>
% <a href="matlab:doc cellfun">
% matlab/cellfun</a>
% </html>
% ,
% <html>
% <a href="matlab:doc ismember">
% matlab/ismember</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc publish_toolbox">
% doc_tool/publish_toolbox</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="matlab:doc setup_tool/rdir">
% setup_tool/rdir</a>
% </html>
% ,
% <html>
% <a href="matlab:doc setup_tool/fdir">
% setup_tool/fdir</a>
% </html>
% ,
% <html>
% <a href="matlab:doc io_tool/getallsubfolders">
% io_tool/getAllSubfolders</a>
% </html>
%
%% TODOs
% # create documentation for script file
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <a href="http://code.google.com/p/mtex/">
% http://code.google.com/p/mtex/</a>
% </html>
%


