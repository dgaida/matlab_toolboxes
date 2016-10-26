%% Syntax
%        save_ADMparams_to_mat_file(plant)
%
%% Description
% |save_ADMparams_to_mat_file(plant)| loads ADM params from C# object
% |plant| of class |biogas.plant| and saves them in 
% |adm1_params_opt__plant_id_.mat|. Only gets those parameters, that are
% returned by <matlab:doc('biogas_calibration/calib_getdefaultadm1params')
% biogas_calibration/calib_getDefaultADM1params>. 
%
%% <<plant/>>
%% Example
% 
% # such that this example works the gummersbach model must be load

[substrate, plant]= load_biogas_mat_files('gummersbach');

save_ADMparams_to_mat_file(plant)
 
delete 'adm1_params_opt_gummersbach.mat';

%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/load_file')">
% biogas_scripts/load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant')">
% biogas_scripts/is_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_calibration/calib_getdefaultadm1params')">
% biogas_calibration/calib_getDefaultADM1params</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_control/nmpc_tmrfcn')">
% biogas_control/NMPC_TmrFcn</a>
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
% <a href="matlab:doc('biogas_scripts/getplantidfrombdroot')">
% biogas_scripts/getPlantIDfrombdroot</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_calibration')">
% biogas_calibration</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('init_admparams_from_mat_file')">
% init_ADMparams_from_mat_file</a>
% </html>
%
%% TODOs
% # maybe improve documentation a bit
% # improve example
% # check appearance of documentation
% # script sollte evtl in anderen ordner
%
%% <<AuthorTag_DG/>>


