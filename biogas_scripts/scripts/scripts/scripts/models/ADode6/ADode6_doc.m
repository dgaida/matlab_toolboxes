%% Syntax
%       [xdot]= ADode6(t, x, u, deltatk, p)
%       
%% Description
% |[xdot]= ADode6(t, x, u, deltatk, p)| calculates
% 
% $$\vec{x}'(t)= \vec{f} \left( \vec{x}(t), \vec{u}(t), \vec{p} \right)$$
% 
% with
%
% $$
% \begin{tabular}{lll}
% state vector: & $\vec{x} : R \rightarrow R^n$ & $n \in N^+$\\
% input vector: & $\vec{u} : R \rightarrow R^u$ & $u \in N^+$\\
% parameter vector: & $\vec{p} \in R^p$ & $p \in N^+$\\
% time: & $t \in R$ & \\
% system function: & $\vec{f} : R^n \times R^u \times R^p \rightarrow R^n$ & 
% \end{tabular}
% $$
%
%% 
% The system function f is the anaerobic digestion model out of the paper
% given in ref. 1. 
%
%% 
% The state vector |x| is defined as:
%
% $$
% \vec{x}(t) := \left( S(t), X_a(t), V_a(t), X_m(t), C(t), P_c(t) \right)^T
% $$
%
% so here 'n= 6'
%
%%
% The input vector |u| is defined as:
%
% $$
% \vec{u}(t) := \left( S_i(t), B_{ic}(t) \right)^T
% $$
%
%
%%
% @param |t| : current time, double scalar. 
%
%%
% @param |x| : state vector, double. 6 dim.
%
%%
% @param |u| : an input vector, double. 2 dim. Can also be a matrix with
% two columns and as many rows as there are instances. 
%
%%
% @param |deltatk| : sampling time of u. The row |round(t/deltatk + 0.5)|
% is taken out of |u|.
%
%%
% @param |p| : parameter vector, struct, can be created by
% <setadode6params.html setADode6params> 
%
%%
% @return |xdot| : $\vec{x}'(t)$
%
%% Example
%
%

close all;
clear;

%% 
% init

D= 0.90;

[params]= setADode6params(D);

tend= 100;

%%
% 
S_i= 3793.827207;
B_ic= 1077.663387;

u= [S_i*ones(tend,1), B_ic*ones(tend,1)];

opt= odeset('RelTol',1e-4,'AbsTol',1e-6);%,'OutputFcn',@debugode);

x0= [15 1928.452487 4.8077 994.0616 265.299 0.24199];

%% 
% simulate

tic;

[tsim, xsim]= ode15s( @ADode6, [0:1:tend - 1], x0, opt, u, 1, params );

for ii=1:numel(x0)
  figure,plot(tsim, xsim(:,ii), 'r');
end

%% 
% calc and plot output

[Q_ch4_Q_co2, pH]= calcADode6y(xsim, u, params);

Q_ch4= Q_ch4_Q_co2(:,1);
Q_co2= Q_ch4_Q_co2(:,2);

figure, plot(Q_ch4);
ylabel('Qch4 [l/h]')

figure, plot(Q_co2);
ylabel('Qco2 [l/h]')

figure, plot(pH);
ylabel('pH')

%%

toc;

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/adode6_vars')">
% biogas_scripts/ADode6_vars</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('script_collection/isrn')">
% script_collection/isRn</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_scripts/setadode6params')">
% biogas_scripts/setADode6params</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('biogas_scripts/calcadode6_abc')">
% biogas_scripts/calcADode6_ABC</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('biogas_scripts/calcadode6y')">
% biogas_scripts/calcADode6y</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('biogas_scripts/am1ode4')">
% biogas_scripts/AM1ode4</a>
% </html>
%
%% TODOs
% # improve documentation a bit
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% Shen, S.; Premier, G.C.; Guwy, A. and Dinsdale, R.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\07 bifurcation and stability analysis of an anaerobic digestion model.pdf'', 
% biogas_scripts.getHelpPath())'))">
% Bifurcation and stability analysis of an anaerobic digestion model</a>, 
% in Nonlinear Dynamics, vol. 48(4), pp. 391-408, 2007. 
% </li>
% <li> 
% Marsili-Libelli, S.; Beni, S.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\96 Shock load modelling in the anaerobic digestion process.pdf'', 
% biogas_scripts.getHelpPath())'))">
% Shock load modelling in the anaerobic digestion process</a>, 
% in Ecological Modelling, vol. 84(1-3), pp. 215-232, 1996. 
% </li>
% </ol>
% </html>
%


