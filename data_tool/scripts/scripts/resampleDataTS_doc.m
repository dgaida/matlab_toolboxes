%% Syntax
%       ts_res= resampleDataTS(data)
%       ts_res= resampleDataTS(data, numPerDay)
%
%% Preliminaries
% Uses the <matlab:doc('tstool') tstool> toolbox.
%
%% Description
% |ts_res= resampleDataTS(data)| resamples the given |data| using 24
% samples per day, respectively a sample time of 1 h. Throws an error if
% <matlab:doc('tstool') tstool> is not installed. The resampling step is
% performed calling the function <resamplets.html resampleTS>. 
%
%%
% @param |data| : cell array, where the 1st column defines the date and the
% 2nd column defines the data. The 1st column must be something the
% <matlab:doc('tstool') tstool> toolbox recognizes as date. The 2nd
% column must be double. 
%
%%
% @param |numPerDay| : double scalar, defines the number of samples per
% day. Default value is 24, thus the sample time is 1 h. 
%
%%
% @return |ts_res| : <matlab:doc('timeseries') timeseries> object
% containing the resampled data
%
%% Example
% 
% Resample data read out of a postgreSQL database. The data inside the
% database contains outliers, such that it is recommended to use the
% function <getfiltereddatafromdb.html getFilteredDataFromDB> to read
% the data, this function then calls this function. 
%

[data]= readfromdatabase('sunderhook_database', 'nachgaerer_fermenter0', inf);

subplot(2,1,1)
plot(datenum(data(:,1)) - min(datenum(data(:,1))), cell2mat(data(:,2)), '.');
title('Original data out of the database');

ts_res= resampleDataTS(data, 24);

data_res= ts_res.Data;

subplot(2,1,2)
plot(ts_res.Time, data_res, '.')
title('Resampled data out of the database');


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc timeseries">
% matlab/timeseries</a>
% </html>
% ,
% <html>
% <a href="matlab:doc data_tool/resamplets">
% data_tool/resampleTS</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="readfromdatabase.html">
% readfromdatabase</a>
% </html>
%
%% See Also
%
% <html>
% <a href="getfiltereddatafromdb.html">
% getFilteredDataFromDB</a>
% </html>
% ,
% <html>
% <a href="resampledata.html">
% resampleData</a>
% </html>
% ,
% <html>
% <a href="matlab:doc timeseries.resample">
% matlab/timeseries.resample</a>
% </html>
% ,
% <html>
% <a href="matlab:doc tstool">
% matlab/tstool</a>
% </html>
%
%% TODOs
% # create documentation for script
% 
% 
%% <<AuthorTag_DG/>>


