%% Syntax
%       scaled_data= scale_Data(data)
%       scaled_data= scale_Data(data, lowLimit)
%       scaled_data= scale_Data(data, lowLimit, maxLimit)
%       [scaled_data, minimum, maximum]= scale_Data(data, ...)
%
%% Description
% |scaled_data= scale_Data(data)| scales the values in each column of
% |data| between 0 and 1 and returns the scaled data in |scaled_data|.
%
%%
% @param |data| : double matrix, vector or scalar. If a vector is given,
% then a column vector is returned, independent of the format of the given
% vector. 
%
%%
% @return |scaled_data| : |data|, scaled between 0 and 1
%
%%
% |scaled_data= scale_Data(data, lowLimit, maxLimit)| scales the data such
% that |maxLimit| equals 1 in the new dataset and |minLimit| equals 0 in
% the new dataset, but there could be 
% values bigger 1 and lower 0, if there are values bigger respectively
% smaller then |maxLimit| respectively |minLimit| in the original |data|.
% What the function is doing is an axis transformation for each column of
% |data|. The value of the origin of the new data axis measured in the axis
% of the original data is given by |lowLimit|. The scale of the new axis is
% given by |maxLimit| - |lowLimit|.
%
%%
% @param |lowLimit| : lower limit as double scalar or double row- or
% column-vector. If it is a scalar, then each column is scaled to the same
% scalar. If it is a vector, then it has to have the same size as |data|
% has columns. 
%
%%
% @param |maxLimit| : upper limit as double scalar or double row- or
% column-vector. If it is a scalar, then each column is scaled to the same
% scalar. If it is a vector, then it has to have the same size as |data|
% has columns. 
%
%%
% @return |scaled_data| : |data|, scaled between 0 and 1, respectively
% between |minLimit| and |maxLimit|.
%
%%
% |[scaled_data, minimum, maximum]= scale_Data(data, ...)| additionally
% returns the minimum and maximum values used for scaling. If |lowLimit|
% and |maxLimit| are given, then they are returned as they are used inside
% the function. Row vectors. 
%
%% Example
% |scale_Data([1,2,3])| is the same as |scale_Data([1;2;3])|, both return:
%

scale_Data([1,2,3])

scale_Data([1;2;3])

%%
% 

scale_Data([1;2;3], 0, 6)

%%
% |scale_Data(1)| throws a warning and returns NaN
%

scale_Data(1)

%%
% |scale_Data(1, -5, 100)| is ok
%

scale_Data(1, -5, 100)

%%
% |scale_Data([1,2,3; 4,5,6])|
%

scale_Data([1,2,3; 4,5,6])

%%
% |scale_Data([1,2,3; 4,5,6; 3,2,1])|
%

scale_Data([1,2,3; 4,5,6; 3,2,1])

%%
% |scale_Data([1,2,3; 4,5,6], [1,2], [3,4])| throws an
% error: dimension mismatch 2nd and 3rd argument
%

try
  scale_Data([1,2,3; 4,5,6], [1,2], [3,4])
catch ME
  disp(ME.message)
end

%%
% |scale_Data([1,2,3; 4,5,6], [1,2,3], [3,4,7])| is ok
%

scale_Data([1,2,3; 4,5,6], [1,2,3], [3,4,7])

%%
% |[scaled_data, mini, maxi]= scale_Data([1,2,3; 4,5,6])|
%

[scaled_data, mini, maxi]= scale_Data([1,2,3; 4,5,6]);

disp('scaled_data: ')
disp(scaled_data)
disp('mini: ')
disp(mini)
disp('maxi: ')
disp(maxi)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href= matlab:doc('nargchk')>
% matlab/nargchk</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc fitness_wolf">
% fitness_wolf</a>
% </html>
% ,
% <html>
% <a href="matlab:doc fitness_wolf_adapted">
% fitness_wolf_adapted</a>
% </html>
% ,
% <html>
% <a href="matlab:doc fitness_costs">
% fitness_costs</a>
% </html>
% 
%% See Also
% 
%
%% TODOs
% # check documentation 
%
%% <<AuthorTag_DG/>>


