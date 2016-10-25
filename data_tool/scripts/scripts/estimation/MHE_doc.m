%% Syntax
%       xp= MHE(f, h, u, y, x0, window) 
%       xp= MHE(f, h, u, y, x0, window, sampletime)
%       xp= MHE(f, h, u, y, x0, window, sampletime, u_sample)
%       xp= MHE(f, h, u, y, x0, window, sampletime, u_sample, shift_window)
%       xp= MHE(f, h, u, y, x0, window, sampletime, u_sample, shift_window,
%       rel_noise_in)
%       
%% Description
% |xp= MHE(f, h, u, y, x0, window, sampletime, u_sample, shift_window,
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

D= 0.90;      % not "stable"
%D= 0.5;      % "stable"

[params]= setAM1params(D);

toiteration= 500; % 365; % 7500;      % days

%x0= [5 0.4 45.8 0.061];
%x0= [0.035 0.98 0.1 0.11];
% equilibrium for S1in= 2, S2in= 20
x0= [2 0.001 15.9401 0.0076];

opt=odeset('RelTol',1e-4,'AbsTol',1e-6);%,'OutputFcn',@debugode);

S1_in= 2.0;
S2_in= 20.0;

u= [S1_in * ones(toiteration, 1), S2_in * ones(toiteration, 1)];
u= [S1_in + sort( 8 * rand(toiteration, 1) ), S2_in + sort( 55 * rand(toiteration, 1) )];

[tsim, xsim]= ode15s( @AM1ode4, [0:1:toiteration - 1], x0, opt, u, 1, params );

Q_ch4= calcAM1y(xsim, params);
y= Q_ch4;

%%

f= @(t, x, u)AM1ode4(t, x, u, 1, params);
h= @(x)calcAM1y(x, params);

std_dev_in_out= 0.1;

w= [std_dev_in_out .* randn(toiteration,1), std_dev_in_out .* randn(toiteration,1)];
y= y + std_dev_in_out .* randn(toiteration,1);

% 0.1
std_dev= 1.0;
std_dev= 0.01;

P0= std_dev^2 .* eye(numel(x0), numel(x0));

x0hat= x0 + std_dev .* randn(1,4);
x0hat= max(0, x0hat);

%%

% [xp, xm, Pp, Pm, K]= ...
%   ekf_hybrid_simon( f, h, fA, fB, fC, u, y, w, diag(std_dev_in_out.^2), ...
%                     x0hat, P0, toiteration, 1, 1 );

%%

figure, plot(1:toiteration, u(:,1), 'b', 1:toiteration, u(:,2), 'r');

%%

% figure, plot(1:toiteration, xsim(:,1), 1:toiteration, xp(1,:));
% figure, plot(1:toiteration, xsim(:,2), 1:toiteration, xp(2,:));
% figure, plot(1:toiteration, xsim(:,3), 1:toiteration, xp(3,:));
% figure, plot(1:toiteration, xsim(:,4), 1:toiteration, xp(4,:));

%%

% err= zeros(1,4);
% 
% for ierr= 1:4
%   err(ierr)= numerics.math.calcRMSE(xsim(:,ierr), xp(ierr,:));
% end
% 
% mean(err)

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
% <a href="matlab:doc data_tool/mhe_objective">
% data_tool/MHE_objective</a>
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


