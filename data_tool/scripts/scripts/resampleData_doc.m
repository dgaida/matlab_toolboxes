%% Syntax
%       [data_res]= resampleData(data, cur_grid, new_grid)
%
%% Description
% |[data_res]= resampleData(data, cur_grid, new_grid)| resamples |data|
% array measured at a given grid |cur_grid| using the |new_grid|. If
% |new_grid| is a scalar, then the values in |data| are returned which are
% as close as possible to the given time, and measured not after the given
% time. Same for an array, see the examples.
%
%%
% @param |data| : double data vector or array, which will be resampled. The
% data is given as rows.
%
%%
% @param |cur_grid| : current time vector of |data|, double vector or
% array. The time is given as rows.
%
%%
% @param |new_grid| : new time grid, double vector or scalar
%
%% Example
% 
% Get the data at time 0 and 8.9.
%

data= [36.2, 34.28, 46.2;...
       22.2, 12.2, 32.2;...
       0,5,1;...
       1.50, 1.80, 2.20];

cur_grid= [0, 7, 14; ...
           1, 7, 14; ...
           0, 9, 10; ...
           0, 2, 14];

new_grid= 0;

resampleData(data, cur_grid, new_grid)

resampleData(data, cur_grid, 8.9)


%%
%

data= [36.2, 34.28, 46.2;...
       22.2, 12.2, 32.2;...
       0,5,1;...
       1.50, 1.80, 2.20];

cur_grid= [0, 7, 14; ...
           1, 7, 14; ...
           0, 9, 10; ...
           0, 2, 14];

new_grid= [0, 1, 1.9, 2, 5, 10, 13, 14, 14.01, 15];

resampleData(data, cur_grid, new_grid)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('createdatasetforpredictor')">
% createDataSetForPredictor</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="resampledatats.html">
% resampleDataTS</a>
% </html>
% ,
% <html>
% <a href="resamplets.html">
% resampleTS</a>
% </html>
%
%% TODOs
% # create documentation for script file
% 
%
%% <<AuthorTag_DG/>>


