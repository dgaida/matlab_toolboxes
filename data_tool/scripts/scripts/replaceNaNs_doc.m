%% Syntax
%       data_filter= replaceNaNs(data)
%
%% Description
% |data_filter= replaceNaNs(data)| replaces NaN values in vector or matrix
% |data| by moving average. The boundaries of |data| are set to the median
% of the dataset, because moving average still will be NaN for the boundary
% values. The window of the moving average is set to the maximal amount of
% consecutive following NaN values. The returned vector or matrix
% |data_filter| will not contain any NaNs anymore. 
%
%%
% @param |data| : double vector or matrix containing a few NaNs
%
%%
% @return |data_filter| : identical to |data|. Only NaN values in |data|
% are replaced by moving average or median. 
%
%% Examples
% 
% # load measurement data, replace 300 randomly selected values to NaNs and
% plot original data containing NaNs with filtered data

ref_ch4= load_file('reference_ch4_total_p');

N= numel(ref_ch4(2,:));

indices= min(max(round( rand(N, 1) * N ), 1), N);
ref_ch4(2,indices(1:300))= NaN;

filter_data= replaceNaNs(ref_ch4(2,:));

figure;
plot(ref_ch4(1,:), filter_data, 'r', ref_ch4(1,:), ref_ch4(2,:), 'b');
xlabel('days [d]');
ylabel('CH_4 concentration [%]');


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/nanmoving_average')">
% data_tool/nanmoving_average</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/nanmoving_average2')">
% data_tool/nanmoving_average2</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/nanmedian')">
% matlab/nanmedian</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="filterdata.html">
% filterData</a>
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
% <a href="online_outlier_detection.html">
% online_outlier_detection</a>
% </html>
%
%% TODOs
% # see TODOs inside the file
% # anstatt median für anfang und ende zu nehmen, besser was lokaleres
%
%% <<AuthorTag_DG/>>


