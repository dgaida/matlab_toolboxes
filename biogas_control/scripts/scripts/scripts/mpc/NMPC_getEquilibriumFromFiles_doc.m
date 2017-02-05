%% Syntax
%       equilibriumInit= NMPC_getEquilibriumFromFiles(plant_id, fcn,
%       control_horizon, delta) 
%       equilibriumInit= NMPC_getEquilibriumFromFiles(plant_id, fcn,
%       control_horizon, delta, tend_ss) 
%
%% Description
% |equilibriumInit= NMPC_getEquilibriumFromFiles(plant_id, fcn,
% control_horizon, delta)| gets equilibrium from files and simulates it to
% steady state. The used files are the initstate user file and the
% volumeflow_const files. To get a steady state a long simulation is done
% from this equilibrium to be sure that at the end we really are in an
% equilibrium. This final equilibrium is returned as |equilibriumInit|. 
%
%% <<plant_id/>>
%%
% @param |fcn| : ['plant_', plant_id]
%
%% <<control_horizon/>>
%% <<delta/>>
%%
% @param |tend_ss| : duration of the performed simulation measured in days.
% The default value of 750 assures, that the returned state is an
% equilibrium. If you do not want to start the NMPC from an equilibrium, maybe
% because the current feed would lead to acidification, you can also do a
% shorter simulation by specifying this parameter. 
%
%%
% @return |equilibriumInit| : initial equilibrium structure. 
%
%% Example
%
% 
%



%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_optimization/getequilibriumfromfiles')">
% biogas_optimization/getEquilibriumFromFiles</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_mat_files')">
% biogas_scripts/load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_simbiogasplantextended')">
% biogas_control/NMPC_simBiogasPlantExtended</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/getnumsteps_tc')">
% biogas_control/getNumSteps_Tc</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_create_ref_biogas_1_slave')">
% biogas_control/NMPC_create_ref_biogas_1_slave</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
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
% <a href="matlab:doc('fitness_costs')">
% fitness_costs</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('findoptimalequilibrium')">
% findOptimalEquilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_equilibrium')">
% biogas_scripts/is_equilibrium</a>
% </html>
%
%% TODOs
% # improve script
% # improve documentation
% # maybe add an example
% # cleanup code and wait until release versions of called script gets
% higher
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


