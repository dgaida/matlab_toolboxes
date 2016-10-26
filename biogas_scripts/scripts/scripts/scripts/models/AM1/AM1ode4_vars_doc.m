%% Syntax
%       [mu1, mu2]= AM1ode4_vars(x, p)
%       
%% Description
% |[mu1, mu2]= AM1ode4_vars(x, p)| calculates variables of model AM1.
% Equations can be found in ref. 1 and ref. 3. 
%
%%
% @param |x| : state vector of the AM1 model. 4 dim. double vector. 
%
%%
% @param |p| : parameter struct of AM1 model. Can be generated calling
% <matlab:doc('setam1params') setAM1params>. 
%
%%
% @return |mu1| : acidogenic biomass growth rate [d^-1]
%
% mu1max * S1 / ( S1 + KS1 )
%
%%
% @return |mu2| : methanogenic biomass growth rate [d^-1]
%
% mu2max * S2 / ( S2 + KS2 + ( S2 / KI2 )^2 )
%
%% Example
%
%

x= ones(4, 1);

p= setAM1params(0.9);

[mu1, mu2]= AM1ode4_vars(x, p);

disp('mu1')
disp(mu1)
disp('mu2')
disp(mu2)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/isrn')">
% script_collection/isRn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_scripts/am1ode4')">
% biogas_scripts/AM1ode4</a>
% </html>
% ,
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
% <a href="matlab:doc('biogas_scripts/calcam1_abc_discrete')">
% biogas_scripts/calcAM1_ABC_discrete</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/calcam1y')">
% biogas_scripts/calcAM1y</a>
% </html>
%
%% See Also
% 
% -
%
%% TODOs
% # check documentation
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


