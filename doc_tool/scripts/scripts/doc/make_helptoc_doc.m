%% Syntax
%       []= make_helptoc(toolbox)
%
%% Description
% |make_helptoc(toolbox)| creates helptoc files of MATLAB's help system.
% For version 2009a and 2009b and later each one helptoc.xml file is
% created. 
%
%%
% @param |toolbox| : child class of <matlab:doc('gecoc_tool') gecoc_tool>
%
%% Example
%
% |make_helptoc(doc_tool);|
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="..\tool\gethelppath.html">
% doc_tool/getHelpPath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('gecoc_tool_def/gettoolboxpath')">
% gecoc_tool_def/getToolboxPath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc cell2file">
% io_tool/cell2file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc file2cell">
% io_tool/file2cell</a>
% </html>
% ,
% <html>
% <a href="replace_entry.html">
% doc_tool/replace_entry</a>
% </html>
% ,
% <html>
% <a href="matlab:doc xslt">
% doc xslt</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="publish_toolbox.html">
% publish_toolbox</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="gettoolboxdevelopmentstatus.html">
% getToolboxDevelopmentStatus</a>
% </html>
%
%% TODOs
% # the number of comments in the file userguide.xml is restricted due to
% the implementation of this function
% # am ende der datei gibt es ein TODO
% # improve documentation
%
%% <<AuthorTag_DG/>>


    