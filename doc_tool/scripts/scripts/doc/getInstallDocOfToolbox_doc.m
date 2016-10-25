%% Syntax
%       installDoc= getInstallDocOfToolbox(toolbox)
%
%% Description
% |installDoc= getInstallDocOfToolbox(toolbox)| creates the install
% documentation for the given toolbox. 
% 
%%
% @param |toolbox| : child class of <matlab:doc('gecoc_tool') gecoc_tool>
%
%%
% @return |installDoc| : array of cell strings with the install
% documentation for the given toolbox, as is visualized in html help file
%
%% Example
%
% 

getInstallDocOfToolbox(doc_tool)


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
% <a href="..\tool\gettoolboxid.html">
% doc_tool/getToolboxID</a>
% </html>
% ,
% <html>
% <a href="..\tool\gettoolboxname.html">
% doc_tool/getToolboxName</a>
% </html>
%
% and is called by:
%
% <html>
% template enduser
% </html>
% 
%% See Also
%
% <html>
% <a href="getuninstalldocoftoolbox.html">
% getUninstallDocOfToolbox</a>
% </html>
% ,
% <html>
% <a href="getheaderlinesofmfile.html">
% getHeaderLinesOfMFile</a>
% </html>
% ,
% <html>
% <a href="publish_toolbox.html">
% publish_toolbox</a>
% </html>
%
%% TODOs
% # 
%
%% <<AuthorTag_DG/>>


