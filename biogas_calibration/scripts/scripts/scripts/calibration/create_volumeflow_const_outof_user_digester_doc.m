%% Syntax
%       create_volumeflow_const_outof_user_digester(plant_id, method_type)
%       create_volumeflow_const_outof_user_digester(plant_id, method_type,
%       id_read) 
%       
%% Description
% |create_volumeflow_const_outof_user_digester(plant_id, method_type)|
% creates |volumeflow_..._const.mat| files out of |volumeflow_..._user.mat|
% files for all recirculation between digesters for given plant |plant_id|.
% The values taken from the |volumeflow_..._user.mat| files and written 
% into the |volumeflow_..._const.mat| files are defined by |method_type|. The
% |volumeflow_..._user.mat| files are read from the current folder and the
% |volumeflow_..._const.mat| files are written to the current folder and
% the subfolder |steadystate|. 
%
%%
% @param |plant_id| : char with the id of the simulation model of the
% biogas plant. The plant's id is defined in the structure |plant| and has 
% to be set in the simulation model, which is
% <matlab:doc('develop_model_stepbystep') created> 
% using the toolbox's library. 
%
%%
% @param |method_type| : char defining which values out of the user files
% are used to create the values in the const files. 
% 
% * 'last' : last known input from the volumeflow_'digester_id'_user.mat 
% is used to create a constant recirculation file 
% volumeflow_'digester_id'_const.mat to calculate the initial state of
% the plant.
% * 'mean' : the mean value of the volumeflow_'digester_id'_user.mat 
% is used to create a constant recirculation file 
% volumeflow_'digester_id'_const.mat to calculate the initial state of
% the plant.
% * 'median' : the median value of the volumeflow_'digester_id'_user.mat 
% is used to create a constant recirculation file 
% volumeflow_'digester_id'_const.mat to calculate the initial state of
% the plant.
%
%%
% |create_volumeflow_const_outof_user_digester(plant_id, method_type,
% id_read)| 
%
%%
% @param |id_read| : select the id for the volumeflow_..._user.mat files; e.g.
% volumeflow_digester1_digester2_user_1.mat. If empty, then just
% volumeflow_..._user.mat files are read. 
%
%% Example
%
% 

cd( fullfile( getBiogasLibPath(), 'examples/calibration/Sunderhook' ) );

create_volumeflow_const_outof_user_digester('sunderhook', 'mean')



%% Dependencies
% 
% This function calls:
%
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
% <a href="matlab:doc validatestring">
% matlab/validatestring</a>
% </html>
% ,
% <html>
% <a href="matlab:doc load_biogas_mat_files">
% load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc load_file">
% load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc save">
% matlab/save</a>
% </html>
% ,
% <html>
% <a href="matlab:doc mean">
% matlab/mean</a>
% </html>
% ,
% <html>
% <a href="matlab:doc median">
% matlab/median</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="calib_steadystatecalc.html">
% calib_SteadyStateCalc</a>
% </html>
%
%% See Also
%
% <html>
% <a href="calib_biogasplantparams.html">
% calib_BiogasPlantParams</a>
% </html>
% ,
% <html>
% <a href="create_volumeflow_const_outof_user_substrate.html">
% create_volumeflow_const_outof_user_substrate</a>
% </html>
% ,
% <html>
% <a href="startadmparamscalibration.html">
% startADMparamsCalibration</a>
% </html>
% 
%% TODOs
% # check appearance of documentation, maybe improve it
% # change example to gummersbach
%
%% <<AuthorTag_ALSB/>>


