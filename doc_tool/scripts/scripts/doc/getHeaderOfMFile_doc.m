%% Syntax
%       header= getHeaderOfMFile(mfile)
%
%% Description
% |header= getHeaderOfMFile(mfile)| gets the first line of the mfile
% usually containing the name of the file. The first 3 items in the line
% are deleted, usually '%% '. 
% 
%%
% @param |mfile| : char with the filename to be checked. May be with
% full path or not. You may also pass the doc file, because this function
% calls the function <getscriptfileoffunction.html getScriptFileOfFunction>
% first.
%
%%
% @return |header| : char with the first line of the file. 
%
%% Example
%
% 

getHeaderOfMFile('make_helptoc.m')

%%

getHeaderOfMFile(...
  'D:\wissMitarbeiter\mTools\doc_tool_1.1\scripts\tool\doc_tool_doc\getHelpPath_doc.m')

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
% <a href="matlab:doc('doc_tool/getscriptfileoffunction')">
% doc_tool/getScriptFileOfFunction</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('doc_tool/get_filenames')">
% doc_tool/get_filenames</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('io_tool/file2cell')">
% io_tool/file2cell</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="make_user_guide.html">
% make_user_guide</a>
% </html>
% 
%% See Also
%
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
% # check documentation
%
%% <<AuthorTag_DG/>>


