%% Syntax
%       data_filter= online_outlier_detection(N, data)
%       data_filter= online_outlier_detection(N, data, replaceStrategy)
%       data_filter= online_outlier_detection(N, data, replaceStrategy, mode)
%       data_filter= online_outlier_detection(N, database_name, table_name) 
%       [...]= online_outlier_detection(N, database_name, table_name,
%       replaceStrategy) 
%       [...]= online_outlier_detection(N, database_name, table_name,
%       replaceStrategy, mode) 
%
%% Remark
% This function is quite similar to <filterdata.html filterData>, when
% applied in 'offline' mode, see parameter |mode|. The only difference is
% that to check for outliers here only the neighbourhood of the datapoint
% is used to estimate whether this datapoint is an outlier or not. In
% <filterdata.html filterData> the complete dataset is used to estimate
% this. Furthermore the latter function is not causal, but this is!
%
%% Description
% |data_filter= online_outlier_detection(N, data)| checks the last instance of
% double vector or <matlab:doc('timeseries') timeseries> object |data| if
% it is an outlier or not, compared to the last |N| values of |data|. To do
% this the <matlab:doc('median') median> and <mad.html MAD> of the last |N|
% values of |data| is calculated. If the difference of the last instance of
% |data| to the median value is greater then three times the MAD value,
% then the last instance of |data| is replaced by the calculated median
% value. 
%
%%
% @param |N| : length of moving window, double scalar. In general it is
% just the value of the last |N| instances inside |data|. If |data| is
% distributed equidistantly then |N| also has a meaning of time. 
%
%%
% @param |data| : double data (row or column) vector or <matlab:doc('timeseries')
% timeseries> object, which will be filtered. The data 
% should better be distributed equidistantly, such that the moving average
% respectively median is always taken over the same time horizon. But it is
% better not to resample it manually because then outliers could be
% resampled and then are more difficult to detect on a local basis. In the
% function itself the data is not resampled! 
%
%%
% @return |data_filter| : double. If the function is used as online filter
% (see parameter |mode|), then a scalar (just the last value), else a
% vector with same dimension as input parameter |data|. If it is a vector,
% then always a column vector. 
%
%%
% |data_filter= online_outlier_detection(N, data, replaceStrategy)| lets
% you define the replacement strategy. 
%
%%
% @param |replaceStrategy| : defines what method should be used to replace
% outliers, char.
%
% * 'median': default
% * 'moving average' : does not make sense at the moment, check code
%
%%
% |data_filter= online_outlier_detection(N, data, replaceStrategy, mode)|
% lets you define whether the filter is used as an online or offline
% filter.
%
%%
% @param |mode| : defines if the filter should be used as online or offline
% filter. char
%
% * 'online', default: Only the last value is checked for to be an outlier
% and also only this last value is returned
% * 'offline' : the given |data| is completely checked for outliers and
% then also returned.
%
%%
% |data_filter= online_outlier_detection(N, database_name, table_name)|
% reads the data out of the table |table_name| in the given postgreSQL
% database |database_name| using <readfromdatabase.html readfromdatabase>.
% The data is resampled using the minimum time distance between two
% measurements in the database. (NOT DONE YET!!!). See discussion inside
% script file. 
%
%%
% @param |N| : length of moving window, double scalar. The length of the
% window measured in a time unit is given by the minimum distance between
% two measurements in the database times |N|. (NOT YET!!! Same discussion
% as above). 
%
%%
% @param |database_name| : name of the postgreSQL database, char
%
%%
% @param |table_name| : name of the table inside the postgreSQL database,
% char 
%
%%
% |[...]= online_outlier_detection(N, database_name, table_name,
% replaceStrategy)| introduces the argument |replaceStrategy|, same as
% above. 
%
%%
% |[...]= online_outlier_detection(N, database_name, table_name,
% replaceStrategy, mode)| introduces the argument |mode|, same as
% above. 
%
%% Example
%
% # filter and plot measured data. You can compare all results with the
% results obtained calling <filterdata.html filterData>

data= load_file( 'reference_ch4_total_p' );

N= 20;

data_filter= online_outlier_detection(N, data(2,:), 'median', 'offline');

%%

subplot(3,1,1)
plot(data(1,:), data(2,:), 'r', data(1,:), data_filter, 'b');
ylabel('CH4 measured and filtered [%]');
xlabel('time [d]')
subplot(3,1,2)
plot(data(1,:), data(2,:), 'r');
ylabel('CH4 measured [%]');
xlabel('time [d]')
subplot(3,1,3)
plot(data(1,:), data_filter, 'b');
ylabel('CH4 filtered [%]');
xlabel('time [d]')

%%

ref_gas_1= load_file('reference_gas_stream_bhkw1');

figure, plot(ref_gas_1(1,:), ref_gas_1(2,:), 'r', ref_gas_1(1,:), ...
     online_outlier_detection(50, ref_gas_1(2,:), [], 'offline'), 'b');
xlabel('days [d]');
ylabel('biogas stream 1 [m³/d]');

%%

ref_gas_2= load_file('reference_gas_stream_bhkw2');

figure
plot(ref_gas_2(1,:), ref_gas_2(2,:), 'r', ...
     ref_gas_2(1,:), filterData(ref_gas_2(2,:)), 'b', ...
     ref_gas_2(1,:), ...
     online_outlier_detection(50, ref_gas_2(2,:), [], 'offline'), 'g.');
xlabel('days [d]');
ylabel('biogas stream 2 [m³/d]');

%%

figure
plot(ref_gas_2(1,:), ref_gas_2(2,:), 'r', ...
     ref_gas_2(1,:), sgolayfilt(ref_gas_2(2,:), 3, 29), 'b', ...
     ref_gas_2(1,:), sgolayfilt( filterData( ref_gas_2(2,:) ), 3, 29), 'g.');
xlabel('days [d]');
ylabel('biogas stream 2 [m³/d]');
   

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('median')">
% matlab/median</a>
% </html>
% ,
% <html>
% <a href="readfromdatabase.html">
% data_tool/readfromdatabase</a>
% </html>
% ,
% <html>
% <a href="mad.html">
% data_tool/mad</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validatestring')">
% matlab/validatestring</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% <html>
% <a href="resampledatats.html">
% resampleDataTS</a>
% </html>
% ,
% <html>
% <a href="filterdata.html">
% filterData</a>
% </html>
% ,
% <html>
% <a href=matlab:doc('load_file')">
% load_file</a>
% </html>
% ,
% <html>
% <a href=matlab:doc('sgolayfilt')">
% sgolayfilt</a>
% </html>
%
%% TODOs
% # see TODOs inside file
% # create documentation for script file
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% Menold, P.H.; Pearson, R.K.; Allgöwer, F.: 
% <a href="matlab:feval(@open, eval('sprintf(''%s\\pdfs\\99 Online outlier detection and removal.pdf'', data_tool.getHelpPath())'))">
% Online Outlier Detection and Removal</a>,
% Proceedings of the 7th Mediterranean Conference on Control and Automation
% (MED99) Haifa, Israel - June 28-30, 1999
% </li>
% </ol>
% <ol>
% <li> 
% Savitzky, A.; Golay, M.J.E.: 
% <a href="matlab:feval(@open, eval('sprintf(''%s\\pdfs\\64 Smoothing and Differentiation of Data by Simplified Least Squares Procedures.pdf'', data_tool.getHelpPath())'))">
% Smoothing and Differentiation of Data by Simplified Least Squares Procedures</a>,
% Analytical Chemistry, 36(8), pp. 1627-1639, 1964
% </li>
% </ol>
% </html>
%


