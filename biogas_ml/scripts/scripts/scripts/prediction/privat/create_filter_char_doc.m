%% Syntax
%       filter_char= create_filter_char(filter_num)
%
%% Description
% |filter_char= create_filter_char(filter_num)| returns a cell array of 
% characters (<matlab:doc('cellstr') cellstr>) containing filter shortcuts
% for the wanted filters. This function is only called by
% <createdatasetforpredictor.html createDataSetForPredictor>, no further
% use. 
%
%%
% @param |filter_num| : double vector with numbers where the filters should
% be set, measured in hours, integer numbers. If at least one entry of
% |filter_num| is entry, then no filter is created (see the 2nd example).
%
%%
% @return |filter_char| : cell array of characters, where the characters
% contain the numbers preceded by a 'h' or 'd', symolizing hours
% respectively days
%
%% Example
% 
% # Create four filters: 12 h, 24 h, 3 days and 7 days

create_filter_char([12, 24, 3*24, 7*24])

%%
% # One entry is 0, thus an empty cell array is returned

create_filter_char([0, 24, 3*24, 7*24])

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="createdatasetforpredictor.html">
% createDataSetForPredictor</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="createstateestimator.html">
% createStateEstimator</a>
% </html>
%
%% TODOs
%
%
%% <<AuthorTag_DG/>>


