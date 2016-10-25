%% Syntax
%       u= create_rand_signal()
%       u= create_rand_signal(toiter)
%       u= create_rand_signal(toiter, npoints)
%       u= create_rand_signal(toiter, npoints, min_max)
%       u= create_rand_signal(toiter, npoints, min_max, interpolation)
%       u= create_rand_signal(toiter, npoints, min_max, interpolation,
%       start_value) 
%       u= create_rand_signal(toiter, npoints, min_max, interpolation,
%       start_value, end_value) 
%       
%% Description
% |u= create_rand_signal()| generates a random signal over a time domain
% given by |toiter= 2000| between the values given by the 2-dim. double
% vector |min_max= [0 50]|. The signal is a spline curve created out of
% |npoints= 15| grid/supporting points. 
%
%%
% @param |toiter| : the max value of the time domain. Default: 2000
%
%%
% @param |npoints| : number of grid points used to generate the signal.
% Default: 15. 
%
%%
% @param |min_max| : 2-dim double array given min and max value of the
% range of values of the random signal. Default: [0, 50]
%
%%
% @param |interpolation| : kind of interpolation used, char. Default:
% 'spline'. 
%
% * 'linear' : a piecewise linear signal is generated
% * 'nearest' : a rectangular signal is generated: piecewise constant
% * 'cubic' : a polynom is generated
% * 'spline' : signal using splines
%
%%
% @param |start_value| : first value of the signal vector. if it does not
% matter, then set it to []. This is the default. 
%
%%
% @param |end_value| : last value of the signal vector. if it does not
% matter, then set it to []. This is the default. 
%
%%
% @return |u| : the random signal, double row vector
%
%% Example
%
%

u11= create_rand_signal(100 * 24, [], [2 10], 'nearest');
plot(1:numel(u11), u11)

%%

u21= create_rand_signal(100, 1, [10 45], 'nearest');
plot(1:numel(u21), u21)

%%

u12= create_rand_signal(100 * 24, [], [2 10], 'linear');
plot(1:numel(u12), u12)

%%

u22= create_rand_signal(100 * 24, [], [20 75], 'linear');
plot(1:numel(u22), u22)

%%

u13= create_rand_signal(100 * 24, [], [2 10]);
plot(1:numel(u13), u13)

%%

u23= create_rand_signal(100 * 24, [], [20 75]);
plot(1:numel(u23), u23)

%%

yref= create_rand_signal(100, 5, [250 500], 'linear');
plot(1:numel(yref), yref)

%%

utest= create_rand_signal(100 * 24, [], [20 75], 'cubic');
plot(1:numel(utest), utest)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isr">
% script_collection/isR</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/randi">
% matlab/randi</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/interp1">
% matlab/interp1</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% -
%
%% TODOs
% # check and maybe improve documentation
% # add option to create signal using latin hypercube sampling, not only
% using random numbers
%
%% <<AuthorTag_DG/>>


