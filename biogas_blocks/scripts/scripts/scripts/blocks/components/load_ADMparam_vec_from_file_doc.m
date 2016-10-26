%% Syntax
%        plant= load_ADMparam_vec_from_file(plant)
%        plant= load_ADMparam_vec_from_file(plant, silent)
%
%% Description
% |plant= load_ADMparam_vec_from_file(plant)| loads ADM param vector from file
% |adm1_param_vec__plant_id_.mat| and sets it in C# object |plant| of
% class |biogas.plant|. Sets all parameters. 
%
%% <<plant/>>
%%
% @param |silent| : 0 or 1. Default: 0.
%
% * 0 : do throw a warning when the adm1_param_vec file does not exist
% * 1 : do not throw a warning when the adm1_param_vec file does not exist
%
%%
% @return |plant| : return the object which additionally contains the set
% ADM parameters for all digesters. 
%
%% Example
% 
% 

[substrate, plant]= load_biogas_mat_files('gummersbach');

load_ADMparam_vec_from_file(plant)
 
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
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
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
% <a href="matlab:doc('save_admparams_to_mat_file')">
% save_ADMparams_to_mat_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('init_admparams_from_mat_file')">
% init_ADMparams_from_mat_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('save_admparam_vec_to_file')">
% save_ADMparam_vec_to_file</a>
% </html>
%
%% TODOs
% # improve documentation a bit
% # check appearance of documentation
% # script sollte evtl in anderen ordner
%
%% <<AuthorTag_DG/>>


