%% Syntax
%       xp= MHE_ADM1(f, h, u, y, x0, window) 
%       xp= MHE_ADM1(f, h, u, y, x0, window, sampletime)
%       xp= MHE_ADM1(f, h, u, y, x0, window, sampletime, u_sample)
%       xp= MHE_ADM1(f, h, u, y, x0, window, sampletime, u_sample, shift_window)
%       xp= MHE_ADM1(f, h, u, y, x0, window, sampletime, u_sample, shift_window,
%       rel_noise_in)
%       
%% Description
% |xp= MHE_ADM1(f, h, u, y, x0, window, sampletime, u_sample, shift_window,
% rel_noise_in)| calls the moving horizon state estimation algorithm. The
% method runs until the moving window is shifted completely over the
% measurement vector |y|. 
%
%%
% @param |f| : <matlab:doc('function_handle') function_handle> to
% continuous system function f. |f| must have three free inputs, which are
% time, state and input. For examples see the systems:
%
% * <matlab:doc('biogas_scripts/am1ode4') biogas_scripts/AM1ode4> 
% * <matlab:doc('biogas_scripts/adode6') biogas_scripts/ADode6> 
%
%%
% @param |h| : <matlab:doc('function_handle') function_handle> to cont.
% measurement function h. May have one input, which is the state, or may
% have two inputs with additionally the input. An example for the first
% case is <matlab:doc('biogas_scripts/am1ode4') biogas_scripts/AM1ode4> and
% for the second case is <matlab:doc('biogas_scripts/adode6')
% biogas_scripts/ADode6>. 
%
%%
% @param |u| : double vector of input samples. If there is more than
% one input, |u| is a matrix with the following format:
%
% assuming u is given as u= [input 1, input 2, ...]
% each input i is a column vector
%
% The given input is noise free. 
%
%%
% @param |y| : double vector of measurement samples. If there is more than
% one measured variable, |y| is a matrix with the following format:
%
% assuming y is given as y= [measurement 1, measurement 2, ...]
% each measurement i is a column vector
%
% The given output contains noise. Sampling time of measurements is given
% by |sampletime|.
%
%%
% @return |xp| : predicted states over time, a double matrix with as many
% columns as is the dimension of the state vector and as many rows as there
% are iterations. 
%
%%
% @param |x0| : initial state, row or column vector. 
%
%%
% @param |window| : size of the moving window measured in base unit of the
% system. For the system <matlab:doc('biogas_scripts/adode6')
% biogas_scripts/ADode6> this is hour and for the system
% <matlab:doc('biogas_scripts/am1ode4') biogas_scripts/AM1ode4> it is days.
%
%%
% @param |sampletime| : sampling time of the measurement values |y|,
% measured in base unit of the system. 
%
%%
% @param |u_sample| : 1, if inputs have the same sampling time as
% |sampletime|. Otherwise < 1, defining the sampling time of u with respect
% to the sampling time |sampletime|. Thus the total sampling time of |u|
% is |u_sample * sampletime|. 
%
%%
% @param |shift_window| : defines by how much the window is shifted between
% two iterations. Measured in the unit of |sampletime|. 
%
%%
% @param |rel_noise_in| : not used
%
%% Example
%
%


%%

close all;
clear;

%% 



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
% <a href="matlab:doc script_collection/isrn">
% script_collection/isRn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc data_tool/mhe_adm1_objective">
% data_tool/MHE_ADM1_objective</a>
% </html>
% ,
% <html>
% <a href="matlab:doc optimization_tool/startcmaes">
% optimization_tool/startCMAES</a>
% </html>
% ,
% <html>
% <a href="matlab:doc ode15s">
% matlab/ode15s</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/odeset">
% matlab/odeset</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% <html>
% <a href="matlab:doc('matlab/kalman')">
% matlab/kalman</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('data_tool/ekf_discrete_simon')">
% data_tool/ekf_discrete_simon</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('data_tool/ekf_hybrid_simon')">
% data_tool/ekf_hybrid_simon</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('ekf_cont_simon')">
% ekf_cont_simon</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('kalman_discrete_simon')">
% kalman_discrete_simon</a>
% </html>
%
%% TODOs
% # improve documentation
% # improve code documentation
% # add working example
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% Busch, J., Kühl, P., and Schlöder, J. (2009): 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\09 State estimation for large-scale wastewater treatment plants.pdf'', 
% data_tool.getHelpPath())'))">
% State estimation for large-scale wastewater treatment plants</a>, 
% Advanced Control of Chemical Processes, 7(1), 596–601.
% </li>
% <li> 
% Diehl, M., Kühl, P., Bock, H. G., and Schlöder, J. P. (2006): 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\Diehl2006e.pdf'', 
% data_tool.getHelpPath())'))">
% Schnelle Algorithmen für die Zustands- und Parameterschätzung auf
% bewegten Horizonten (Fast Algorithms for State and Parameter Estimation
% on Moving Horizons)</a>
% at - Automatisierungstechnik, 54(12), 602–613.
% </li>
% </ol>
% </html>
%


