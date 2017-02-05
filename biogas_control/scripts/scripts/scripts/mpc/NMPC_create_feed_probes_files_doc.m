%% Syntax
%       NMPC_create_feed_probes_files(substrate, time)
%       NMPC_create_feed_probes_files(substrate, time, num_steps)
%
%% Description
% |NMPC_create_feed_probes_files(substrate, time)| creates
% probes_substrate_id_user/const.mat files in mpc subfolder if the 
% same files do exist in parent folder. Must be called from subfolder
% 'mpc'. 
%
% If |num_steps > 1| (control sampling time < control horizon), then
% creates 'probes_substrate_id_user.mat' files, else it creates
% 'probes_substrate_id_const.mat' files. In both files constant parameters
% are saved. Those are read out of the files
% 'probes_substrate_id_const/user_measured.mat' at the given time |time|. 
%
%% <<substrate/>>
%%
% @param |time| : current simulation time, double scalar. measured in days
%
%%
% @param |num_steps| : number of feed steps over control horizon, double
% scalar, natural number. In many scripts also called |lenGenomSubstrate|. 
%
%% Example
%
% 

cd( fullfile( getBiogasLibPath(), 'examples', 'nmpc', 'Gummersbach', 'mpc') );

%%

substrate= load_biogas_mat_files('gummersbach');

%%
% get substrate params at day 10

NMPC_create_feed_probes_files(substrate, 10);

%%
% list created file

ls('probes_*_const.mat');

%%
% clean up - assuming that probes_maize_const_measured.mat exists in the
% parent folder

delete('probes_maize_const.mat');


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/get_nearest_el_in_vec')">
% script_collection/get_nearest_el_in_vec</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/save_varname')">
% script_collection/save_varname</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_substrate')">
% biogas_scripts/is_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_file')">
% biogas_scripts/load_file</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_control/startnmpcatequilibrium')">
% biogas_control/startNMPCatEquilibrium</a>
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
% # improve documentation a bit
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


