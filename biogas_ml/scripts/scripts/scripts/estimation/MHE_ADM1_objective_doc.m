%% Syntax
%       fitness= MHE_ADM1_objective(x, f, h, u, y, x0, toiteration) 
%       fitness= MHE_ADM1_objective(x, f, h, u, y, x0, toiteration, sampletime) 
%       fitness= MHE_ADM1_objective(x, f, h, u, y, x0, toiteration, sampletime,
%       u_sample) 
%       
%% Description
% |fitness= MHE_ADM1_objective(x, f, h, u, y, x0, toiteration, sampletime,
% u_sample)| calculates fitness of an moving horizon estimate starting at
% state |x|. 
%
%%
% @param |x| : individual, which is the initial state of a simulation done
% in this method. 
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
% @param |x0| : initial state, row or column vector. 
%
%%
% @param |toiteration| : 
%
%%
% @param |sampletime| : sampling time of the measurement values |y|,
% measured in base unit of the system. For the system
% <matlab:doc('biogas_scripts/adode6') biogas_scripts/ADode6> the bsae unit
% is hour and for the system <matlab:doc('biogas_scripts/am1ode4')
% biogas_scripts/AM1ode4> it is days. 
%
%%
% @param |u_sample| : 1, if inputs have the same sampling time as
% |sampletime|. Otherwise < 1, defining the sampling time of u with respect
% to the sampling time |sampletime|. Thus the total sampling time of |u|
% is |u_sample * sampletime|. 
%
%%
% @return |fitness| : fitness that belongs to |x|.
%
%% Example
%
%
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
% <a href="matlab:doc script_collection/isn">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc numerics_tool/calcrmse">
% numerics_tool/calcRMSE</a>
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
% <html>
% <a href="matlab:doc data_tool/mhe_adm1">
% data_tool/MHE_ADM1</a>
% </html>
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
% # add example
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


