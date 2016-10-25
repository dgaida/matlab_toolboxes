%% Syntax
%       script_file= getScriptFileOfFunction(filename)
%
%% Description
% |script_file= getScriptFileOfFunction(filename)| gets the script file 
% for the given file, doc file or function. 
% 
%%
% @param |filename| : char with the filename to be checked. May be with
% full path or not, with or without file extension. If the script file is
% given already, then it is just returned as it is (but with file
% extension). 
%
%%
% @return |script_file| : char with the script file to the given function
% or file 
%
%% Example
%
% with path and file extension

getScriptFileOfFunction('H:\doc\make_helptoc_doc.m')

%%
% with path, without file extension

getScriptFileOfFunction('H:\doc\make_helptoc_doc')

%%
% without path and without file extension

getScriptFileOfFunction('make_helptoc_doc')

%%
% without path and with file extension

getScriptFileOfFunction('make_helptoc_doc.m')

getScriptFileOfFunction('checkIfInXMLfile_doc.m')

%%
% without path and with file extension, small filename

getScriptFileOfFunction('fdir_doc.m')

%%
% without path and without file extension, here we already have the script 
% file, file extension is added

getScriptFileOfFunction('make_helptoc')


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
% <a href="matlab:doc('strfind')">
% matlab/strfind</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('doc_tool/getheaderlinesofmfile')">
% doc_tool/getHeaderLinesOfMFile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('doc_tool/getheaderofmfile')">
% doc_tool/getHeaderOfMFile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('doc_tool/getreleaseversionofmfile')">
% doc_tool/getReleaseVersionOfMfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('doc_tool/replacetoolboxtagbytext')">
% doc_tool/replaceToolboxTagByText</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="getdocfileoffunction.html">
% getDocFileOfFunction</a>
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


