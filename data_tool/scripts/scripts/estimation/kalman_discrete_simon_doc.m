%% Syntax
%       [xp]= kalman_discrete_simon(A, B, C, D, u, y)
%       [...]= kalman_discrete_simon(A, B, C, D, u, y, Q)
%       [...]= kalman_discrete_simon(A, B, C, D, u, y, Q, R)
%       [...]= kalman_discrete_simon(A, B, C, D, u, y, Q, R, x0)
%       [...]= kalman_discrete_simon(A, B, C, D, u, y, Q, R, x0, P0)
%       [...]= kalman_discrete_simon(A, B, C, D, u, y, Q, R, x0, P0, toiteration)
%       [xp, xm]= kalman_discrete_simon(...)
%       [xp, xm, Pp]= kalman_discrete_simon(...)
%       [xp, xm, Pp, Pm]= kalman_discrete_simon(...)
%       [xp, xm, Pp, Pm, K]= kalman_discrete_simon(...)
%       
%% Description
% |[xp]= kalman_discrete_simon(A, B, C, D, u, y)| is a discrete-time Kalman filter
% implementation for the discrete differential equation system:
%
% x(k+1)= A * x(k) + B * [ u(k) + w(k) ]
% y(k)= C * x(k) + v(k)
%
% D must be empty at the moment. 
%
% w(k) and v(k) are random processes with mean value: 0
%
%%
% @param |A| : system matrix, can also be a function_handle calculating the
% system matrix A(k) in every iteration. 
%
%%
% @param |B| : input matrix, can also be a function_handle calculating the
% input matrix B(k) in every iteration. 
%
%%
% @param |C| : measurement matrix, can also be a function_handle calculating the
% measurement matrix C(k) in every iteration. 
%
%%
% @param |D| : not used at the moment
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
% @param |Q| : covariance matrix of the random process w(k). You can also
% pass w directly as vector, then |Q| is estimated out of w. 
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

% Kalman Filter anhand eines 3 x 3 doppelt integrierenden Systems mit
% Vergleich von beobachtbares System mit nicht beobachtbares

clear;
close all;

toiteration= 6000;%10000;

% standard deviation: 0.001

std_dev= 0.001; % 30; 
variance= std_dev.^2;

% all measurements (Gauss, covariance= variance, mean= 0)
y= sqrt(variance) * randn(max(toiteration, 10000),1);

deltat= 0.01; % 5


%%
% first system which is not observable
% Wir haben ein System, welches sich in Ruhe befindet, deshalb u ist der
% null Vektor. u könnte auch konstant sein um eine konstante beschleunigung
% zu simulieren.
% diese konstante beschleunigung wird durch y verrauscht gemessen

% x(k+1)= A * x(k) + B * u(k) + Q
% y(k)= C * x(k) + R
A= [1 deltat deltat^2/2; 0 1 deltat; 0 0 0];
B= [0 0 1]';

C= [0 0 1];

u= zeros(toiteration, 1);

%% TODO
% Erzeugung von Q oder w hier sehr wichtig!!!
% weil sonst Systembeschleunigung nicht angeregt wird, da in A letzte Zeile
% 0 ist.
% sonst misst Kalman Filter INputs u= 0, da u nicht rauscht ist
% beschleunigung immer exakt 0, damit auch v und x. und nur messwerte sind
% verrauscht. deshalb inputrauschen w sehr wichtig!

% measurement noise
R= variance;

[xp, xm, Pp, Pm, K]= kalman_discrete_simon(A, B, C, [], u, y, [], [], [], [], toiteration);

Kvec11= 0;
Kvec21= 0;
Kvec31= 0;
Pvec11= 0;
Pvec22= 0;
Pvec33= 0;

for ii=1:toiteration
    Kvec11= [Kvec11; K(1,1,ii)];
    Kvec21= [Kvec21; K(2,1,ii)];
    Kvec31= [Kvec31; K(3,1,ii)];
    Pvec11= [Pvec11; Pm(1,1,ii); Pp(1,1,ii)];
    Pvec22= [Pvec22; Pm(2,2,ii); Pp(2,2,ii)];
    Pvec33= [Pvec33; Pm(3,3,ii); Pp(3,3,ii)];
end


%%
% second system, which is observable

% A und B bleiben identisch
% u ist weiterhin die beschleunigung, welche 0 ist, da sich das System in
% ruhe befinden soll.
% Vorsicht: soll u konstant sein, dann ist hier die Messung y (Position)
% quadratisch, d.h. nicht mehr Mittelwertfrei, müsste dann hier neue
% generiert werden.

% diesmal wird position gemessen
C= [1 0 0];

%%

%P0= 5 .* eye(size(A, 1));

%%

[xp2, xm2, Pp, Pm, K]= kalman_discrete_simon(A, B, C, [], u, y, [], [], [], [], toiteration);

%%

Kvec112= 0;
Kvec212= 0;
Kvec312= 0;
Pvec112= 0;
Pvec222= 0;
Pvec332= 0;

for ii=1:toiteration
    Kvec112= [Kvec112; K(1,1,ii)];
    Kvec212= [Kvec212; K(2,1,ii)];
    Kvec312= [Kvec312; K(3,1,ii)];
    Pvec112= [Pvec112; Pm(1,1,ii); Pp(1,1,ii)];
    Pvec222= [Pvec222; Pm(2,2,ii); Pp(2,2,ii)];
    Pvec332= [Pvec332; Pm(3,3,ii); Pp(3,3,ii)];
end

figure;
hist(y,toiteration/50);
title('measurements');

figure;
subplot(1,3,1)
plot(1:toiteration-1, Kvec11(3:toiteration+1), 'b', 1:toiteration-1, Kvec112(3:toiteration+1), '--r')
title('Kalman Matrix K[1][1]');
legend('not observable', 'observable')

%figure;
subplot(1,3,2)
plot(1:toiteration-1, Kvec21(3:toiteration+1), 'b', 1:toiteration-1, Kvec212(3:toiteration+1), '--r')
title('Kalman Matrix K[2][1]');
legend('not observable', 'observable')

%figure;
subplot(1,3,3)
plot(1:toiteration-1, Kvec31(3:toiteration+1), 'b', 1:toiteration-1, Kvec312(3:toiteration+1), '--r')
title('Kalman Matrix K[3][1]');
legend('not observable', 'observable')
 
figure;
subplot(1,3,1)
plot(1:toiteration, xp(1,1:toiteration), 'b', 1:toiteration, xp2(1,1:toiteration), '--r', 1:toiteration, zeros(size(xp,2),1), ':g')
title('Zustand x posteriori x[1]');
legend('not observable', 'observable')

%figure;
subplot(1,3,2)
plot(1:toiteration, xp(2,1:toiteration), 'b', 1:toiteration, xp2(2,1:toiteration), '--r', 1:toiteration, zeros(size(xp,2),1), ':g')
title('Zustand x posteriori x[2]');
legend('not observable', 'observable')

%figure;
subplot(1,3,3)
plot(1:toiteration, xp(3,1:toiteration), 'b', 1:toiteration, xp2(3,1:toiteration), '--r', 1:toiteration, zeros(size(xp,2),1), ':g')
title('Zustand x posteriori x[3]');
legend('not observable', 'observable')

figure;
subplot(1,3,1)
plot(1:2*toiteration-1, Pvec11(3:2*toiteration+1), 'b', 1:2*toiteration-1, Pvec112(3:2*toiteration+1), '--r')
title('Kovarianzmatrix P[1][1]');
legend('not observable', 'observable')

%figure;
subplot(1,3,2)
plot(1:2*toiteration-1, Pvec22(3:2*toiteration+1), 'b', 1:2*toiteration-1, Pvec222(3:2*toiteration+1), '--r')
title('Kovarianzmatrix P[2][2]');
legend('not observable', 'observable')

%figure;
subplot(1,3,3)
plot(1:2*toiteration-1, Pvec33(3:2*toiteration+1), 'b', 1:2*toiteration-1, Pvec332(3:2*toiteration+1), '--r')
title('Kovarianzmatrix P[3][3]');
legend('not observable', 'observable')


%%

figure;
plot(Pvec112(1:2*toiteration,1));

%%

figure
plot(xp2(1,1:toiteration), 'b')
hold on
plot(y(1:toiteration), '--r')
hold off;

%%
% Messung von Position und Beschleunigung
% nur um zu testen, ob auch 2 Messungen möglich sind

C= [1 0 0; 0 0 1];

%%

y= [1 * y, y / 10];

%%

[xp3, xm3, Pp, Pm, K]= kalman_discrete_simon(A, B, C, [], u, y, [], [], [], [], toiteration);

%%

figure;
subplot(1,3,1)
plot(1:toiteration, xp3(1,1:toiteration), 'b', 1:toiteration, xp2(1,1:toiteration), '--r', 1:toiteration, zeros(size(xp,2),1), ':g')
title('Zustand x posteriori x[1]');
legend('observable + acc. measured', 'observable')

subplot(1,3,2)
plot(1:toiteration, xp3(2,1:toiteration), 'b', 1:toiteration, xp2(2,1:toiteration), '--r', 1:toiteration, zeros(size(xp,2),1), ':g')
title('Zustand x posteriori x[2]');
legend('observable + acc. measured', 'observable')

%figure;
subplot(1,3,3)
plot(1:toiteration, xp3(3,1:toiteration), 'b', 1:toiteration, xp2(3,1:toiteration), '--r', 1:toiteration, zeros(size(xp,2),1), ':g')
title('Zustand x posteriori x[3]');
legend('observable + acc. measured', 'observable')


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
%
%% TODOs
% # improve documentation
% # use D or delete the parameter
% # inside the script are a few TODOs
%
%% <<AuthorTag_DG/>>
%% References
%
% # Dan Simon: Optimal State Estimation - Kalman, H$\infty$, and Nonlinear
% Approaches, John Wiley & Sons, 2006. 
%


