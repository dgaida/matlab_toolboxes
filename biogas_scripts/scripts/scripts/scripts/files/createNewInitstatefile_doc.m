%% Syntax
%       createNewInitstatefile(plant_id)
%      
%% Description
% |createNewInitstatefile(plant_id)| creates the initial state file 
% 'initstate__plant_id_.mat' for all state-dependent blocks in the 
% biogas library, respectively in the actual model. Up to now these are
% fermenters and hydraulic delays. The latter are used in pumps which pump
% recirculated sludge between two digesters. The initstates are set to the
% default state. The file is saved in the present working directory. 
%
% The 'initstate__plant_id_.mat' file contains a structure named
% 'initstate'. For each digester there are three different types of initial
% states: 'random', 'user' and 'default'. In this function the 'user' state
% is set to the 'default' state. 
% For the hydraulic delays there are 'user' and 'default' states, both are
% set to the default state. 
%
%% <<plant_id/>>
%% Example
% 
%

createNewInitstatefile('gummersbach');

delete('initstate_gummersbach.mat');


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="load_biogas_mat_files.html">
% load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant_id')">
% biogas_scripts/is_plant_id</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/save')">
% matlab/save</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
%
% <html>
% <a href="createvolumeflowfile.html">
% createvolumeflowfile</a>
% </html>
% ,
% <html>
% <a href="createinitstatefile.html">
% createinitstatefile</a>
% </html>
%
%% TODOs
%
%
%% <<AuthorTag_DG/>>


