%% Syntax
%       int_data= integrate_data(data, time)
%       int_data= integrate_data(data, time, a)
%       int_data= integrate_data(data, time, a, b)
%       
%% Description
% |int_data= integrate_data(data, time)| integrates data vector over time
% domain between boundaries |a| and |b|. 
%
%%
% @param |data| : a 1d array
%
%%
% @param |time| : a 1d array with time domain
%
%%
% @param |a| : lower boundary of integral on time domain. double scalar.
% Default: |a= time(1)|. 
%
%%
% @param |b| : upper boundary of integral on time domain. double scalar.
% Default: |b= time(end)|. 
%
%%
% @return |int_data| : integral of data over the time domain between lower
% and upper boundary. 
%
%% Example
% 
% integral is approximately equal to the number of rectangles below the
% curve

data= [1 1 1 2  2  2 3 3 3];

time= [0 1 2 3 3.5 4 5 6 7];

plot(time, data)
ylim([0, 4])
grid on
set(gca, 'XTick', 0:7)
set(gca, 'YTick', 0:4)

integrate_data(data, time)

%%
% integral is approximately equal to the number of rectangles below the
% curve

data= [1  1  1 2  2  2 3  3  3 2  2   2  4  4];

time= [0 1.5 2 3 3.5 4 5 6.5 7 8 9.5 10 12 15];

plot(time, data)
ylim([0, 5])
grid on
set(gca, 'XTick', 0:15)
set(gca, 'YTick', 0:5)

integrate_data(data, time)

%%
% integral between 0 and 7, result should be the same as in the 1st example

integrate_data(data, time, 0, 7)

%%
% integral from 7 until the end. sum of the last two examples should be
% equal to the integral value of the 2nd example

integrate_data(data, time, 7)

%%
% integral should be zero

integrate_data(data, time, 7.123, 7.123)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc matlab/diff">
% matlab/diff</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/get_nearest_el_in_vec">
% script_collection/get_nearest_el_in_vec</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_optimization/getrecordedfitness">
% biogas_optimization/getRecordedFitness</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc script_collection/get_index_of_el_in_vec">
% script_collection/get_index_of_el_in_vec</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/insert_in_vec">
% script_collection/insert_in_vec</a>
% </html>
% ,
% <html>
% <a href="matlab:doc integrate">
% integrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/quad">
% matlab/quad</a>
% </html>
%
%% TODOs
% # create documentation for script file
% # check documentation
% # improve documentation
%
%% <<AuthorTag_DG/>>

    
    