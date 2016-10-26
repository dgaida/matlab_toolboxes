%% Syntax
%       set_nObjectives_in_fitness_params(plant_id, method)
%       set_nObjectives_in_fitness_params(plant_id, method, folders)
%       set_nObjectives_in_fitness_params(plant_id, method, folders,
%       nMObjectives) 
%
%% Description
% |set_nObjectives_in_fitness_params(plant_id, method)| sets nObjectives in
% fitness_params xml file according to given optimization |method|. If
% |method| is a multi-objective optimization method then nObjectives is set
% to 2 (or |nMObjectives|) else to 1. This value is saved in the
% fitness_params xml file of the given |plant_id|. The files in the current
% and parent folder are changed (the parameter |folders|). 
% If one of the files does not exist, then an error is thrown. 
%
%% <<plant_id/>>
%% <<opt_method/>>
%%
% @param |folders| : folders in which the fitness_params files are changed.
% cellstring. Default: {'..', []}, that means pwd and parent directory. If
% the fitness_params file does not exist in one of the folders, the file in
% the config_mat folder is load and saved in the given folder. 
%
%%
% @param |nMObjectives| : in case a multi-objective optimization method is
% passed as |method|, then you can specify here the number of objectives.
% If a SO method is passed, this parameter has no effect. Default: 2. Note:
% at the moment a number of objectives different then 2 is not yet
% supported by the toolbox. 
%
%% Example
%
% 

set_nObjectives_in_fitness_params('gummersbach', 'CMAES', {pwd}, 3)

%%

set_nObjectives_in_fitness_params('gummersbach', 'SMS-EGO', {pwd}, 3)

delete('fitness_params_gummersbach.xml');

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_mat_files')">
% biogas_scripts/load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('optimization_tool/is_moa')">
% optimization_tool/is_moa</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant_id')">
% biogas_scripts/is_plant_id</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/dispmessage')">
% script_collection/dispMessage</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/exist')">
% matlab/exist</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_control/startnmpc')">
% biogas_control/startNMPC</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/findoptimalequilibrium')">
% biogas_optimization/findOptimalEquilibrium</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_gui/gui_nmpc')">
% biogas_gui/gui_nmpc</a>
% </html>
%
%% TODOs
% # improve documentation a little
% # make TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


