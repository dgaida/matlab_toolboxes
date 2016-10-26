%% Syntax
%       equilibrium= getEquilibriumFromFiles(plant_id)
%
%% Description
% |equilibrium= getEquilibriumFromFiles(plant_id)| determines |equilibrium|
% out of initstate_...mat and volumeflow_..._const.mat files. 
%
% In the current path must exist:
%
% * |initstate__plant_id_.mat| : the initial state of the digesters and
% hydraulic delays
% * |volumeflow_..._const.mat| : files with constant volumeflow for
% substrates and recirculation flow
%
%%
% @param |plant_id| : ID of the plant, char
%
%%
% @return |equilibrium| : struct as defined in
% <defineequilibriumstruct.html defineEquilibriumStruct>. 
%
%% Example
%
% # load initstate and volumeflow_const files for plant koeln

cd( fullfile( getBiogasLibPath(), 'examples', 'model', 'Koeln') );

getEquilibriumFromFiles('koeln')

%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_mat_files')">
% biogas_scripts/load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_file')">
% biogas_scripts/load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/defineequilibriumstruct')">
% biogas_optimization/defineEquilibriumStruct</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/savestateinequilibriumstruct')">
% biogas_optimization/saveStateInEquilibriumStruct</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% <html>
% <a href="setinitstateinworkspace.html">
% setInitStateInWorkspace</a>
% </html>
%
%% TODOs
% # improve documentation a bit
%
%% <<AuthorTag_DG/>>


