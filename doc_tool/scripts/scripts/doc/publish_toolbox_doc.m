%% Syntax
%       []= publish_toolbox(toolbox)
%
%% Description
% |publish_toolbox(toolbox)| creates the documentation system for the given
% toolbox. Therefore it does the following:
% # first delete all html and png files of old documentation
% # check if mfiles are listed in xml files using <checkifinxmlfile.html
% checkIfInXMLfile> 
% # add Toolbox info, release version, author information in doc scripts
% before publishing
% # publish all script and doc files using <matlab:doc('publish')
% matlab/publish> 
% # delete in _doc.html files '_doc' and change filename of html files to
% lower case
% # check links in mfiles using <checklinksinmfile.html checkLinksInMfile> 
% # create 'function_reference_category.html' and
% 'function_reference_alpha.html' using helpfuncbycat.xml file and
% <matlab:doc('xslt') matlab/xslt> 
% # if applicable, create 'block_reference_category.html' and
% 'block_reference_alpha.html' using helpblockbycat.xml file and
% <matlab:doc('xslt') matlab/xslt> 
% # create helptoc.xml file using <make_helptoc.html make_helptoc>
% # create 'lib_development_status.html' file using
% <gettoolboxdevelopmentstatus.html getToolboxDevelopmentStatus> 
% # check links in xml files 'helpfuncbycat.xml' and 'helpblockbycat.xml'
% using <checklinksinxmlfile.html checkLinksInXMLfile>
% # create '..._product_page.html' for toolbox using
% <create_product_page.html create_product_page> 
% # create searchable index of help files using
% <matlab:doc('builddocsearchdb') builddocsearchdb> 
% # create help.jar file for toolbox
%
%%
% @param |toolbox| : child class of <matlab:doc('gecoc_tool') gecoc_tool>
%
%% Example
%
% |publish_toolbox(toolbox);|
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="..\tool\gettoolboxpath.html">
% getToolboxPath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('setup_tool/gettoolboxfolderstructure')">
% setup_tool/getToolboxFolderStructure</a>
% </html>
% ,
% <html>
% <a href="make_helptoc.html">
% make_helptoc</a>
% </html>
% ,
% <html>
% <a href="gettoolboxdevelopmentstatus.html">
% getToolboxDevelopmentStatus</a>
% </html>
% ,
% <html>
% <a href="getpublicationlocation.html">
% getPublicationLocation</a>
% </html>
% ,
% <html>
% <a href="checklinksinmfile.html">
% checkLinksInMfile</a>
% </html>
% ,
% <html>
% <a href="checklinksinxmlfile.html">
% checkLinksInXMLfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc getallfiles">
% io_tool/getAllFiles</a>
% </html>
% ,
% <html>
% <a href="matlab:doc file2cell">
% file2cell</a>
% </html>
% ,
% <html>
% <a href="matlab:doc cell2file">
% cell2file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc publish">
% doc publish</a>
% </html>
% ,
% <html>
% <a href="getheaderlinesofmfile.html">
% getHeaderLinesOfMFile</a>
% </html>
% ,
% <html>
% <a href="create_product_page.html">
% create_product_page</a>
% </html>
% ,
% <html>
% <a href="matlab:doc xslt">
% doc xslt</a>
% </html>
% ,
% <html>
% <a href="matlab:doc builddocsearchdb">
% doc builddocsearchdb</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkiffunction')">
% script_collection/checkIfFunction</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
%
%% TODOs
% # solve the TODOs inside the file
% # 
%
%% <<AuthorTag_DG/>>


