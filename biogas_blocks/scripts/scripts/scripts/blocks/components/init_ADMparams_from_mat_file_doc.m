%% Syntax
%        plant= init_ADMparams_from_mat_file(plant)
%
%% Description
% |plant= init_ADMparams_from_mat_file(plant)| loads ADM params from file
% |adm1_params_opt__plant_id_.mat| and sets them in C# object |plant| of
% class |biogas.plant|. It dos not set the following parameters, because
% they are defined by the substrate mix: 
%
% 'kdis', 'khyd_ch', 'khyd_pr', 'khyd_li', 'km_c4', 'km_pro', 'km_ac',
% 'km_h2' 
%
%% <<plant/>>
%%
% @return |plant| : return the object which additionally contains the set
% ADM parameters for both digesters. 
%
%% Example
% 
% # such that this example works the gummersbach model must be load

[substrate, plant]= load_biogas_mat_files('gummersbach');

init_ADMparams_from_mat_file(plant)
 
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
% <a href="matlab:doc('fitnessfindoptimalequilibrium')">
% fitnessFindOptimalEquilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/init_biogas_plant_mdl')">
% biogas_blocks/init_biogas_plant_mdl</a>
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
% <a href="matlab:doc('biogas_scripts/getplantidfrombdroot')">
% biogas_scripts/getPlantIDfrombdroot</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('save_admparams_to_mat_file')">
% save_ADMparams_to_mat_file</a>
% </html>
%
%% TODOs
% # improve example
% # check appearance of documentation
% # script sollte evtl in anderen ordner
%
%% <<AuthorTag_DG/>>


