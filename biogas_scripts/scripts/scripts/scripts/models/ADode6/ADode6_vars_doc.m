%% Syntax
%       [Y_a, D_a, Y_m, D_m, k_g, r_g, cH, H_a, f_a, f_m]= ADode6_vars(x,
%       u, p)  
%       
%% Description
% |[Y_a, D_a, Y_m, D_m, k_g, r_g, cH, H_a, f_a, f_m]= ADode6_vars(x, u, p)|
% calculates the variables of the AD ode6 model for the given state, input
% and parameter vector. 
% 
%%
% @param |x| : a state vector, double. 6 dim.
%
%%
% @param |u| : an input vector, double. 2 dim.
%
%%
% @param |p| : parameter vector, struct, can be created by
% <setadode6params.html setADode6params> 
%
%%
% @return |Y_a| : $$Y_a := y_{vf}^a + y_{co2}^a + \frac{1}{y_s^a}$$
%
%%
% @return |D_a| : $$D_a := \delta \cdot D + k_{da}$$
%
%%
% @return |Y_m| : $$Y_m := y_{ch4}^m + y_{co2}^m + \frac{1}{y_s^m}$$
%
%%
% @return |D_m| : $$D_m := \delta \cdot D + k_{dm}$$
%
%%
% @return |k_g| : $$k_g := \frac{ S_v \cdot V }{ C_{co2} \cdot V_g }$$
%
%% Example
%
%

x= ones(6, 1);
u= ones(2, 1);

[Y_a, D_a, Y_m, D_m, k_g, r_g, cH, H_a, f_a, f_m]= ADode6_vars(x, u, setADode6params(0.9))

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
% <a href="matlab:doc('biogas_scripts/adode6')">
% biogas_scripts/ADode6</a>
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
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_scripts/setadode6params')">
% biogas_scripts/setADode6params</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('biogas_scripts/am1ode4')">
% biogas_scripts/AM1ode4</a>
% </html>
%
%% TODOs
% # improve documentation
% # check if max roots really always returns the correct solution for cH
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


