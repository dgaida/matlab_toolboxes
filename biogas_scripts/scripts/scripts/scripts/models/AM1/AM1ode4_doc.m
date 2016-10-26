%% Syntax
%       [xdot]= AM1ode4(t, x, u, deltatk, p)
%       
%% Description
% |[xdot]= AM1ode4(t, x, u, deltatk, p)| is an implementation of the
% anaerobic digestion model AM1 containing 4 ODEs. 
%
%%
% The function 'AM1ode4' calculates
% 
% $$\vec{x}'(t)= \vec{f} \left( \vec{x}(t), \vec{u}(t), \vec{p} \right)$$
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
% \vec{x}(t) := \left( S1(t), X1(t), S2(t), X2(t) \right)^T
% $$
%
% so here 'n= 4'
%
%%
% The input vector 'u' is defined as:
%
% $$
% \vec{u}(t) := \left( S1,in(t), S2,in(t) \right)^T
% $$
%
%%
% @param |t| : current time. double scalar. 
%
%%
% @param |x| : state vector of the AM1 model. The state vector
% is a 4dim vector. 
%
%%
% @param |u| : input signals. the system has two inputs S1in and S2in, |u|
% has two columns. it must have as many rows as the time vector
% |t|/|deltatk| has max. time. 
%
%%
% @param |deltatk| : sampling time of |u|. double scalar. 
%
%%
% @param |p| : parameter struct of AM1 model. Can be generated calling
% <matlab:doc('setam1params') setAM1params>. 
%
%%
% @return |xdot| : 4 dim vector
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
x0= [2 0.001 15.9401 0.0076];

%% simulate

tic;

[tsim, xsim]= ode15s( @AM1ode4, [0:1:tend - 1], x0, opt, u, 1, params );

for ii=1:numel(x0)
  figure,plot(tsim, xsim(:,ii), 'r');
end

%% calc and plot output

[Q_ch4]= calcAM1y(xsim, params);

figure,plot(Q_ch4);
ylabel('mmol/l/d')

%%

for t=1:size(xsim,1)
    
  %%
  
  x= xsim(t,:);

  [A, B, C]= calcAM1_ABC(x, params);
  
  r= rank ( obsv( A, C ) );

  if r < size(A, 1)
    warning('system:notobservable', ...
            'the system is not observable: rank (%i) < %i', r, size(A, 1));
  end

end

toc;

%%
% diese Betrachtung gilt für C= [1 0 0 0], d.h. nur S1 wird gemessen, damit
% sind zwei Zustandsgrößen nicht beobachtbar, da r= 2. um herauszufinden ob
% diese nicht beobachtbaren zustände stabil sind, wird das System einer
% Ähnlichkeitstransformation unterworfen, welche die Matrix in
% Diagonalgestalt bringt (ist möglich wenn alle Eig. von A unterscheidlich
% sind, bzw. alle EigVektoren lin. unabhängig) 
%
% HINWEIS!!!!!!!!!!!!
%
% Besser die Funktion obsvf nutzen, s.u. MATLAB Doku nachlesen was diese
% Funktion macht und wie diese funktioniert!
%
%%
% Transformation auf Diagonalform. s. Unbehauen S. 36 und Lunze S. 108
[V, D]= eig(A);

%%
% da determinante der Eigenvektormatrix ungleich 0 ist, sind die
% Eigenvektoren linear unabhängig, damit kann die Matrix in Diagonalgestalt
% gebracht werden, obwohl 2 Eigenwerten fast gleich sind...?
det(V)

%%
% Transformationsvorschrift:

As= V^-1 * A * V
Bs= V^-1 * B
Cs= C * V

%%
% die letzte Zustandsvektorkomponente in xs= V * x ist weder Beobachtbar
% noch steuerbar, da B und C für diese Komponente 0 sind. Da Eigenwert zu
% dieser Komponenete in A allerdings negativ ist, ist diese Komponente
% zumindest detektierbar.
% http://en.wikipedia.org/wiki/Observability
%
% die erste Zustandsvektor komponente ist ebenfalls nicht beobachtbar aber
% steuerbar, da Eigenwert von A ebenfalls negativ, in jedem Fall
% detektierbar aber prinzipiell auch stabiliersbar falls es nötig wäre, ist
% es aber nicht, da schon stabil.
% 
% Damit ist es zumindest möglich die anderen beiden
% Zustandsvektorkomponenten 
%

[Abar,Bbar,Cbar,T,k]= obsvf(A,B,C)

%%
% system is completely controllable

rc= rank ( ctrb( A, B ) )

% if it would not, then use this...

%[Abar,Bbar,Cbar,T,k]= ctrbf(A,B,C)

%%



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
% <a href="matlab:doc('biogas_scripts/am1ode4_discrete')">
% biogas_scripts/AM1ode4_discrete</a>
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
% # check and improve documentation
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
% <li> 
% Steyer, J.P.; Bouvier, J.C.; Conte, T.; Gras, P.; Sousbie, P.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\02 Evaluation of a four year experience with a fully instrumented ad process.pdf'', 
% biogas_scripts.getHelpPath())'))">
% Evaluation of a four year experience with a fully instrumented anaerobic digestion process</a>, 
% Water Science and Technology, vol. 45, no. 4-5, pp. 495-502, 2002. 
% </li>
% <li> 
% Benyahia, B.; Sari, T.; Cherki, B.; Harmand, J.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\12 Bifurcation and stability analysis of a two step model for monitoring AD processes.pdf'', 
% biogas_scripts.getHelpPath())'))">
% Bifurcation and stability analysis of a two step model for monitoring anaerobic digestion processes</a>, 
% Journal of Process Control, 22, pp. 1008-1019, 2012. 
% </li>
% </ol>
% </html>
%


