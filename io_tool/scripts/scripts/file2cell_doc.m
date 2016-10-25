%% Syntax
%       str= file2cell(filename)
%       str= file2cell(filename, maxline)
%
%% Description
% |str= file2cell(filename)| reads content of file |filename| into
% |str| as a <matlab:doc('cellstr') cell array of strings>. Each line
% results in one cell of the array. 
%
%%
% @param |filename| : char defining the file name from which is read
%
%%
% @return |str| : <matlab:doc('cellstr') cell array of strings> of file
% content 
%
%%
% |str= file2cell(filename, maxline)| lets you specify how much lines
% maximal should be read. 
%
%%
% @param |maxline| : double integer defining maximal number of lines to read,
% default: inf 
%
%% Example
%
% # read first 10 lines out of file

file2cell( fullfile( io_tool.getToolboxPath(), 'scripts/file2cell.m' ), 10 )


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="efopen.html">
% io_tool/efopen</a>
% </html>
% ,
% <html>
% <a href="matlab:doc fgetl">
% matlab/fgetl</a>
% </html>
% ,
% <html>
% <a href="matlab:doc fclose">
% matlab/fclose</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc validateattributes">
% matlab/validateattributes</a>
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
% <a href="matlab:doc doc_tool/getreleaseversionofmfile">
% doc_tool/getReleaseVersionOfMfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc doc_tool/gettoolboxdevelopmentstatus">
% doc_tool/getToolboxDevelopmentStatus</a>
% </html>
% ,
% <html>
% <a href="matlab:doc doc_tool/publish_toolbox">
% doc_tool/publish_toolbox</a>
% </html>
% ,
% <html>
% <a href="matlab:doc doc_tool/make_helptoc">
% doc_tool/make_helptoc</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="write_cell.html">
% io_tool/write_cell</a>
% </html>
% ,
% <html>
% <a href="cell2file.html">
% io_tool/cell2file</a>
% </html>
%
%% TODOs
% # create documentation for script file
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <a href="http://code.google.com/p/mtex/">
% http://code.google.com/p/mtex/</a>
% </html>
%


