%% Syntax
%       [xkp1]= AM1ode4_discrete(tk, xk, uk, deltatk, p)
%       
%% Description
% |[xkp1]= AM1ode4_discrete(tk, xk, uk, deltatk, p)| is an implementation
% of the anaerobic digestion model AM1 containing 4 ODEs. 
%
%%
% The function 'AM1ode4_discrete' calculates
% 
% $$\vec{x}_{k+1}= \vec{f} \left( \vec{x}_k, \vec{u}_k, \vec{p} \right)$$
% 
% with the
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
%
% The system function f is the anaerobic digestion model out of the paper
% in ref. 1: Bernard et al. 
%
%% 
% The state vector 'x' is defined as:
%
% $$
% \vec{x}_k := \left( S1_k, X1_k, S2_k, X2_k \right)^T
% $$
%
% so here 'n= 4'
%
%%
% The input vector 'u' is defined as:
%
% $$
% \vec{u}_k := \left( S1,in_k, S2,in_k \right)^T
% $$
%
%%
% @param |tk| : current time. double scalar. 
%
%%
% @param |xk| : state vector of the AM1 model. The state vector
% is a 4dim vector. 
%
%%
% @param |uk| : input signals. the system has two inputs S1in and S2in, |u|
% has two columns. It may only the input at the current time, thus it is a
% vector. 
%
%%
% @param |deltatk| : sampling time of the system. double scalar. 
%
%%
% @param |p| : parameter struct of AM1 model. Can be generated calling
% <matlab:doc('setam1params') setAM1params>. 
%
%%
% @return |xkp1| : 4 dim vector: $\vec{x}_{k+1}$
%
%% Example
%
%
%%

close all;
clear;

%% init

D= 0.01;
D= 0.90;

[params]= setAM1params(D);

tend= 100;
deltatk= 1/24; % 1/2

%%
% 
S1_in= 5.8;
S2_in= 52.0;
S1_in= 2.0;
S2_in= 20.0;

%u= [S1_in*rand(tend,1), S2_in*rand(tend,1)];
u= [S1_in*ones(tend,1), S2_in*ones(tend,1)];

opt=odeset('RelTol',1e-4,'AbsTol',1e-6);%,'OutputFcn',@debugode);

x0= [0.035 0.98 0.1 0.11];
%% TODO
% Vorsicht, dieser Zustand führt zum auswaschen von X1
x0= [2 0.001 15.9401 0.0076];

%% simulate

tic;
  
%% continuous

[tsim, xsim]= ode15s( @AM1ode4, [0:1:tend - 1], x0, opt, u, 1, params );

%% discrete

xk= zeros(tend/deltatk, 4);

xk(1,:)= x0;

for iiter= 1:tend/deltatk - 1

  xk(iiter + 1, :)= AM1ode4_discrete(iiter, xk(iiter, :)', ...
                    u(round(iiter*deltatk + 0.5), :), deltatk, params)';
  
end

%%

for ii=1:numel(x0)
  figure,plot(tsim, xsim(:,ii), 'r', 0:deltatk:tend - deltatk, xk(:,ii), 'b');
end

%% calc and plot output

[Q_ch4]= calcAM1y(xk, params);

figure,plot(Q_ch4);
ylabel('mmol/l/d')

%%

ranks= zeros(size(xk,1), 1);

for t=1:size(xk,1)
    
  %%
  
  x= xk(t,:);

  [A, B, C]= calcAM1_ABC_discrete(x, deltatk, params);
  
  ranks(t)= rank ( obsv( A, C ) );

  if ranks(t) < size(A, 1)
    warning('system:notobservable', ...
            'the system is not observable: rank (%i) < %i', ranks(t), size(A, 1));
  end

end

figure, plot(ranks)

toc;



%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/am1ode4_vars')">
% biogas_scripts/AM1ode4_vars</a>
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
% <a href="matlab:doc('biogas_scripts/am1ode4')">
% biogas_scripts/AM1ode4</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('biogas_scripts/calcam1_abc')">
% biogas_scripts/calcAM1_ABC</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('biogas_scripts/setam1params')">
% biogas_scripts/setAM1params</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('biogas_scripts/calcam1_abc_discrete')">
% biogas_scripts/calcAM1_ABC_discrete</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('biogas_scripts/calcam1y')">
% biogas_scripts/calcAM1y</a>
% </html>
%
%% TODOs
% # improve documentation and example
% # improve documentation of eqs. in script
% # maybe define the params as physValues
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% Bernard, O.; Hadj-Sadok, Z.; Dochain, D.; Genovesi, A.; Steyer, J.-P.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\01 Dynamical model development and parameter identification for an anaerobic wwtp.pdf'', 
% biogas_scripts.getHelpPath())'))">
% Dynamical model development and parameter identification for an anaerobic
% wastewater treatment process</a>, 
% in Biotechnology and Bioengineering, vol. 75, pp. 424-438, 2001. 
% </li>
% <li> 
% Hess, J.; Bernard, O.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\08 Advanced dynamical risk analysis for monitoring ad process.pdf'', 
% biogas_scripts.getHelpPath())'))">
% Advanced dynamical risk analysis for monitoring anaerobic digestion process</a>, 
% pp. 1-21, 2008. 
% </li>
% <li> 
% Rincon, A.; Angulo, F.; Olivar, G.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\09 Control of an ad through normal form of fold bifurcation.pdf'', 
% biogas_scripts.getHelpPath())'))">
% Control of an anaerobic digester through normal form of fold bifurcation</a>, 
% Journal of Process Control, pp. 1-13, 2009. 
% </li>
% </ol>
% </html>
%


