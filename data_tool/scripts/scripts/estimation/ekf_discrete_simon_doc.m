%% Syntax
%       [xp]= ekf_discrete_simon(f, h, fA, fB, fC, u, y)
%       [...]= ekf_discrete_simon(f, h, fA, fB, fC, u, y, Q)
%       [...]= ekf_discrete_simon(f, h, fA, fB, fC, u, y, Q, R)
%       [...]= ekf_discrete_simon(f, h, fA, fB, fC, u, y, Q, R, x0)
%       [...]= ekf_discrete_simon(f, h, fA, fB, fC, u, y, Q, R, x0, P0)
%       [...]= ekf_discrete_simon(f, h, fA, fB, fC, u, y, Q, R, x0, P0,
%       toiteration) 
%       [xp, xm]= ekf_discrete_simon(...)
%       [xp, xm, Pp]= ekf_discrete_simon(...)
%       [xp, xm, Pp, Pm]= ekf_discrete_simon(...)
%       [xp, xm, Pp, Pm, K]= ekf_discrete_simon(...)
%       
%% Description
% |[xp]= ekf_discrete_simon(f, h, fA, fB, fC, u, y)| is a discrete-time
% Extended Kalman filter 
% implementation for the discrete differential equation system:
%
% x(k+1)= f( x(k), u(k) ) + B * w(k)
% y(k)= h( x(k) ) + v(k)
%
% w(k) and v(k) are random processes with mean value: 0
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
% @return |xp| : posteriori state estimate over the iterations
%
%%
% @param |Q| : covariance matrix of the random process w(k)
%
%%
% @param |R| : covariance matrix of the random process v(k)
%
%%
% @param |x0| : double vector with initial state vector estimate
%
%%
% @param |P0| : initial covariance matrix
%
%%
% @param |toiteration| : number of iterations to run
%
%%
% @return |xm| : priori state estimate over the iterations
%
%%
% @return |Pp| : posteriori covariance matrix over the iterations
%
%%
% @return |Pm| : priori covariance matrix over the iterations
%
%%
% @return |K| : Kalman matrix over the iterations
%
%% Example
%
%

close all;
clear;

%%

D= 0.90;

deltatk= 1/12;%/12;%1/6;

[params]= setAM1params(D);

toiteration= 100 / deltatk; % 365; % 7500;      % days

%x0= [5 0.4 45.8 0.061];
%x0= [0.035 0.98 0.1 0.11];
% equilibrium for S1in= 2, S2in= 20
x0= [5.7239 0.0145 45.6809 0.0122];
x0= [4.29 0.275 15.6809 0.07522];

S1_in= 5.8;
S2_in= 52.0;

%% 

u= [S1_in * ones(toiteration, 1), S2_in * ones(toiteration, 1)];
u= [S1_in + sort( 8 * rand(toiteration, 1) ), S2_in + sort( 55 * rand(toiteration, 1) )];
%u= [(S1_in:S1_in/toiteration:2*S1_in)', (S2_in:S2_in/toiteration:2*S2_in)'];
%u= u(1:toiteration, :);

%%

opt=odeset('RelTol',1e-4,'AbsTol',1e-6);%,'OutputFcn',@debugode);

[tsim, xsim]= ode15s( @AM1ode4, [0:deltatk:(toiteration - 1)*deltatk], x0, opt, u, deltatk, params );

%%

y= calcAM1y(xsim, params);

%%

fA= @(x)calcAM1_ABC_discrete(x, deltatk, params, 'A');
fB= @(x)calcAM1_ABC_discrete(x, deltatk, params, 'B');
fC= @(x)calcAM1_ABC_discrete(x, deltatk, params, 'C');

f= @(x, u)AM1ode4_discrete(0, x, u, deltatk, params);
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

xk= zeros(toiteration, 4);
xk2= zeros(toiteration, 4);

xk(1,:)= x0;
xk2(1,:)= x0;

for iiter= 1:toiteration - 1

  xk(iiter + 1, :)=  feval(f, xk(iiter, :)', u(iiter, :))';
  xk2(iiter + 1, :)= feval(fA, xk2(iiter, :)') * xk2(iiter, :)' + ...
                     feval(fB, xk2(iiter, :)') * u(iiter, :)';
  
end

%%

figure, plot(1:toiteration, xsim(:,1), '.b', 1:toiteration, xk2(:,1), '--r', ...
             1:toiteration, xk(:,1), '.g');
figure, plot(1:toiteration, xsim(:,2), '.b', 1:toiteration, xk2(:,2), '--r', ...
             1:toiteration, xk(:,2), '.g');
figure, plot(1:toiteration, xsim(:,3), '.b', 1:toiteration, xk2(:,3), '--r', ...
             1:toiteration, xk(:,3), '.g');
figure, plot(1:toiteration, xsim(:,4), '.b', 1:toiteration, xk2(:,4), '--r', ...
             1:toiteration, xk(:,4), '.g');


%%

[xp, xm, Pp, Pm, K]= ekf_discrete_simon(f, h, fA, fB, fC, u, y, w, ...
                                        diag(std_dev_in_out.^2), ...
                                        x0hat, P0, toiteration);

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

figure, plot(1:toiteration, xsim(:,1), 'b', 1:toiteration, xp(1,:), 'r');
figure, plot(1:toiteration, xsim(:,2), 'b', 1:toiteration, xp(2,:), 'r');
figure, plot(1:toiteration, xsim(:,3), 'b', 1:toiteration, xp(3,:), 'r');
figure, plot(1:toiteration, xsim(:,4), 'b', 1:toiteration, xp(4,:), 'r');

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
% <a href="matlab:doc('kalman_discrete_simon')">
% kalman_discrete_simon</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('ekf_cont_simon')">
% ekf_cont_simon</a>
% </html>
%
%% TODOs
% # improve documentation
% # make an example
% # check script
%
%% <<AuthorTag_DG/>>
%% References
%
% # Dan Simon: Optimal State Estimation - Kalman, H$\infty$, and Nonlinear
% Approaches, John Wiley & Sons, 2006. 
%


