%% Syntax
%       [params]= setAM1params(D)
%       
%% Description
% |[params]= setAM1params(D)| sets default parameter values of AM1 model.
% The values and units are taken out of ref. 3: Rincon et al. (see table
% 1, page 3). Paramter k4 (Yield coefficient for methane production) is
% taken out of ref. 1: Bernard et al. (table 5, page 22). 
%
%%
% @param |D| : dilution rate measured in 1/days. double scalar
%
%%
% @return |params| : struct containing the parameters of the anaerobic
% model AM1. 
%
%% Example
%
%

setAM1params(0.9)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
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
% <a href="matlab:doc('biogas_scripts/am1ode4_discrete')">
% biogas_scripts/AM1ode4_discrete</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('biogas_scripts/am1ode4_vars')">
% biogas_scripts/AM1ode4_vars</a>
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
%% TODOs
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
% </ol>
% </html>
%


