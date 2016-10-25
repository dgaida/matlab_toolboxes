%% Syntax
%       fid= efopen(fname)
%       fid= efopen(fname, flag)
%
%% Description
% |fid= efopen(fname)| opens the file with the given filename |fname|. On
% failure throws an error.
%
%%
% @param |fname| : char defining the filename of the to be opened file.
%
%%
% @param |flag| : char, defining a flag, which may be passed to
% <matlab:doc('fopen') fopen>, such as 'w', 'r', 'a', etc. If you do not
% pass a flag, then the file is just opened for reading, see documentation
% of <matlab:doc('fopen') fopen>. 
%
%%
% @return |fid| : file id of the opened file, double scalar
%
%% Example
%
% open and close a file

fid= efopen( fullfile( io_tool.getToolboxPath(), ...
                       'scripts/file2cell.m' ) );

fclose(fid);

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc fopen">
% matlab/fopen</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="cell2file.html">
% io_tool/cell2file</a>
% </html>
% ,
% <html>
% <a href="file2cell.html">
% io_tool/file2cell</a>
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
% <a href="matlab:doc fclose">
% matlab/fclose</a>
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


