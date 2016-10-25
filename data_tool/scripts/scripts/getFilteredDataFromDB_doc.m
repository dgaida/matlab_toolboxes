%% Syntax
%       data= getFilteredDataFromDB()
%       data= getFilteredDataFromDB(database_name)
%       data= getFilteredDataFromDB(database_name, table_name)
%       [...]= getFilteredDataFromDB(database_name, table_name, nRows)
%       [...]= getFilteredDataFromDB(database_name, table_name, nRows,
%       numPerDay) 
%       [...]= getFilteredDataFromDB(database_name, table_name, nRows,
%       numPerDay, window_size) 
%       [...]= getFilteredDataFromDB(database_name, table_name, nRows,
%       numPerDay, window_size, postgresql) 
%       [...]= getFilteredDataFromDB(database_name, table_name, nRows,
%       numPerDay, window_size, postgresql, user) 
%       [...]= getFilteredDataFromDB(database_name, table_name, nRows,
%       numPerDay, window_size, postgresql, user, password) 
%       [...]= getFilteredDataFromDB(database_name, table_name, nRows,
%       numPerDay, window_size, postgresql, user, password, col_ind) 
%       [data, time]= getFilteredDataFromDB(database_name, table_name, ...)
%
%% Preliminaries
% |nanmoving_average.m| is inside the Toolbox, but can also be downloaded
% from
% <http://www.mathworks.com/matlabcentral/fileexchange/12276-movingaverage-v3-1-mar-2008
% nanmoving_average.m> 
%
% For further preliminaries, see the documentation of
% <readfromdatabase.html readfromdatabase>. 
%
%% Description
% |data= getFilteredDataFromDB()| returns data read out of the 
% table |nachgaerer_fermenter0| from the postgreSQL database
% |sunderhook_database| using <readfromdatabase.html readfromdatabase>.
% Therefore, this postgreSQL database with the specified table clearly must
% exist, otherwise an error is thrown. The data is filtered for global
% outliers using <filterdata.html filterData>. Furthermore the data is
% resampled using the <matlab:doc('timeseries') timeseries> class using a
% sample time of 1 h (<resampledatats.html resampleDataTS>), see the
% fucntion argument |numPerDay|. At the end the data is smoothed using the
% moving average filter function <nanmoving_average.html
% nanmoving_average> with a window of 6 h, see the argument |window_size|.
%
% It is assumed that the first column of the table defines a timestamp,
% that the <matlab:doc('timeseries') timeseries> toolbox understands. 
%
% It is assumed that the postgreSQL database is located on the localhost.
%
% The default username is 'gecouser' and the 
% default password is 'geco' (see parameters |user| and |password|). In
% case an ODBC database should be read (see argument |postgreSQL|) the
% default user and password are both ''. 
%
%%
% @return |data| : double vector, which contains the data
%
%%
% |data= getFilteredDataFromDB(database_name)| lets you specify the
% postgreSQL database. This call and the call above both throw one
% respectively two warnings because above no database is given (1st
% warning) and here no table name is given (2nd warning). 
%
%%
% @param |database_name| : char with the name of the postgreSQL database 
%
%%
% |data= getFilteredDataFromDB(database_name, table_name)| lets you specify
% the name of the table. 
%
%%
% @param |table_name| : char with the name of the table which should be
% inside the postgreSQL database |database_name|. 
%
%%
% |[...]= getFilteredDataFromDB(database_name, table_name, nRows)| lets you
% specify how many rows are read out of the table, beginning from the top.
% Remark: Before the data is read the data is sorted in descending order
% using the first column of the table, such that the newest data is read
% out of the table (see: <readfromdatabase.html readfromdatabase>).  
%
%%
% @param |nRows| : number of rows to be read, default <matlab:doc('Inf')
% |Inf|>, all rows are read. 
%
%%
% |[...]= getFilteredDataFromDB(database_name, table_name, nRows,
% numPerDay)| lets you specify the sampling time.  
%
%%
% @param |numPerDay| : double scalar, defines the number of samples per day
% used to resample the data. Default is 24, what means a sampling time of 1
% h, because a day has 24 hours. Must be an integer. 
%
%%
% |[...]= getFilteredDataFromDB(database_name, table_name, nRows,
% numPerDay, window_size)| lets you specify the size of the moving average
% window. 
%
%%
% @param |window_size| : window size of the moving average filter, measured
% in 24 h / ( |numPerDay| * [d/h] ), double scalar. Default is 6. Here this
% means a window size of 6 hours, because 24 h / 24 = 1 h. Thus 1 h is the
% unit in which |window_size| is measured. |window_size| must be integer
% valued. 
%
%%
% |[...]= getFilteredDataFromDB(database_name, table_name, nRows,
% numPerDay, window_size, postgresql)| lets you specify if the database is
% a postgreSQL (1, default) or an ODBC database (0), the latter works only
% on 32 bit Windows systems. 
%
%%
% @param |postgresql| : double scalar
%
% * 0: read ODBC database
% * 1: read postgreSQL database
%
%%
% |[...]= getFilteredDataFromDB(database_name, table_name, nRows,
% numPerDay, window_size, postgresql, user)| lets you specify the user name
% for the database. 
%
%%
% @param |user| : char defining the user name for the database. The default
% for a postgreSQL database is 'gecouser' and for an ODBC database: ''. 
%
%%
% |[...]= getFilteredDataFromDB(database_name, table_name, nRows,
% numPerDay, window_size, postgresql, user, password)| lets you specify the
% password for the database. 
%
%%
% @param |password| : char defining the password for the database. The
% default for a postgreSQL database is 'geco' and for an ODBC database: ''.
% 
%%
% @param |col_ind| : integer with column index to be read, 1-based.
% Can also be a range of numbers such as 1:3, to read the first 3 columns.
% Or [1 4] to read column 1 and 4. 
% Default: 1:2, the first two columns are read, assuming that the first
% column contains a date or another key. 
% 
%%
% |[data, time]= getFilteredDataFromDB(database_name, table_name, ...)|
% returns the time vector as well. 
%
%%
% @return |time| : cell containing the time vector belonging to the |data|
% vector
%
%% Examples
% 
% Read all data out of a postgreSQL database, which contains outliers.
% First read and plot the raw data using <readfromdatabase.html
% readfromdatabase>, then get the same data calling this function. Notice
% that the data returned by this function does not contain outliers anymore
% and is smoothed. 
%

[data]= readfromdatabase('sunderhook_database', 'nachgaerer_fermenter0', Inf);

subplot(2,1,1)
plot(datenum(data(:,1)) - min(datenum(data(:,1))), cell2mat(data(:,2)));
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
% <a href="readfromdatabase.html">
% data_tool/readfromdatabase</a>
% </html>
% ,
% <html>
% <a href="filterdata.html">
% data_tool/filterData</a>
% </html>
% ,
% <html>
% <a href="resampledatats.html">
% data_tool/resampleDataTS</a>
% </html>
% ,
% <html>
% <a href="nanmoving_average.html">
% data_tool/nanmoving_average</a>
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
% ,
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
%
% <html>
% <a href="matlab:doc median">
% matlab/median</a>
% </html>
% ,
% <html>
% <a href="resampledata.html">
% data_tool/resampleData</a>
% </html>
% ,
% <html>
% <a href="online_outlier_detection.html">
% data_tool/online_outlier_detection</a>
% </html>
%
%% TODOs
%
% # Funktion so erweitern, dass auch mehrere Tabellen-Namen als cell-array
% übergeben werden können und data dann als matrix zurück gegeben wird
%
% 
%% <<AuthorTag_DG/>>


