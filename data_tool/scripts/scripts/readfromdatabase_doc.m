%% Preliminaries
% If you want to access an ODBC database, then the database |database_name|
% has to be set up first using the <matlab:doc('querybuilder')
% querybuilder>. 
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
%%
% To use postgreSQL in MATLAB you have to add the path of the
% postgresql-jdcb.jar to the Java classpath. Therefore edit the file
% |classpath.txt| calling |edit classpath.txt| and at the end of the file
% add the path to the following jar file. Looks like this:
%
% |J:/Programme (x86)/PostgreSQL/pgJDBC/postgresql-8.4-701.jdbc4.jar|
%
% Restart MATLAB. 
%
%% Syntax
%       [data]= readfromdatabase(database_name, table_name)
%       [data]= readfromdatabase(database_name, table_name, nRows)
%       [data]= readfromdatabase(database_name, table_name, nRows,
%       postgresql) 
%       [data]= readfromdatabase(database_name, table_name, nRows,
%       postgresql, sorted) 
%       [...]= readfromdatabase(database_name, table_name, nRows,
%       postgresql, sorted, user) 
%       [...]= readfromdatabase(database_name, table_name, nRows,
%       postgresql, sorted, user, password) 
%       [...]= readfromdatabase(database_name, table_name, nRows,
%       postgresql, sorted, user, password, col_ind) 
%       [...]= readfromdatabase(database_name, table_name, nRows,
%       postgresql, sorted, user, password, col_ind, startDate) 
%       [...]= readfromdatabase(database_name, table_name, nRows,
%       postgresql, sorted, user, password, col_ind, startDate, endDate) 
%
%% Description
% |[data]= readfromdatabase(database_name, table_name)| reads data from
% table |table_name| of postgreSQL database |database_name| and returns it
% sorted in descending order with respect to the first column of the table
% as cell array |data|. It is assumed that the postgreSQL database is
% located on the localhost. The default username is 'gecouser' and the
% default password is 'geco' (see parameters |user| and |password|). In
% case an ODBC database should be read (see argument |postgreSQL|) the
% default user and password are both ''. 
%
%%
% @param |database_name| : char with the name of the postgreSQL database
%
%%
% @param |table_name| : char with the name of the table inside the database
% |database_name|
%
%%
% @return |data| : 2dim cell array, the 1st column defines the date and the
% 2nd column defines the data vector. If the table contains more columns,
% then the cell array has the same number of columns as the table.
%
%%
% |[...]= readfromdatabase(database_name, table_name, nRows)| lets you
% specify how many rows are read. The number of rows are selected from the
% beginning of the table. Since the data is sorted in descending order (the
% first column is the key) the newest |nRows| data entries are returned. 
%
%%
% @param |nRows| : double scalar defining the number of rows to be read,
% default: |Inf|, all rows are read. Must be a positive integer value. 
%
%% 
% |[...]= readfromdatabase(database_name, table_name, nRows, postgresql)|
% lets you specify whether a postgreSQL or an ODBC database is specified by
% the first parameter |database_name|. 
%
%%
% @param |postgresql| : if 1, then data is read out of a postgreSQL
% database. If 0, then an ODBC database is read, but only on 32 bit Windows
% systems. 
% 
% * 0 : read ODBC database
% * 1 : read postgreSQL database (default)
%
%% 
% |[...]= readfromdatabase(database_name, table_name, nRows, postgresql,
% sorted)| lets you specify how the data is sorted, before it is returned.
% The data is always sorted, default: descending. 
%
%%
% @param |sorted| : char, specify how the data is sorted:
% * 'DESC' : descending (default)
% * 'ASC' : ascending
%
%%
% |[...]= readfromdatabase(database_name, table_name, nRows, postgresql,
% sorted, user)| lets you specify the user name for the database. 
%
%%
% @param |user| : char defining the user name for the database. The default
% for a postgreSQL database is 'gecouser' and for an ODBC database: ''. 
%
%%
% |[...]= readfromdatabase(database_name, table_name, nRows, postgresql,
% sorted, user, password)| lets you specify the password for the database. 
%
%%
% @param |password| : char defining the password for the database. The
% default for a postgreSQL database is 'geco' and for an ODBC database: ''.
% 
%%
% @param |col_ind| : integer with column index to be read, 1-based. If all
% columns should be read, then set to Inf. Can also be a range of numbers,
% such as: 1:3 to read the first three columns. Default: Inf. 
% 
%%
% @param |startDate| : char. Only data from this date onwards is returned.
% Default: [], all data is returned.
%
%%
% @param |endDate| : char. Only data until this date is returned.
% Default: [], all data is returned.
%
%% Examples
% 
% # Read data from the specified postgreSQL and plot it. The database can
% also be called using <matlab:doc('getfiltereddatafromdb')
% getFilteredDataFromDB> (which is recommended), because then the data is
% also cleaned for outliers. <matlab:doc('getfiltereddatafromdb')
% getFilteredDataFromDB> calls this function. 

[data]= readfromdatabase('sunderhook_database', 'nachgaerer_fermenter0');

subplot(2,1,1)
plot(datenum(data(:,1)) - min(datenum(data(:,1))), cell2mat(data(:,2)))
title('Original data out of the database');
ylim([0 15])

[data, time]= getFilteredDataFromDB('sunderhook_database', 'nachgaerer_fermenter0');

subplot(2,1,2)
plot(time, data)
title('Filtered and resampled data out of the database');


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc database">
% matlab/database</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/existmpfile')">
% script_collection/existMPfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validatestring')">
% matlab/validatestring</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="getfiltereddatafromdb.html">
% getFilteredDataFromDB</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="writetodatabase.html">
% writetodatabase</a>
% </html>
%
%% TODOs
% # create documentation for script file
% # start and end date have to be documented better, also date column is
% assumed to be called date
%
%% <<AuthorTag_DG/>>


