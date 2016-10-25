%% Syntax
%       linkOK= checkIfInXMLfile(toolbox, xml_file, html_link)
%
%% Description
% |linkOK= checkIfInXMLfile(toolbox, xml_file, html_link)| checks whether given
% file |html_link| is recorded in given xml-file |xml_file|. If not, 
% the function throws a warning and returns 0, else it returns 1.
%
%%
% @param |toolbox| : child class of <matlab:doc('gecoc_tool') gecoc_tool>
%
%%
% @param |xml_file| : char with the filename to the xml-file of interest.
% Either: 'helpfuncbycat.xml' or 'helpblockbycat.xml'.
%
%%
% @param |html_link| : char with the relative link to the html
% file to be proven. 
% Example: 'toolbox/blocks/ad_models/html/calcADM1Deriv.html'.
%
%%
% @return |linkOK| : double
%
% * 0 : link to given html file does not exist
% * 1 : link to given html file exists
%
%% Example
%
% 

checkIfInXMLfile(doc_tool, 'helpfuncbycat.xml', 'doc/checklinksinxmlfile.html')


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


