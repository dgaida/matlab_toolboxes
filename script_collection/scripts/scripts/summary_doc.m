%% Syntax
%       summary(data)
%       summary(data, ignoreNaNs)
%       [mean_data]= summary(data)
%       [mean_data, min_data]= summary(data)
%       [mean_data, min_data, max_data]= summary(data)
%       
%% Description
% |summary(data)| calculates the mean, min and max of |data|. If data is a
% vector, then these values are scalars and thus diplayed.
%
%%
% @param |data| : double vector (or matrix)
%
%%
% @param |ignoreNaNs| : double scalar
%
% * 0: If values inside the dataset are NaNs, then the mean will be NaN as
% well
% * 1: If values inside the dataset are NaNs, then the mean will not be
% NaN, because then NaNs are ignored.
%
%%
% @return |mean_data| : |mean(data)|
%
%%
% @return |min_data| : |min(data)|
%
%%
% @return |max_data| : |max(data)|
%
%% Example
%
% # Easy example:
%

summary([1, 2, 3, 4, 6]);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc matlab/mean">
% matlab/mean</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/min">
% matlab/min</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/max">
% matlab/max</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/nanmean">
% matlab/nanmean</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/nanmin">
% matlab/nanmin</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/nanmax">
% matlab/nanmax</a>
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
%
% and is called by:
%
% (the user)
%
%% See also
% 
% <html>
% <a href="matlab:doc data_tool/mad">
% data_tool/mad</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/median">
% matlab/median</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/std">
% matlab/std</a>
% </html>
% 
%% TODOs
% # make documentation for script file
% # man könnte diese funktion erweitern, in dem man median, std-abweichung,
% MAD etc. ermittelt
%
%% <<AuthorTag_DG/>>


