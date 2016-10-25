%% Syntax
%       ts_res= resampleTS(ts)
%       ts_res= resampleTS(ts, numPerDay)
%
%% Preliminaries
% Uses the <matlab:doc('tstool') tstool> toolbox.
%
%% Description
% |ts_res= resampleTS(ts)| resamples the given timeseries |ts| using 24
% samples per day, respectively a sample time of 1 h. Throws an error if
% <matlab:doc('tstool') tstool> is not installed. 
%
%%
% @param |ts| : <matlab:doc('matlab/timeseries') timeseries> object
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
% load a timerseries object out of a mat file. 

ts_h2= load_file('ts_h2');

plot(ts_h2);

%%
% resample 3min 

ts_h2_res= resampleTS(ts_h2, 24*60*3);

data= ts_h2_res.Data;

%%
% abschließend daten über ein moving average filter legen, fenster wird
% gemessen im zeitraster -> 15 min

data= nanmoving_average(data, 15*3, 1, 1);

%%

ts_h2_res.Data= data;

hold on;
plot(ts_h2_res, 'r', 'LineWidth', 3);
title('Original vs. moving average data');
ylabel('hydrogen concentration [ppm]');


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
% <a href="matlab:doc timeseries.resample">
% matlab/timeseries.resample</a>
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
% <a href="resampledatats.html">
% resampleDataTS</a>
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
% <a href="nanmoving_average.html">
% nanmoving_average</a>
% </html>
% ,
% <html>
% <a href="resampledata.html">
% resampleData</a>
% </html>
% ,
% <html>
% <a href="matlab:doc tstool">
% matlab/tstool</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('load_file')">
% biogas/load_file</a>
% </html>
%
%% TODOs
% # create documentation for script
% # in the example load_file is used, which is a function out of biogas
% toolbox. 
% 
%% <<AuthorTag_DG/>>


