%% Syntax
%       wasSuccessful= writeInXLS(database_name, data, table_headline,
%       xls_service) 
%       writeInXLS(database_name, data, table_headline, xls_service,
%       sheet_name) 
%
%% Description
% |wasSuccessful= writeInXLS(database_name, data, table_headline,
% xls_service)| writes the given data |data| inside the xls file with the
% name |database_name|. If the file does not yet exist it is created, else
% the given data is appended after maybe existing data. The first row of
% the excel file will contain the header |table_headline|. 
%
% If the Excel file does not yet exist, it is created and the header and
% data is just written inside the file, the sheet's name will be
% 'Substrate_mixture' as default, see parameter |sheet_name|. 
%
% If the file does exist already, then we try to determine the number of
% rows written in the sheet already. First this is tried using a
% <matlab:doc('actxserver') actxserver> connection to the
% excel.application. If this connection fails, we just read the Excel file
% calling <matlab:doc('xlsread') xlsread> to determine the number of rows.
% Then the new data |data| is appended to the file calling
% <matlab:doc('xlswrite') xlswrite>. 
%
% This function is an alternative to saving data in a database when the
% commercial MATLAB Database Toolbox is not available (same hold for the
% functions <writeindataset.html writeInDataset> and <writeincsv.html
% writeInCSV>). 
%
%%
% @param |database_name| : filename of the xls file, without the xls file
% extension, char. 
%
%%
% @param |data| : double vector with the data to be written in the xls
% file, should be a row vector. 
%
%%
% @param |table_headline| : <matlab:doc('cellstr') cellstring> with the
% headers of the data. Must have the same dimension as |data|. A row vector
% as well. 
%
%%
% @param |xls_service| : char
%
% * 'true'  : TODO
% * 'false' : TODO
%
%%
% @return |wasSuccessful| : double scalar
%
% * 1, if successfully written in xls file, 
% * 0, else.
%
%%
% |writeInXLS(database_name, data, table_headline, xls_service,
% sheet_name)| lets you specify the name of the sheet in which is written. 
%
%%
% @param |sheet_name| : char with the name of the sheet in which is
% written. 
%
%% Example
% 
%

try
  writeInXLS('myXLS', [1,2,3], {'a1', 'a2', 'a3'}, 'true') % 1)
  
  % append more data
  writeInXLS('myXLS', [4,5,6], {'a1', 'a2', 'a3'}, 'true') % 1)
  
  % clean up
  if exist('myXLS.xls', 'file')
    delete('myXLS.xls');
  end
catch ME
  disp(ME.message);
end


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc xlswrite">
% matlab/xlswrite</a>
% </html>
% ,
% <html>
% <a href="matlab:doc xlsread">
% matlab/xlsread</a>
% </html>
% ,
% <html>
% <a href="matlab:doc xlsfinfo">
% matlab/xlsfinfo</a>
% </html>
% ,
% <html>
% <a href="matlab:doc actxserver">
% matlab/actxserver</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validatestring')">
% matlab/validatestring</a>
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
% <a href="writeincsv.html">
% writeInCSV</a>
% </html>
% ,
% <html>
% <a href="writeindataset.html">
% writeInDataset</a>
% </html>
%
%% TODOs
% # improve documentation
% # solve TODOs in file, check argument xls_service
% # clean up code a little
%
%% <<AuthorTag_DG/>>


