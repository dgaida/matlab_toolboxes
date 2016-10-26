%% Syntax
%       init_biogas_plant_mdl()
%       init_biogas_plant_mdl(isOptimModel)
%
%% Description
% |init_biogas_plant_mdl| initializes the biogas plant model created with
% the library of the 'Biogas Plant Modeling' toolbox. It is called by the
% InitFcn and LoadFcn Callback of the 'Biogas Plant Name' block. During its
% call it loads the needed mat-files and sets them in the model workspace.
% Furthermore it sets the global variables needed in the model.
%
%%
% @param |isOptimModel| : if 1, then this is the optimization model, else 0
%
%% Example
%
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_blocks/load_biogas_mat_files')">
% load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/load_file')">
% load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/get_biogas_block_params')">
% get_biogas_block_params</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/init_admparams_from_mat_file')">
% init_ADMparams_from_mat_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/set_solver')">
% biogas_scripts/set_solver</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/conv_list2cell')">
% conv_List2cell</a>
% </html>
%
% and is called by:
%
% -
%
%% See Also
%
% -
% 
%% TODOs
% # Aufräumen wenn die Funktion stabil läuft, viele alte Dinge sind
% auskommentiert, diese sollten dann gelöscht werden
% # initstate_plant_id.mat vor der Simulation im Modellpfad erstellen,
% falls noch nicht vorhanden.
% # improve documentation
%
%% <<AuthorTag_DG/>>


