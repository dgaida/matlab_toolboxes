%% Syntax
%       make_user_guide(path_doc_tool, toolbox_id, toolbox_path)
%
%% Description
% |make_user_guide(path_doc_tool, toolbox_id, toolbox_path)| creates the
% user guide for the given toolbox. Therefore it does the following:
% - Copy file 'user_guide_index.m'
% - Create files 'developer.m', 'developer_tool_template.m' and 'enduser.m'
% out of the templates
% - Create the file 'userguide.xml'
%
%%
% @param |path_doc_tool| : path to the doc_tool creating the documentation,
% char.
%
%%
% @param |toolbox_id| : id of the toolbox for which the documentation
% should be created, char. 
%
%%
% @param |toolbox_path| : path to the toolbox for which the documentation
% should be created, char. 
%
%% Example
%
% |make_user_guide(path_doc_tool, toolbox_id, toolbox_path)|
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="getpathtohelpfiles.html">
% doc_tool/getPathToHelpFiles</a>
% </html>
% ,
% <html>
% <a href="matlab:doc io_tool/cell2file">
% io_tool/cell2file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc io_tool/file2cell">
% io_tool/file2cell</a>
% </html>
% ,
% <html>
% <a href="matlab:doc ls">
% matlab/ls</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/mkdirOnDemand')">
% script_collection/mkdirOnDemand</a>
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
% toolbox_creator/make_doc
% </html>
%
%% See Also
% 
% <html>
% <a href="gettoolboxdevelopmentstatus.html">
% getToolboxDevelopmentStatus</a>
% </html>
% ,
% <html>
% <a href="make_helptoc.html">
% make_helptoc</a>
% </html>
% ,
% <html>
% <a href="make_helpfuncbycat.html">
% make_helpfuncbycat</a>
% </html>
% ,
% <html>
% <a href="make_release_notes.html">
% make_release_notes</a>
% </html>
%
%% TODOs
% # improve documentation
% # update: is called by section
% # solve the TODOs in the script
% # 
%
%% <<AuthorTag_DG/>>


    