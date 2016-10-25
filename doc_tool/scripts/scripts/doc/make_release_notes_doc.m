%% Syntax
%       make_release_notes(path_doc_tool, toolbox_path)
%
%% Description
% |make_release_notes(path_doc_tool, toolbox_path)| creates the release
% notes folders and files for the toolbox in the given path |toolbox_path|.
% Therefore it does the following:
% - Create the file 'release_notes.m' out of 'release_notes_template.m' by
% adding a table listing all releases
% - Create the files 'rn_bugreport_vX_Y.m' and 'rn_details_vX_Y.m' for each
% release version out of the templates 'rn_bugreport_v0_1.m' and
% 'rn_details_v0_1.m'. 
% - Copy files 'publish_location.txt', 'NOTinXML.txt' and 'InPath.txt' in
% each subfolder of release versions 
% - Create file 'rn_compatibility.m' out of template 'rn_compatibility.m'
% - Create 'release_notes.xml'
%
%%
% @param |path_doc_tool| : path to the doc_tool creating the documentation,
% char.
%
%%
% @param |toolbox_path| : path to the toolbox for which the documentation
% should be created, char. 
%
%% Example
%
% |make_release_notes(path_doc_tool, toolbox_path)|
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="getpathtoreleasenotes.html">
% doc_tool/getPathToReleaseNotes</a>
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
% <a href="matlab:doc io_tool/getallsubfolders">
% io_tool/getAllSubfolders</a>
% </html>
% ,
% <html>
% <a href="matlab:doc flipud">
% matlab/flipud</a>
% </html>
% ,
% <html>
% <a href="replace_entry.html">
% doc_tool/replace_entry</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/replaceinfile')">
% script_collection/replaceinfile</a>
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
% <a href="make_user_guide.html">
% make_user_guide</a>
% </html>
%
%% TODOs
% # improve documentation
% # update: is called by section
% # solve the TODOs in the script
% # 
%
%% <<AuthorTag_DG/>>


    