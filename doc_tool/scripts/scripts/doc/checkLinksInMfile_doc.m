%% Syntax
%       linksOK= checkLinksInMfile(toolbox, path_to_file)
%
%% Description
% |linksOK= checkLinksInMfile(toolbox, path_to_file)| checks links in given m-file
% with full name |path_to_file|, if they are ok or a dead end. If they are
% a dead end, then the function throws a warning and returns 0, else it
% returns 1. Links that are a dead end are tried to fixed. If the correct
% path is found, then the link is corrected.
%
% The following two link types are checked:
%
% * <a href="..\doc\create_pcode.html">
% * <make_helptoc.html make_helptoc>
%
%%
% @param |toolbox| : child class of <matlab:doc('gecoc_tool') gecoc_tool>
%
%%
% @param |path_to_file| : char with the full path to the m-file of interest
%
%%
% @return |linksOK| : double
%
% * 0 : at least one link does not exist
% * 1 : all links are OK
%
%% Example
%
% 

checkLinksInMfile( doc_tool, fullfile(doc_tool.getToolboxPath(), ...
                   'scripts/doc/checkIfInXMLfile_doc.m') )


%%

checkLinksInMfile( doc_tool, fullfile(doc_tool.getToolboxPath(), ...
                   'scripts/doc/getRelPathToHTMLFile_doc.m') )

                 
%%

checkLinksInMfile( doc_tool, fullfile(doc_tool.getToolboxPath(), ...
                   'scripts/doc/getToolboxDevelopmentStatus_doc.m') )

                 

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="..\tool\gethelppath.html">
% getHelpPath</a>
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
% <a href="matlab:doc regexp">
% doc regexp</a>
% </html>
% ,
% <html>
% <a href="matlab:doc exist">
% doc exist</a>
% </html>
% ,
% <html>
% <a href="getrelpathtohtmlfile.html">
% getRelPathToHTMLFile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/replaceinfile')">
% script_collection/replaceinfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% doc script_collection/checkArgument</a>
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
% <a href="checklinksinxmlfile.html">
% checkLinksInXMLfile</a>
% </html>
% ,
% <html>
% <a href="checkifinxmlfile.html">
% checkIfInXMLfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc gecoc_tool">
% doc gecoc_tool</a>
% </html>
% ,
% <html>
% <a href="matlab:doc doc_tool">
% doc doc_tool</a>
% </html>
%
%% TODOs
%
%
%% <<AuthorTag_DG/>>


