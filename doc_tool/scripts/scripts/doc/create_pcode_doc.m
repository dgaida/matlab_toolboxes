%% Syntax
%       create_pcode()
%       create_pcode(path)
%
%% Description
% |create_pcode()| replaces all m-files in the <matlab:doc('pwd') pwd> and
% sub directories by p-files. Thus the present working directory should be
% an library export 
% and not the library itself. This function is used to give the toolbox to
% others which should not read or get the code. Files containing '_doc.m'
% are deleted directly and are not converted to p-files. These files are
% used in the toolboxes to create the documentation for the functions in
% the toolbox. 
%
%%
% |create_pcode(path)| lets you set the path instead of using the pwd. 
%
%%
% @param |path| : char defining the path in which the exported toolbox is
% located. 
%
%% Example
% |create_pcode('H:\toolbox\library\biogas')|
%
%%
% |create_pcode('C:\toolbox\library\biogas')|
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/checkargument">
% doc script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/dirr">
% doc script_collection/dirr</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/pcode">
% doc matlab/pcode</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/delete">
% doc matlab/delete</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
%
% <html>
% <a href="publish_toolbox.html">
% publish_toolbox</a>
% </html>
%
%% TODOs
% # 
%
%% <<AuthorTag_DG/>>


