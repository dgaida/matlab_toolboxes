%% Syntax
%       [p_values, p_ids]= get_ADM_params_out_of_file(plant)
%       [p_values, p_ids]= get_ADM_params_out_of_file(plant_id)
%       
%% Description
% |[p_values, p_ids]= get_ADM_params_out_of_file(plant)| gets ADM params
% out of adm1_params_opt_....mat file. It reads in the file and returns the
% the contained parameter values as vector |p_values| and their 'names'
% ('p1', 'p2', ...) in the cell array |p_ids| for all digesters. The object
% |plant| is not needed by this function, so it will not be load, if the
% parameter |plant_id| is passed. 
%
%% <<plant/>>
%% <<plant_id/>>
%%
% @return |p_values| : vector of ADM1 parameters. The first values are of
% the first digester, then the second, ... digester follows. 
%
%%
% @return |p_ids| : 'names' of ADM parameters ('p1', 'p2', ...). Cell array
% of strings: cellstr. 
%
%% Example
%
%

cd( fullfile( getBiogasLibPath(), 'examples/nmpc/Gummersbach' ) );

%plant= load_biogas_mat_files('gummersbach', [], 'plant');

[p_values, p_ids]= get_ADM_params_out_of_file('gummersbach');

disp(p_values)

disp(p_ids)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc biogas_scripts/load_file">
% biogas_scripts/load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/is_plant">
% script_collection/is_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/fieldnames">
% matlab/fieldnames</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_optimization/simbiogasplantextended">
% biogas_optimization/simBiogasPlantExtended</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc biogas_calibration">
% biogas_calibration</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/load_biogas_mat_files">
% biogas_scripts/load_biogas_mat_files</a>
% </html>
%
%% TODOs
% # improve documentation a little
% # check appearance of documentation
% # check script
% # maybe move to biogas_calibration toolbox
% # s. init_ADMparams_from_mat_file, wird diese funktion hier ernsthaft
% benötigt??? vermutlich ja, aber deutlich verändern bzw. mit anderen
% funktionen abstimmen
%
%% <<AuthorTag_DG/>>


