%% Syntax
%        save_ADMparam_vec_to_file(plant)
%
%% Description
% |save_ADMparam_vec_to_file(plant)| loads ADM param vector from C# object
% |plant| of class |biogas.plant| and saves them in 
% |adm1_param_vec__plant_id_.mat|. 
%
%% <<plant/>>
%% Example
% 
% # such that this example works the gummersbach model must be load

[substrate, plant]= load_biogas_mat_files('gummersbach');

save_ADMparam_vec_to_file(plant)
 
delete 'adm1_param_vec_gummersbach.mat';

%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant')">
% biogas_scripts/is_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/save')">
% matlab/save</a>
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
% <a href="matlab:doc('biogas_calibration')">
% biogas_calibration</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('init_admparams_from_mat_file')">
% init_ADMparams_from_mat_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('save_admparams_to_mat_file')">
% save_ADMparams_to_mat_file</a>
% </html>
%
%% TODOs
% # maybe improve documentation a bit
% # check appearance of documentation
% # script sollte evtl in anderen ordner
%
%% <<AuthorTag_DG/>>


