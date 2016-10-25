%% Syntax
%       linksOK= checkLinksInXMLfile(toolbox, filename)
%
%% Description
% |linksOK= checkLinksInXMLfile(toolbox, filename)| checks links in given xml-file 
% |filename|, if they are ok or a dead end. If they are
% a dead end, then the function throws a warning and returns 0, else it
% returns 1.
%
% The following link type is checked:
%
% * target="toolbox/blocks/ad_models/html/calcADM1Deriv.html"
%
%%
% @param |toolbox| : child class of <matlab:doc('gecoc_tool') gecoc_tool>
%
%%
% @param |filename| : char with the filename to the xml-file of interest.
% Either: 'helpfuncbycat.xml' or 'helpblockbycat.xml'.
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

checkLinksInXMLfile(doc_tool, 'helpfuncbycat.xml')


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
% # 
%
%% <<AuthorTag_DG/>>


