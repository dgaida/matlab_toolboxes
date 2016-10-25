%% Preliminaries
% The database |database_name| has to be set up first using the
% <matlab:doc('querybuilder') querybuilder>, in case you want to write into
% a ODBC database. For informations on setting up the connection to a
% postgreSQL database, see the documentation of <readfromdatabase.html
% readfromdatabase>. 
%
% HowTo (for further help see the MATLAB help searching for
% <matlab:doc('querybuilder') querybuilder>): 
%
% Open the Windows Data Source Administrator dialog box to define the ODBC
% data source: 
% 
% # Start Visual Query Builder by entering the command |querybuilder| at
% the MATLAB command prompt. 
% # In Visual Query Builder, select Query > Define ODBC data source.
% # The ODBC Data Source Administrator dialog box appears, listing existing
% data sources. 
% # Click the User DSN tab.
% # Click Add. A list of installed ODBC drivers appears in the ODBC Data
% Source Administrator dialog box. Select MS Access Database...
%
%% Syntax
%       writeInDatabase(database_name, data, table_headline)
%       writeInDatabase(database_name, data, table_headline, postgresql) 
%       writeInDatabase(database_name, data, table_headline, postgresql,
%       writeDatum) 
%
%% Description
% |writeInDatabase(database_name, data, table_headline)| writes the given
% double vector |data| in the postgreSQL database |database_name|. 
%
% If the table 'Substrate_mixture' does not exist or if we cannot write the
% |data| in the table (because of different number of rows) the table is
% created first. 
%
%%
% @param |database_name| : char with the name of the database
%
%%
% @param |data| : double data vector
%
%%
% @param |table_headline| : cellstring with header of table
%
%%
% @param |postgresql| : 0 or 1
%
% * 1 : write in a postgreSQL database
% * 0 : write in a MS SQL database
%
%%
% @param |writeDatum| : 0 or 1
%
% * 1 : write date in first column of table
% * 0 : do not write data in first column of table
%
%% Examples
% 
% 

data= [1,2,3];
table_headline= {'one', 'two', 'three'};

Datum= m2xdate(now);
data= [Datum, data];

table_headline= [{'Datum'}, table_headline];

writeInDatabase('equilibria_sunderhook_costs', data, table_headline);

%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc database">
% matlab/database</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/is0or1">
% script_collection/is0or1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc dmd">
% matlab/dmd</a>
% </html>
% ,
% <html>
% <a href="matlab:doc insert">
% matlab/insert</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('writetodatabase')">
% writetodatabase</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc('writeincsv')">
% writeInCSV</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('writeindataset')">
% writeInDataset</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('writeinxls')">
% writeInXLS</a>
% </html>
%
%% TODOs
%
% # improve code
% # improve documentation
% # make database table selectable
%
%% <<AuthorTag_DG/>>


