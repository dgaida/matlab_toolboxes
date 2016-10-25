%% Syntax
%       path_rn= getPathToReleaseNotes(toolbox_path)
%
%% Description
% |path_rn= getPathToReleaseNotes(toolbox_path)| returns the full path to the
% folder 'rn'. 
% 
%%
% @param |toolbox_path| : char with the entry path of the toolbox. 
%
%%
% @return |path_rn| : path to the release notes folder 'rn'. 
%
%% Example
%
% 

getPathToReleaseNotes(doc_tool.getToolboxPath())


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="getpathtohelpfiles.html">
% getPathToHelpFiles</a>
% </html>
% ,
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
% <a href="make_release_notes.html">
% make_release_notes</a>
% </html>
% 
%% See Also
%
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


