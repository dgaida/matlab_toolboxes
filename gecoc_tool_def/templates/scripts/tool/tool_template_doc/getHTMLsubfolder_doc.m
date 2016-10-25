%% Syntax
%       [html_subfolder]= <<toolbox_id/>>.getHTMLsubfolder()
%
%% Description
% |html_subfolder= <<toolbox_id/>>.getHTMLsubfolder()| returns the
% subfolder where the html help files of the
% _<<toolbox_name/>>_ Toolbox are located, usually 'html'.   
%
%%
% @return |html_subfolder| : <matlab:doc('char') char> containing the
% subfolder where the html help files are located.
%
%% Example
% 
% 

html_subfolder= <<toolbox_id/>>.getHTMLsubfolder();

disp(html_subfolder);


%% Dependencies
% 
% This function calls:
%
% -
%
% and is called by:
%
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
% <a href="matlab:doc('<<toolbox_id/>>/gethelppath')">
% <<toolbox_id/>>/getHelpPath</a>
% </html>
%
%% TODOs
% # This function always returns html, for the biogas toolbox, this is
% wrong
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


