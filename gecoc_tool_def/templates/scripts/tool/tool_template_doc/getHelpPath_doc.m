%% Syntax
%       [help_path]= <<toolbox_id/>>.getHelpPath()
%
%% Description
% |help_path= <<toolbox_id/>>.getHelpPath()| returns the path to the folder in which the
% help of the _<<toolbox_name/>>_ Toolbox is located. 
%
%%
% @return |help_path| : <matlab:doc('char') char> containing the
% path to the help folder. This folder is and must be identical to as it is
% defined in the |info.xml| file.
%
%% Example
% 
% 

help_path= <<toolbox_id/>>.getHelpPath();

disp(help_path);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('doc_tool/gettoolboxpath')">
% doc_tool/getToolboxPath</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc doc_tool/checkifinxmlfile">
% doc_tool/checkIfInXMLfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc doc_tool/checklinksinmfile">
% doc_tool/checkLinksInMfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc doc_tool/checklinksinxmlfile">
% doc_tool/checkLinksInXMLfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc doc_tool/create_product_page">
% doc_tool/create_product_page</a>
% </html>
% ,
% <html>
% <a href="matlab:doc doc_tool/getrelpathtohtmlfile">
% doc_tool/getRelPathToHTMLFile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc doc_tool/gettoolboxdevelopmentstatus">
% doc_tool/getToolboxDevelopmentStatus</a>
% </html>
% ,
% <html>
% ...
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('<<toolbox_id/>>/<<toolbox_id/>>')">
% <<toolbox_id/>>/<<toolbox_id/>></a>
% </html>
% ,
% <html>
% <a href="matlab:doc('<<toolbox_id/>>/gettoolboxpath')">
% <<toolbox_id/>>/getToolboxPath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('<<toolbox_id/>>/gettoolboxid')">
% <<toolbox_id/>>/getToolboxID</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('<<toolbox_id/>>/gettoolboxname')">
% <<toolbox_id/>>/getToolboxName</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('<<toolbox_id/>>/gethtmlsubfolder')">
% <<toolbox_id/>>/getHTMLsubfolder</a>
% </html>
%
%% TODOs
% # 
%
%% Author
% Daniel Gaida, M.Sc.EE.IT
%
% Cologne University of Applied Sciences (Campus Gummersbach)
%
% Department of Automation & Industrial IT
%
% GECO-C Group
%
% daniel.gaida@fh-koeln.de
%
% Copyright 2009-2014
%
% Last Update: <<now/>>
%


