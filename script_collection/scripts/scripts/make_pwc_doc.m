%% Syntax
%       [time_pwc, data_pwc]= make_pwc(deltatime, v_data)
%
%% Description
% |[time_pwc, data_pwc]= make_pwc(deltatime, v_data)| creates a piecewise
% constant signal out of the double vector |v_data|. The given double
% vector |v_data| is assumed to be signal over time where the sample time
% is equidistant and equal to |deltatime|. If we want to plot |v_data| over
% time, the <matlab:doc('plot') plot> function interpolates the values
% linear same holds for Simulink, when using |v_data| as data input in
% Simulink. To have a piecewise constant signal use this function, which
% adds additional points in time, that result in steep edges of the signal.
%
%%
% The last two values inside |data_pwc| are set to the last value of
% |v_data|, such that Simulink takes this constant signal in case the
% simulation lasts longer as |time_pwc| contains values. Otherwise Simulink
% would change the input signal linearly towards 0. 
% 
%%
% @param |deltatime| : double scalar defining the sampling time of
% |v_data|. 
%
%%
% @param |v_data| : double row or column vector. Is interpreted as data
% collected over time with the given sampling time |deltatime|. 
%
%%
% @return |time_pwc| : the timegrid of the piecewise constant signal
% |data_pwc|. double column vector.
%
%%
% @return |data_pwc| : double column vector equal to |v_data| except for the
% added intermediate values. 
% 
%% Example
% 
%

v_data= [1 2 4 5 4 2];

[time_pwc, data_pwc]= make_pwc(2, v_data);

figure, plot(0:2:10, v_data, 'b')
hold on
plot(time_pwc, data_pwc, 'r')
hold off;


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/isr">
% script_collection/isR</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isrn">
% script_collection/isRn</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_scripts/createvolumeflowfile">
% biogas_scripts/createvolumeflowfile</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc Simulink/">
% Simulink</a>
% </html>
%
%% TODOs
% # check documentation
%
%% <<AuthorTag_DG/>>


