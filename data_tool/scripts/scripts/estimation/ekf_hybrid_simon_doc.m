%% Syntax
%       xp= ekf_hybrid_simon(f, h, fA, fB, fC, u, y)
%       [...]= ekf_hybrid_simon(f, h, fA, fB, fC, u, y, Q)
%       [...]= ekf_hybrid_simon(f, h, fA, fB, fC, u, y, Q, R)
%       [...]= ekf_hybrid_simon(f, h, fA, fB, fC, u, y, Q, R, x0)
%       [...]= ekf_hybrid_simon(f, h, fA, fB, fC, u, y, Q, R, x0. P0)
%       [...]= ekf_hybrid_simon(f, h, fA, fB, fC, u, y, Q, R, x0, P0,
%       toiteration) 
%       [...]= ekf_hybrid_simon(f, h, fA, fB, fC, u, y, Q, R, x0, P0,
%       toiteration, sampletime) 
%       [...]= ekf_hybrid_simon(f, h, fA, fB, fC, u, y, Q, R, x0, P0,
%       toiteration, sampletime, u_sample) 
%       [xp, xm]= ekf_hybrid_simon(...)
%       [xp, xm, Pp]= ekf_hybrid_simon(...)
%       [xp, xm, Pp, Pm]= ekf_hybrid_simon(...)
%       [xp, xm, Pp, Pm, K]= ekf_hybrid_simon(...)
%       
%% Description
% |xp= ekf_hybrid_simon(f, h, fA, fB, fC, u, y)| is a
% hybrid Extended Kalman filter 
% implementation for the continuous differential equation system:
%
% ...
%
% w(t) and v(k) are random processes with mean value: 0
%
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
% @param |fA| : <matlab:doc('function_handle') function_handle> to cont.
% system matrix A. May have one input, which is the state, or may
% have three inputs: time, state, input. An example for the first
% case is <matlab:doc('biogas_scripts/am1ode4') biogas_scripts/AM1ode4> and
% for the second case is <matlab:doc('biogas_scripts/adode6')
% biogas_scripts/ADode6>. 
%
%%
% @param |fB| : <matlab:doc('function_handle') function_handle> to cont.
% input matrix B. May have one input, which is the state, or may
% have three inputs: time, state, input. An example for the first
% case is <matlab:doc('biogas_scripts/am1ode4') biogas_scripts/AM1ode4> and
% for the second case is <matlab:doc('biogas_scripts/adode6')
% biogas_scripts/ADode6>. 
%
%%
% @param |fC| : <matlab:doc('function_handle') function_handle> to discrete
% (same as cont.) measurement matrix C. May have one input, which is the state, or may
% have three inputs: time, state, input. An example for the first
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
% The given output contains noise. 
%
%%
% @return |xp| : predicted posteriori states over time, a double matrix with as many
% rows as is the dimension of the state vector and as many columns as there
% are iterations (|toiteration|). 
%
%%
% @param |Q| : covariance matrix of the random process w(t)
%
%%
% @param |R| : covariance matrix of the random process v(k)
%
%%
% @param |x0| : initial state, row or column vector. 
%
%%
% @param |P0| : initial covariance matrix estimate of the initial state
%
%%
% @param |toiteration| : number of iterations to run. Default: 10000. 
%
%%
% @param |sampletime| : sampling time of the system. Defines how far the
% system is integrated in each iteration. 
%
%%
% @param |u_sample| : 1, if inputs have the same sampling time as
% |sampletime|. Otherwise < 1, defining the sampling time of u with respect
% to the sampling time |samplingtime|. Thus the total sampling time of |u|
% is |u_sample * sampletime|. 
%
%%
% @return |xm| : predicted priori states over time, a double matrix with as many
% rows as is the dimension of the state vector and as many columns as there
% are iterations (|toiteration|). 
%
%%
% @return |Pp| : predicted posteriori covariance matrix estimates returned
% by the filter over time. 3dim matrix. first two dimensions are the
% covariance matrix, last dimension is the iteration. 
%
%%
% @return |Pm| : predicted priori covariance matrix estimates returned
% by the filter over time. 3dim matrix. first two dimensions are the
% covariance matrix, last dimension is the iteration. 
%
%%
% @return |K| : Kalman matrix over time.  3dim matrix. first two dimensions are the
% Kalman matrix, last dimension is the iteration. 
%
%% Example
%
%


%%

close all;
clear;

%% 

D= 0.01;
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

fA= @(x)calcAM1_ABC(x, params, 'A');
fB= @(x)calcAM1_ABC(x, params, 'B');
fC= @(x)calcAM1_ABC(x, params, 'C');

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

[xp, xm, Pp, Pm, K]= ...
  ekf_hybrid_simon( f, h, fA, fB, fC, u, y, w, diag(std_dev_in_out.^2), ...
                    x0hat, P0, toiteration, 1, 1 );

%%

Pvec11= 0;
Pvec22= 0;
Pvec33= 0;
Pvec44= 0;

for ii=1:toiteration
  Pvec11= [Pvec11; Pm(1,1,ii); Pp(1,1,ii)];
  Pvec22= [Pvec22; Pm(2,2,ii); Pp(2,2,ii)];
  Pvec33= [Pvec33; Pm(3,3,ii); Pp(3,3,ii)];
  Pvec44= [Pvec44; Pm(4,4,ii); Pp(4,4,ii)];
end


%%

figure, plot(1:toiteration, u(:,1), 'b', 1:toiteration, u(:,2), 'r');

%%

figure, plot(1:toiteration, xsim(:,1), 1:toiteration, xp(1,:));
figure, plot(1:toiteration, xsim(:,2), 1:toiteration, xp(2,:));
figure, plot(1:toiteration, xsim(:,3), 1:toiteration, xp(3,:));
figure, plot(1:toiteration, xsim(:,4), 1:toiteration, xp(4,:));

%%
 
figure;
subplot(1,2,1)
plot(1:2*toiteration-1, Pvec11(3:2*toiteration+1), 'b', 1:2*toiteration-1, Pvec22(3:2*toiteration+1), 'r')
title('Kovarianzmatrix P[1][1], P[2][2]');
legend('P[1][1]', 'P[2][2]')

%figure;
subplot(1,2,2)
plot(1:2*toiteration-1, Pvec33(3:2*toiteration+1), 'b', 1:2*toiteration-1, Pvec44(3:2*toiteration+1), 'r')
title('Kovarianzmatrix P[3][3], P[4][4]');
legend('P[3][3]', 'P[4][4]')

%%

err= zeros(1,4);

for ierr= 1:4
  err(ierr)= numerics.math.calcRMSE(xsim(:,ierr), xp(ierr,:));
end

mean(err)

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
% <a href="matlab:doc matlab/obsv">
% matlab/obsv</a>
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
% <a href="matlab:doc('ekf_discrete_simon')">
% ekf_discrete_simon</a>
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
%
%% <<AuthorTag_DG/>>
%% References
%
% # Dan Simon: Optimal State Estimation - Kalman, H$\infty$, and Nonlinear
% Approaches, John Wiley & Sons, 2006. 
%


