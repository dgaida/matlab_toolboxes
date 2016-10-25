%% Syntax
%       headerlines= getHeaderLinesOfMFile(mfile)
%
%% Description
% |headerlines= getHeaderLinesOfMFile(mfile)| gets the first approximately
% three lines of a script file describing the function. The first lines are
% recognized by a '%' at the first position of each line. At most the first
% 5 lines are returned. If the doc file is given for a class method, then
% it is a bit tricky to get the according script file, because both files
% usually are not in the same folder. What is happening is, that the folder
% in which the doc file is in is assumed to be named after the class the
% method belongs to. Furthermore as another suggestion the folder in which
% this folder is in is named as the package the class is in. Using this
% strategy quite a lot of class methods are found but not all, but this is
% the best we can do at the moment. 
% 
%%
% @param |mfile| : char with the filename to be checked. May be with
% full path or not. You may also pass the doc file, because this function
% calls the function <getscriptfileoffunction.html getScriptFileOfFunction>
% first.
%
%%
% @return |headerlines| : char with the first lines of the file describing
% the function. 
%
%% Example
%
% 

getHeaderLinesOfMFile('make_helptoc.m')

%%

getHeaderLinesOfMFile('D:\wissMitarbeiter\mTools\doc_tool_1.1\install_doc_tool.m')

%%

getHeaderLinesOfMFile('D:\wissMitarbeiter\mTools\doc_tool_1.1\scripts\tool\@doc_tool\getHelpPath.m')

%%

getHeaderLinesOfMFile(...
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
% ,
% <html>
% <a href="matlab:doc('strrep')">
% matlab/strrep</a>
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
% <a href="getheaderofmfile.html">
% getHeaderOfMFile</a>
% </html>
% ,
% <html>
% <a href="getdocfileoffunction.html">
% getDocFileOfFunction</a>
% </html>
%
%% TODOs
% # solve TODO inside script
% # check documentation
%
%% <<AuthorTag_DG/>>


