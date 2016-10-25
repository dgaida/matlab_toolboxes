%% Syntax
%       toolbox_path= <<toolbox_id/>>.getToolboxPath()
%
%% Description
% |toolbox_path= <<toolbox_id/>>.getToolboxPath()| returns the entry path of the
% _<<toolbox_name/>>_ Toolbox. 
%
%%
% @return |toolbox_path| : <matlab:doc('char') char> containing the
% path to the _<<toolbox_name/>>_ Toolbox. 
%
%% Example
% 
% 

toolbox_path= <<toolbox_id/>>.getToolboxPath();

disp(toolbox_path);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('which')">
% doc/which</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('fileparts')">
% doc/fileparts</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="gethelppath.html">
% <<toolbox_id/>>/getHelpPath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc doc_tool/make_helptoc">
% doc_tool/make_helptoc</a>
% </html>
% ,
% <html>
% <a href="matlab:doc doc_tool/publish_toolbox">
% doc_tool/publish_toolbox</a>
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
% Copyright 2012-2012
%
% Last Update: <<now/>>
%


