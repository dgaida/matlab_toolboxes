%% Syntax
%       write_cell(fid, cell)
%
%% Description
% |write_cell(fid, cell)| writes <matlab:doc('cellstr') cell array of
% strings> |cell| into opened file |fid|. Does not close |fid| at the end.
%
%%
% @param |fid| : file id of the file in which will be written
%
%%
% @param |cell| : <matlab:doc('cellstr') cell array of strings> defining
% the content to be written. Each cell will be written in a new line.  
%
%% Example
%
% open a file, write two lines in it and close it again

fid= efopen( 'mytestfile.txt', 'w' );

content= [{'line 1'}, {'line 2'}];

write_cell(fid, content);

fclose(fid);

% clean up
if exist('mytestfile.txt', 'file')
  delete('mytestfile.txt');
end

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc fprintf">
% matlab/fprintf</a>
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
% <a href="cell2file.html">
% io_tool/cell2file</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="efopen.html">
% io_tool/efopen</a>
% </html>
% ,
% <html>
% <a href="file2cell.html">
% io_tool/file2cell</a>
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


