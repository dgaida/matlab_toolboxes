%% Syntax
%       NMPC_append2volumeflow_user_sludgefile(equilibrium, substrate,
%       plant, delta, lenGenomSubstrate, plant_network, plant_network_max) 
%       NMPC_append2volumeflow_user_sludgefile(equilibrium, substrate,
%       plant, delta, lenGenomSubstrate, plant_network, plant_network_max,
%       lenGenomPump) 
%
%% Description
% |NMPC_append2volumeflow_user_sludgefile(equilibrium, substrate, plant,
% delta, lenGenomSubstrate, plant_network, plant_network_max)| gets all
% sludge volumetric flowrates out of |equilibrium| and appends it to 
% volumeflow_..._user_1.mat files. 
%
%% <<equilibrium/>>
%% <<substrate/>>
%% <<plant/>>
%%
% @param |delta| : sampling rate of the volumetric flow rate.
%
%%
% @param |lenGenomSubstrate| : number of substrate steps over the
% control horizon
%
%% <<plant_network/>>
%% <<plant_network_max/>>
%%
% @param |lenGenomPump| : number of recirculation sludge steps over the
% control horizon. Default: 1. 
%
%% Example
%
% 

[substrate, plant, plant_network, plant_network_max]= ...
  load_biogas_mat_files('gummersbach', [], ...
    {'substrate', 'plant', 'plant_network', 'plant_network_max'});

equilibrium= load_file('equilibrium_gummersbach.mat');

delta= 1;
lenGenomSubstrate= 1;

NMPC_append2volumeflow_user_sludgefile(equilibrium, substrate, ...
  plant, delta, lenGenomSubstrate, plant_network, plant_network_max);

%%
% list created file

ls('volumeflow_fermenter2nd_main_user_1.mat')

%%
% clean up

delete('volumeflow_fermenter2nd_main_user_1.mat')

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/getnumdigestersplits')">
% biogas_scripts/getNumDigesterSplits</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_sludge_oo_equilibrium')">
% biogas_scripts/get_sludge_oo_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_append2volumeflow_user')">
% biogas_control/NMPC_append2volumeflow_user</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/save_varname')">
% script_collection/save_varname</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_file')">
% biogas_scripts/load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_equilibrium')">
% biogas_scripts/is_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_substrate')">
% biogas_scripts/is_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant')">
% biogas_scripts/is_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant_network')">
% biogas_scripts/is_plant_network</a>
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
% <a href="matlab:doc('biogas_control/nmpc_tmrfcn')">
% biogas_control/NMPC_TmrFcn</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_control/nmpc_append2volumeflow_user_substratefile')">
% biogas_control/NMPC_append2volumeflow_user_substratefile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/startnmpc')">
% biogas_control/startNMPC</a>
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


