%% Syntax
%       doc_file= getDocFileOfFunction(filename)
%
%% Description
% |doc_file= getDocFileOfFunction(filename)| gets the doc file '..._doc.m'
% for the given file or function. 
% 
%%
% @param |filename| : char with the filename to be checked. May be with
% full path or not, with or without file extension. If the doc file is
% given already, then it is just returned as it is (but with file
% extension). 
%
%%
% @return |doc_file| : char with the doc file to the given function or file
%
%% Example
%
% with path and file extension

getDocFileOfFunction('H:\doc\make_helptoc.m')

%%
% with path, without file extension

getDocFileOfFunction('H:\doc\make_helptoc')

%%
% without path and without file extension

getDocFileOfFunction('make_helptoc')

%%
% without path and with file extension

getDocFileOfFunction('make_helptoc.m')

getDocFileOfFunction('checkIfInXMLfile.m')

%%
% without path and with file extension, small filename

getDocFileOfFunction('fdir.m')

%%
% without path and without file extension, here we already have the doc
% file, file extension is added

getDocFileOfFunction('make_helptoc_doc')


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
% <a href="publish_toolbox.html">
% publish_toolbox</a>
% </html>
% ,
% <html>
% <a href="replacetoolboxtagbytext.html">
% replaceToolboxTagByText</a>
% </html>
% ,
% <html>
% <a href="gettoolboxdevelopmentstatus.html">
% getToolboxDevelopmentStatus</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="getscriptfileoffunction.html">
% getScriptFileOfFunction</a>
% </html>
%
%% TODOs
% # check documentation
%
%% <<AuthorTag_DG/>>


