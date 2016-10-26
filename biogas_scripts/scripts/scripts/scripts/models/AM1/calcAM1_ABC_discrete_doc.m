%% Syntax
%       [A, B, C]= calcAM1_ABC_discrete(x, deltatk, p)
%       A= calcAM1_ABC_discrete(x, deltatk, p, 'A')
%       B= calcAM1_ABC_discrete(x, deltatk, p, 'B')
%       C= calcAM1_ABC_discrete(x, deltatk, p, 'C')
%       
%% Description
% |[A, B, C]= calcAM1_ABC(x, deltatk, p)| calculates matrices A,
% B, C of discrete AM1 model <matlab:doc('am1ode4_discrete')
% AM1ode4_discrete>. 
%
%%
% @param |x| : state vector of the AM1 model. The state vector
% is a 4dim vector. 
%
%%
% @param |deltatk| : sampling time of the system. double scalar
%
%%
% @param |p| : parameter struct of AM1 model. Can be generated calling
% <matlab:doc('setam1params') setAM1params>. 
%
%%
% @return |...| : 
%
%% Example
%
%

x= ones(4, 1);

deltatk= 1/24; % 1/2

p= setAM1params(0.9);

[A, B, C]= calcAM1_ABC_discrete(x, deltatk, p);

disp('A')
disp(A)

disp('B')
disp(B)

disp('C')
disp(C)

%%
% Example 2: Have a look, whether rank of matrix is dependent on delta tk,
% but it seems not to be

%% TODO
% Vorsicht, dieser Zustand führt zum auswaschen von X1, siehe unteres x0,
% ergibt sich aus diesem
x0= [2 0.001 15.9401 0.0076];
%x0= [2 7.61e-12 15.9394 0.0076];

ranks= zeros(100, 1);
iiter= 1;

for deltatk= 1:-0.01:0.01

  [A, B, C]= calcAM1_ABC_discrete(x0, deltatk, p);

  ranks(iiter)= rank ( obsv( A, C ) );
  
  iiter= iiter + 1;

end

plot(ranks)

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
% <a href="matlab:doc('biogas_scripts/calcam1y')">
% biogas_scripts/calcAM1y</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('biogas_scripts/setam1params')">
% biogas_scripts/setAM1params</a>
% </html>
%
%% TODOs
% # improve documentation
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


