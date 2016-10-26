%% Syntax
%       [A, B, C]= calcAM1_ABC(x, p)
%       [A]= calcAM1_ABC(x, p, 'A')
%       [B]= calcAM1_ABC(x, p, 'B')
%       [C]= calcAM1_ABC(x, p, 'C')
%       
%% Description
% |[A, B, C]= calcAM1_ABC(x, p)| calculates matrices A, B, C of
% linearized AM1 model <matlab:doc('am1ode4') AM1ode4>. 
%
%%
% @param |x| : state vector of the AM1 model. The state vector
% is a 4dim vector. 
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

p= setAM1params(0.9);

[A, B, C]= calcAM1_ABC(x, p);

disp('A')
disp(A)

disp('B')
disp(B)

disp('C')
disp(C)

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
% <a href="matlab:doc('biogas_scripts/calcam1_abc_discrete')">
% biogas_scripts/calcAM1_ABC_discrete</a>
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
% # check and improve documentation
% # maybe make a better example
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


