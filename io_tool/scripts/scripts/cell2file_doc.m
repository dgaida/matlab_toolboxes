%% Syntax
%       cell2file(file, str)
%       cell2file(file, str, flag)
%
%% Description
% |cell2file(file, str)| writes cell array of strings |str| into a file
% with the given filename |file|. First the file is opened using
% <efopen.html efopen>, then <write_cell.html write_cell> writes |str|
% inside the file. At the end the file is closed calling
% <matlab:doc('fclose') fclose>. Previous content inside 
% the file is deleted (see parameter |flag|). 
%
%%
% @param |file| : char defining the file name in which is written
%
%%
% @param |str| : <matlab:doc('cellstr') cell array of strings> defining the
% content to be written. Each cell is written in one line. 
%
%%
% @param |flag| : char, defining the flag passed to <efopen.html efopen>,
% default: 'w' for write. Examples are: 'a' for append, ...
%
%% Example
%
% first read a couple of lines out of a file, then add a few cells, then
% write it in a new file.

content= file2cell( fullfile( io_tool.getToolboxPath(), ...
                    'scripts/file2cell.m' ), 10 );

content= [content, {'some further lines'}, {'...'}];

cell2file('mytestfile.txt', content);

% do not clean up, because file is needed in write_cell


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="write_cell.html">
% io_tool/write_cell</a>
% </html>
% ,
% <html>
% <a href="efopen.html">
% io_tool/efopen</a>
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
%
% and is called by:
%
% <html>
% <a href="matlab:doc doc_tool/make_helptoc">
% doc_tool/make_helptoc</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="file2cell.html">
% io_tool/file2cell</a>
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


