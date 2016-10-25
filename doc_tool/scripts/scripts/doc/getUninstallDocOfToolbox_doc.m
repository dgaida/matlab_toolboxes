%% Syntax
%       uninstallDoc= getUninstallDocOfToolbox(toolbox)
%
%% Description
% |uninstallDoc= getUninstallDocOfToolbox(toolbox)| creates the uninstall
% documentation for the given toolbox. 
% 
%%
% @param |toolbox| : child class of <matlab:doc('gecoc_tool') gecoc_tool>
%
%%
% @return |uninstallDoc| : array of cell strings with the uninstall
% documentation for the given toolbox, as is visualized in html help file
%
%% Example
%
% 

getUninstallDocOfToolbox(doc_tool)


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
% <a href="getinstalldocoftoolbox.html">
% getInstallDocOfToolbox</a>
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


