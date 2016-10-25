%% Syntax
%       wasSuccessful= writeInCSV(database_name, data, table_headline)
%       wasSuccessful= writeInCSV(database_name, data, table_headline, ...
%                                 sheet_name)
%
%% Description
% |wasSuccessful= writeInCSV(database_name, data, table_headline)| writes
% the given data |data| inside the csv (comma separated value) file with
% the name |database_name|. 
% If the file does not yet exist it is created, else the given data is
% appended after maybe existing data. Furthermore the given header 
% |table_headline| is written in an additional excel file with the same
% filename. 
%
% This function is an alternative to saving data in a database when the
% commercial MATLAB Database Toolbox is not available (same hold for the
% functions <writeinxls.html writeInXLS> and <writeindataset.html
% writeInDataset>). 
%
%%
% @param |database_name| : filename of the csv file, without the csv file
% extension, char. 
%
%%
% @param |data| : double vector with the data to be written in the csv file
%
%%
% @param |table_headline| : <matlab:doc('cellstr') cellstring> with the
% headers of the data. Must have the same dimension as |data|. The header
% is written in an additional excel file with the same filename. 
%
%%
% @return |wasSuccessful| : 1, if successfully written in csv file, else 0.
%
%%
% |wasSuccessful= writeInCSV(database_name, data, table_headline,
% sheet_name)| 
%
%%
% @param |sheet_name| : name of the sheet inside the excel file in which
% the header is written. 
%
%% Example
% 
%

try
  % write data in file
  writeInCSV('myCSV', [1,2,3], {'a1', 'a2', 'a3'})
  % append more data in same file
  writeInCSV('myCSV', [12,22,32], {'a1', 'a2', 'a3'})
  
  % clean up
  if exist('myCSV.csv', 'file')
    delete('myCSV.csv');
  end
  if exist('myCSV.xls', 'file')
    delete('myCSV.xls');
  end
catch ME
  disp(ME.message);
end
  

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc csvwrite">
% matlab/csvwrite</a>
% </html>
% ,
% <html>
% <a href="matlab:doc xlswrite">
% matlab/xlswrite</a>
% </html>
% ,
% <html>
% <a href="matlab:doc csvread">
% matlab/csvread</a>
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
% <a href="writetodatabase.html">
% writetodatabase</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="writeinxls.html">
% writeInXLS</a>
% </html>
% ,
% <html>
% <a href="writeindataset.html">
% writeInDataset</a>
% </html>
%
%% TODOs
% # create documentation for script file
%
%% <<AuthorTag_DG/>>


