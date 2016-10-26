%% Syntax
%       [Q_ch4_Q_co2, pH]= calcADode6y(xsim, u, p)
%       
%% Description
% |[Q_ch4_Q_co2, pH]= calcADode6y(xsim, u, p)| calculates:
%
% $$\vec{y}(t)= \vec{h} \left( \vec{x}_{sim}(t), \vec{u}(t), \vec{p} \right)$$
%
% with
%
% $$\vec{y}(t) := \left( Q_{ch4}(t), Q_{co2}(t), pH(t) \right)^T$$
%
%%
% @param |xsim| : state vector matrix, double. 6 columns. each row contains
% one state. 
%
%%
% @param |u| : an input row vector, double. 2 dim. Or a matrix with 2
% columns and as many rows as has |xsim|. Otherwise a warning is thrown,
% see TODO. 
%
%%
% @param |p| : parameter vector, struct, can be created by
% <setadode6params.html setADode6params> 
%
%%
% @return |Q_ch4_Q_co2| : methane production in [l/h] and carbon dioxide
% production in [l/h]. Is a matrix with 2 columns and as many rows as has
% |xsim|.
%
%%
% @return |pH| : pH value. double column vetor with as many rows as has
% |xsim|.
%
%% Example
%
%

x= repmat([15 1928.452487 4.8077 994.0616 265.299 0.24199], 4, 1) + ...
          [1 .* randn(4, 5), 0.001 .* randn(4, 1)];

S_i= 3793.827207;
B_ic= 1077.663387;

u= [S_i, B_ic; S_i/8, B_ic];

p= setADode6params(0.9);

[Q_ch4_Q_co2, pH]= calcADode6y(x, u, p);

Q_ch4= Q_ch4_Q_co2(:,1);
Q_co2= Q_ch4_Q_co2(:,2);

disp('Q_ch4 [l/h]')
disp(Q_ch4)

disp('Q_co2 [l/h]')
disp(Q_co2)

disp('pH')
disp(pH)

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
% <a href="matlab:doc('biogas_scripts/adode6')">
% biogas_scripts/ADode6</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('biogas_scripts/am1ode4')">
% biogas_scripts/AM1ode4</a>
% </html>
%
%% TODOs
% # improve documentation a little bit
% # see TODO inside the file
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


