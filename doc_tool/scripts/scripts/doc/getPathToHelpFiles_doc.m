%% Syntax
%       path_help= getPathToHelpFiles(toolbox_path)
%
%% Description
% |path_help= getPathToHelpFiles(toolbox_path)| returns the full path to the
% folder 'help_mfiles'. 
% 
%%
% @param |toolbox_path| : char with the entry path of the toolbox. 
%
%%
% @return |path_help| : path to the folder 'help_mfiles'. 
%
%% Example
%
% 

getPathToHelpFiles(doc_tool.getToolboxPath())


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/fullfile')">
% matlab/fullfile</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="make_user_guide.html">
% make_user_guide</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="getpathtoreleasenotes.html">
% getPathToReleaseNotes</a>
% </html>
% ,
% <html>
% <a href="getpublicationlocation.html">
% getPublicationLocation</a>
% </html>
% ,
% <html>
% <a href="publish_toolbox.html">
% publish_toolbox</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('doc_tool/gettoolboxpath')">
% doc_tool/getToolboxPath</a>
% </html>
%
%% TODOs
% # 
%
%% <<AuthorTag_DG/>>


