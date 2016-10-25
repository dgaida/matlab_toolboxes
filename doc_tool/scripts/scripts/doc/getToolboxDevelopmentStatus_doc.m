%% Syntax
%       []= getToolboxDevelopmentStatus(toolbox)
%       getToolboxDevelopmentStatus(toolbox, current_version)
%
%% Description
% |getToolboxDevelopmentStatus(toolbox)| creates a HTML file documenting the
% development status of the current release version of the toolbox
% (Default: 1.1). All files inside the toolbox are listed on this html
% file. Colors represent if the files are finished for this release version
% or if changes are needed (traffic lights). 
%
%%
% @param |toolbox| : child class of <matlab:doc('gecoc_tool') gecoc_tool>
%
%%
% |getToolboxDevelopmentStatus(toolbox, current_version)| lets you specify
% th release version for which the html file should be created.
%
%%
% @param |current_version| : double value specifying the current release
% version of the toolbox. 
%
%% Example
% 
%

getToolboxDevelopmentStatus(doc_tool, 1.1);

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('doc_tool/gettoolboxpath')">
% doc_tool/getToolboxPath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('doc_tool/gethelppath')">
% doc_tool/getHelpPath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('doc_tool/gethtmlsubfolder')">
% doc_tool/getHTMLsubfolder</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('doc_tool/gettoolboxname')">
% doc_tool/getToolboxName</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('setup_tool/gettoolboxfolderstructure')">
% setup_tool/getToolboxFolderStructure</a>
% </html>
% ,
% <html>
% <a href="getpublicationlocation.html">
% getPublicationLocation</a>
% </html>
% ,
% <html>
% <a href="matlab:doc file2cell">
% io_tool/file2cell</a>
% </html>
% ,
% <html>
% <a href="getreleaseversionofmfile.html">
% getReleaseVersionOfMfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% doc validateattributes</a>
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
%
%% TODOs
% # Hier gibt es die Annahme, dass Hilfedateien in html Ordner liegen. OK
%
%% <<AuthorTag_DG/>>


