%% Syntax
%       volumeflows= load_volumeflow_files('substrate', vol_type, substrate)
%       volumeflows= load_volumeflow_files('substrate', vol_type,
%       substrate, mypath) 
%       volumeflows= load_volumeflow_files('digester', vol_type, plant,
%       mypath, plant_network, plant_network_max) 
%
%% Description
% |volumeflows= load_volumeflow_files('substrate', vol_type, substrate)| loads
% substrate feed volumeflow_...__vol_type_.mat files and returns the
% content in the struct |volumeflows|. The files must be in the
% <matlab:doc('pwd') pwd>. 
%
%%
% @param |id| : the first parameter
%
% * 'substrate' : load substrate feed files
% * 'digester' : load sludge files, sludge is pumped between digesters
%
%%
% @param |vol_type| : type of volumeflow files to be load
%
% * 'const' : volumeflow_..._const.mat files are load
% * 'user' : volumeflow_..._user.mat files are load
% * 'random' : volumeflow_..._random.mat files are load
%
%% <<substrate/>>
%%
% @param |mypath| : path from which the files should be load from. Default:
% <matlab:doc('pwd') pwd>. 
%
%% <<plant/>>
%% <<plant_network/>>
%% <<plant_network_max/>>
%% Example
% 
%

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

[substrate, plant, ~, plant_network, ~, ~, ~, plant_network_max]= ...
  load_biogas_mat_files('gummersbach');

volumeflows= load_volumeflow_files('substrate', 'const', substrate);

disp(volumeflows)

%%

volumeflows= load_volumeflow_files('digester', 'const', plant, ...
  fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ), ...
  plant_network, plant_network_max);

disp(volumeflows)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc biogas_scripts/get_volumeflows_sludge_from">
% biogas_scripts/get_volumeflows_sludge_from</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_substrate">
% biogas_scripts/is_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_plant">
% biogas_scripts/is_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_volumeflow_type">
% biogas_scripts/is_volumeflow_type</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_plant_network">
% biogas_scripts/is_plant_network</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/get_volumeflows_from">
% biogas_scripts/get_volumeflows_from</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_gui/loaddatafromfile">
% biogas_gui/loadDataFromFile</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="matlab:doc biogas_scripts/plot_volumeflow_files">
% biogas_scripts/plot_volumeflow_files</a>
% </html>
%
%% TODOs
% # do documentation for script file
% # improve documentation a little
%
%% <<AuthorTag_DG/>>


