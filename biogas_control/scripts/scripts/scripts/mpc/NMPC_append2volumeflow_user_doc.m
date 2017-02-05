%% Syntax
%       vdata= NMPC_append2volumeflow_user(vdata, u, delta)
%
%% Description
% |vdata= NMPC_append2volumeflow_user(vdata, u, delta)| appends scalar |u|
% to volumeflow variable |vdata| to get piecewise constant volumeflow. To
% get a piecewise constant signal, |u| is appended twice. Once at time |0.1
% * delta| and then at time |0.9 * delta|. 
%
%%
% @param |vdata| : volumeflow data as it is saved in
% volumeflow_..._user.mat files. So, first row is time, measured in days,
% and second row is the volumetric flowrate, measured in m³/d. double
% matrix. |vdata| may also be empty, then it is created in this file out of
% given |u|. 
%
%%
% @param |u| : double scalar with the to be added volumetric flowrate
% measured in m³/d. 
%
%%
% @param |delta| : sampling rate of the volumetric flow rate |u| saved in
% |vdata|. measured in days. 
%
%%
% @return |vdata| : changed |vdata| with added |u|.
%
%% Example
%
% # append 5 to given volumeflow
%

NMPC_append2volumeflow_user([0 0.9 1 1.9 2 2.9; 5 5 6 6 7 7], 5, 1)

%%
%
% # create new volumeflow variable out of 5 m³/d

NMPC_append2volumeflow_user([], 5, 0.5)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
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
% <a href="matlab:doc('biogas_control/nmpc_append2volumeflow_user_substratefile')">
% biogas_control/NMPC_append2volumeflow_user_substratefile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_append2volumeflow_user_sludgefile')">
% biogas_control/NMPC_append2volumeflow_user_sludgefile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_save_ctrl_strgy_fermenterflow')">
% biogas_control/NMPC_save_ctrl_strgy_FermenterFlow</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_save_ctrl_strgy_substrateflow')">
% biogas_control/NMPC_save_ctrl_strgy_SubstrateFlow</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_control/nmpc_tmrfcn')">
% biogas_control/NMPC_TmrFcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/startnmpc')">
% biogas_control/startNMPC</a>
% </html>
%
%% TODOs
% # improve documentation a little
% # check appearance of documentation
%
%% <<AuthorTag_ALSB_AKV/>>
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


