%% Syntax
%       substrate_stock= createDefaultSubstrateStock(plant_id)
%
%% Description
% |substrate_stock= createDefaultSubstrateStock(plant_id)| creates default
% substrate stock, which is all values equal to infinity. This means, that
% no substrate is bounded. 
%
%% <<plant_id/>>
%%
% @return |substrate_stock| : column vector with as many elements as there
% are substrates on the plant. All values are Inf to symbolize that no
% substrate is restricted in amount. All values in |substrate_stock| are
% measured in m³. 
%
%% Example
%
% 

createDefaultSubstrateStock('gummersbach')

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('matlab/inf')">
% matlab/Inf</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/narginchk')">
% matlab/narginchk</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant_id')">
% biogas_scripts/is_plant_id</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_mat_files')">
% biogas_scripts/load_biogas_mat_files</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_control/startnmpc')">
% biogas_control/startNMPC</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_control/change_bounds_substrate_stock')">
% biogas_control/change_bounds_substrate_stock</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_gui/gui_nmpc')">
% biogas_gui/gui_nmpc</a>
% </html>
%
%% TODOs
% # check appearance of documentation
% # maybe improve documentation a bit
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% Findeisen, R. and Allgöwer, F.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\02 An Introduction to Nonlinear Model Predictive Control.pdf'', 
% biogas_control.getHelpPath())'))">
% An Introduction to Nonlinear Model Predictive Control</a>, 
% 21st Benelux Meeting on Systems and Control, vol. 11, 2002
% </li>
% <li> 
% Gaida, D.; Sousa Brito, André Luis; Wolf, Christian; Bäck, Thomas;
% Bongards, Michael and McLoone, Seán: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\162.pdf'', 
% biogas_control.getHelpPath())'))">
% Optimal Control of Biogas Plants using Nonlinear Model Predictive Control</a>, 
% ISSC 2011, Trinity College Dublin, 2011. 
% </li>
% <li> 
% Gaida, D.; Wolf, Christian; Bäck, Thomas and Bongards, Michael: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\ThA3-01.pdf'', 
% biogas_control.getHelpPath())'))">
% Nonlinear Model Predictive Substrate Feed Control of Biogas Plants</a>, 
% 20th Mediterranean Conference on Control & Automation (MED), Barcelona,
% 2012. 
% </li>
% <li> 
% Sousa Brito, André Luis: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\Thesis_Brito_final_online.pdf'', 
% biogas_control.getHelpPath())'))">
% Optimization of full-scale Biogas Plants using Nonlinear Model Predictive Control</a>, 
% Master Thesis, Cologne University of Applied Sciences, 2011.
% </li>
% <li> 
% Venkatesan, Ashwin Kumar: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\NMPC Final Report.pdf'', 
% biogas_control.getHelpPath())'))">
% Optimization of Substrate Feed in a Biogas Plant using Non-linear Model Predictive Control</a>, 
% Master Thesis, Cologne University of Applied Sciences, 2012.
% </li>
% </ol>
% </html>
%


