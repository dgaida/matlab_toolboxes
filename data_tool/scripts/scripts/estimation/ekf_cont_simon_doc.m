%% Syntax
%       x_Pdot= ekf_cont_simon(t, xP, f, h, fA, fB, fC, u, y)
%       [...]= ekf_cont_simon(t, xP, f, h, fA, fB, fC, u, y, Q)
%       [...]= ekf_cont_simon(t, xP, f, h, fA, fB, fC, Q, R)
%       
%% Description
% |x_Pdot= ekf_cont_simon(t, xP, f, h, fA, fB, fC, u, y)| is a
% continuous-time Extended Kalman filter 
% implementation for the coninuous differential equation system:
%
% ...
%
% w(t) and v(t) are random processes with mean value: 0
%
%
% WARNING: DO NOT USE THIS IMPLEMENTATION 
%
% the continuous EKF needs continuous measurements y, this implementation
% only allows discrete measurements y. for this case we have to use the
% hybrid EKF: ekf_hybrid_simon!
%
%%
% @param |f| : function_handle to system function
%
%%
% @param |h| : function_handle to measurement function
%
%%
% @param |fA| : function_handle to system matrix
%
%%
% @param |fB| : input matrix
%
%%
% @param |fC| : measurement matrix
%
%%
% @param |u| : double vector of input samples. If there is more than
% one input, |u| is a matrix with the following format:
%
% assuming u is given as u= [input 1, input 2, ...]
% each input i is a column vector
%
%%
% @param |y| : double vector of measurement samples. If there is more than
% one measured variable, |y| is a matrix with the following format:
%
% assuming y is given as y= [measurement 1, measurement 2, ...]
% each measurement i is a column vector
%
%%
% @return |xPdot| : 
%
%%
% @param |Q| : covariance matrix of the random process w(k)
%
%%
% @param |R| : covariance matrix of the random process v(k)
%
%% Example
%
%


%%

close all;
clear;
%clc;

%% 

D= 0.01;
D= 0.90;      % not "stable"
%D= 0.5;      % "stable"

[params]= setAM1params(D);

toiteration= 200; % 365; % 7500;      % days

%x0= [5 0.4 45.8 0.061];
%x0= [0.035 0.98 0.1 0.11];
% equilibrium for S1in= 2, S2in= 20
x0= [2 0.001 15.9401 0.0076];

opt=odeset('RelTol',1e-4,'AbsTol',1e-6);%,'OutputFcn',@debugode);

S1_in= 2.0;
S2_in= 20.0;

u= [S1_in * ones(toiteration, 1), S2_in * ones(toiteration, 1)];
u= [S1_in + sort( 8 * rand(toiteration, 1) ), S2_in + sort( 55 * rand(toiteration, 1) )];

[tsim, xsim]= ode15s( @AM1ode4, [0:1:toiteration - 1], x0, opt, u, params );

Q_ch4= calcAM1y(xsim, params);
y= Q_ch4;

%%

fA= @(x)calcAM1_ABC(x, params, 'A');
fB= @(x)calcAM1_ABC(x, params, 'B');
fC= @(x)calcAM1_ABC(x, params, 'C');

f= @(x, u)AM1ode4(0, x, u, params);
h= @(x)calcAM1y(x, params);

std_dev_in_out= 0.1;

w= [std_dev_in_out .* randn(toiteration,1), std_dev_in_out .* randn(toiteration,1)];
y= y + std_dev_in_out .* randn(toiteration,1);

% 0.1
std_dev= 1.0;
std_dev= 0.01;

P0= std_dev^2 .* eye(numel(x0), numel(x0));
P0= P0(:);

x0hat= x0 + std_dev .* randn(1,4);
x0hat= max(0, x0hat);

x0= [x0hat(:); P0];

%%

[tsim2, xsim2]= ode15s( @ekf_cont_simon, [0:1:toiteration - 1], ...
                        x0, opt, f, h, fA, fB, fC, u, y, w );

%%

figure, plot(1:toiteration, xsim(:,1), 1:toiteration, xsim2(:,1));
figure, plot(1:toiteration, xsim(:,2), 1:toiteration, xsim2(:,2));
figure, plot(1:toiteration, xsim(:,3), 1:toiteration, xsim2(:,3));
figure, plot(1:toiteration, xsim(:,4), 1:toiteration, xsim2(:,4));

%%

figure, plot(1:toiteration, xsim2(:,5), 1:toiteration, xsim2(:,10));
figure, plot(1:toiteration, xsim2(:,15), 1:toiteration, xsim2(:,20));


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
% <a href="matlab:doc('kalman_discrete_simon')">
% kalman_discrete_simon</a>
% </html>
%
%% TODOs
% # improve documentation significantly
% # improve code documentation
%
%% <<AuthorTag_DG/>>
%% References
%
% # Dan Simon: Optimal State Estimation - Kalman, H$\infty$, and Nonlinear
% Approaches, John Wiley & Sons, 2006. 
%


