%% Syntax
%       [params]= setADode6params(D)
%       
%% Description
% |[params]= setADode6params(D)| sets default parameter values of ADode6
% model. The values and units are taken out of ref. 1: Shen et al. (see
% table 2, page 406). 
%
%%
% @param |D| : dilution rate measured in 1/days. double scalar
%
%%
% @return |params| : struct containing the parameters of the anaerobic
% model ADode6. The dilution rate inside the parameter vector is measured
% in 1/h. 
%
% The parameter vector is defined by
%
% $$params := \left(  
% \mu_{max}^a, k_{sa}, k_{da}, \mu_{max}^m, k_{sm}, k_{im}, k_{dm}, y_s^a,
% y_{vf}^a, y_{co2}^a, y_s^m, y_{ch4}^m, y_{co2}^m, k_w, k_{co2}, k_h, k_a,
% \right.
% $$
%
% $$\left.
% k_{la}, S_v, C_{co2}, C_{ch4}, \delta, D, V, V_g, P_t
% \right)^T$$
%
%% Example
%
%

setADode6params(0.9)

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
% <a href="matlab:doc('biogas_scripts/adode6')">
% biogas_scripts/ADode6</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('biogas_scripts/adode6_vars')">
% biogas_scripts/ADode6_vars</a>
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
% # maybe define the params as physValues
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


