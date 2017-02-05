%% Syntax
%       num_steps= getNumSteps_Tc(control_horizon, delta)
%
%% Description
% |num_steps= getNumSteps_Tc(control_horizon, delta)| calculates number of
% possible steps of feed over the control horizon |control_horizon|. 
%
%%
% @param |control_horizon| : control horizon, measured in days. 
%
%%
% @param |delta| : control sampling time, measured in days. 
%
%%
% @return |num_steps| : number of steps over the control horizon. If it is
% 0, a warning is thrown. 
%
%% Example
%
% 
%

getNumSteps_Tc(7, 2)

%%
% throws a warning

getNumSteps_Tc(1, 2)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('matlab/fix')">
% matlab/fix</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_scripts/get_init_feed_oo_equilibrium')">
% biogas_scripts/get_init_feed_oo_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_tmrfcn')">
% biogas_control/NMPC_TmrFcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_getequilibriumfromfiles')">
% biogas_control/NMPC_getEquilibriumFromFiles</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/startnmpcatequilibrium')">
% biogas_control/startNMPCatEquilibrium</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_control/startnmpc')">
% biogas_control/startNMPC</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_gui/gui_nmpc')">
% biogas_gui/gui_nmpc</a>
% </html>
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_AKV/>>
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


