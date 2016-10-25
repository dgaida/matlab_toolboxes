%% Syntax
%       version= getReleaseVersionOfMfile(mfile)
%
%% Description
% |version= getReleaseVersionOfMfile(mfile)| returns the release version of
% the given m-file |mfile|. 
%
%%
% @param |mfile| : char with the full path to a m-file. This m-file must
% contain a cell called Release. Directly after it, it must
% be written: ': 1.9' as in the script file. Thus in total: '%% Release:
% 1.9'. Since v1.1 of this toolbox the Release version is given in the
% script file and not in the 'doc' file anymore. For convenience this
% function calls <getscriptfileoffunction.html getScriptFileOfFunction>, 
% such that the doc file as well as the script file can be passed to this
% function. 
%
%%
% @return |version| : version is returned as character, this is a number in
% char format, such as e.g. '1.2'
%
%% Example
%
% you can pass the doc file ...

getReleaseVersionOfMfile( fullfile(doc_tool.getToolboxPath(), ...
                          'scripts/doc/checkLinksInXMLfile_doc.m') )

%%
% ... as well as the script file

getReleaseVersionOfMfile( fullfile(doc_tool.getToolboxPath(), ...
                          'scripts/doc/checkLinksInXMLfile.m') )

                        
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc file2cell">
% doc_tool/file2cell</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="getscriptfileoffunction.html">
% getScriptFileOfFunction</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="gettoolboxdevelopmentstatus.html">
% getToolboxDevelopmentStatus</a>
% </html>
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


