%% Syntax
%       calib_SteadyStateCalc( plant_id, method_type)
%       calib_SteadyStateCalc( plant_id, method_type, timespan)
%       calib_SteadyStateCalc( plant_id, method_type, timespan, id_read)
%       
%% Description
% |calib_SteadyStateCalc(plant_id, method_type)| gets a steady state such
% that you can start the ADM1 parameter calibration from this steady state.
% This done as follows:
%
% # In a subfolder named |steadystate| a normal simulation model of the
% biogas plant to be calibrated must exist (may also be the optimization
% model). This model is used to generate 
% the steady state. This model must have the following settings:
%
% * load substrate feeds from file with const feed
% * load recirculation between digesters from file, const flow
% * load initstate from file, user
%
% # Out of the |volumeflow_..._user.mat| files for the substrates and recirculations
% between digesters |volumeflow_..._const.mat| files are generated, depending 
% on the parameter |method_type| calling
% <create_volumeflow_const_outof_user_substrate.html 
% create_volumeflow_const_outof_user_substrate> and
% <create_volumeflow_const_outof_user_digester.html
% create_volumeflow_const_outof_user_digester>, respectively. The const
% files are created in the current folder and in the subfolder
% |steadystate|. 
% # The |initstate__plant_id_.mat| file is copied from the current folder
% into the subfolder |steadystate|. 
% # The model inside the subfolder |steadystate| is simulated for 500 days,
% see the parameter |timespan| and it is assured, that the final state is
% saved calling <matlab:doc('setsavestateofadm1blocks')
% setSaveStateofADM1Blocks>. 
% # The new |initstate__plant_id_.mat| file is copied back into the current
% folder. 
% # The following files are created
%
% * |digester_state_min/max__plant_id_.mat| out of the new
% |initstate__plant_id_.mat| file, both min/max files are 
% equal to the initstate, calling <matlab:doc('createdigesterstateminmax')
% createDigesterStateMinMax>. 
% * |substrate_network_min/max__plant_id_.mat| out of the const substrate
% feed, min and max are set to the constant substrate feed, calling
% <matlab:doc('biogas_control/nmpc_load_substrateflow')
% biogas_control/NMPC_load_SubstrateFlow>.
% * |plant_network_min/max__plant_id_.mat| out of the const recirculation
% flow, min and max are set to the constant recirculation between the
% digesters, calling <matlab:doc('biogas_control/nmpc_load_fermenterflow')
% biogas_control/NMPC_load_FermenterFlow>.
%
%%
% @param |plant_id| : char with the id of the simulation model of the
% biogas plant. The plant's id is defined in the structure |plant| and has 
% to be set in the simulation model, which is
% <matlab:doc('develop_model_stepbystep') created> 
% using the toolbox's library. 
%
%%
% @param |method_type| : char defining which values out of the
% |volumeflow_..._user.mat| files are used to create the values in the
% |volumeflow_..._const.mat| files. 
% 
% * 'last' : last known input from the |volumeflow_'substrate_id'_user.mat| 
% is used to create a constant substrate feed file 
% |volumeflow_'substrate_id'_const.mat| to calculate the initial state of
% the plant.
% * 'mean' : the mean value of the |volumeflow_'substrate_id'_user.mat| 
% is used to create a constant substrate feed file 
% |volumeflow_'substrate_id'_const.mat| to calculate the initial state of
% the plant.
% * 'median' : the median value of the |volumeflow_'substrate_id'_user.mat| 
% is used to create a constant substrate feed file 
% |volumeflow_'substrate_id'_const.mat| to calculate the initial state of
% the plant.
%
% The same applies to the recirculation sludge between the digesters.
% Their volumeflow_..._user files are also read and written to
% volumeflow_..._const files as defined by the argument |method_type|. 
%
%%
% @param |timespan| : double scalar defining the simulation period in days.
% It should be large enough such that the model can get to its steady
% state. Default: 500 (days).
%
%%
% @param |id_read| : select the id for the |volumeflow_..._user.mat| files; e.g.
% |volumeflow_bullmanure_user_1.mat|. If empty, then just
% |volumeflow_..._user.mat| files are read. double scalar integer >= 1. 
%
% The same applies to the recirculation sludge between the digesters.
%
%% Example
%
% |calib_SteadyStateCalc( 'gummersbach', 'last', 700, 1 )|
%                      
% |calib_SteadyStateCalc( 'gummersbach', 'mean', 500, [] )|
% 
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc load_biogas_system">
% load_biogas_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc setsavestateofadm1blocks">
% setSaveStateofADM1Blocks</a>
% </html>
% ,
% <html>
% <a href="matlab:doc close_biogas_system">
% close_biogas_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc createdigesterstateminmax">
% createDigesterStateMinMax</a>
% </html>
% ,
% <html>
% <a href="create_volumeflow_const_outof_user_substrate.html">
% create_volumeflow_const_outof_user_substrate</a>
% </html>
% ,
% <html>
% <a href="create_volumeflow_const_outof_user_digester.html">
% create_volumeflow_const_outof_user_digester</a>
% </html>
% ,
% <html>
% <a href="matlab:doc load_biogas_mat_files">
% load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_control/nmpc_load_substrateflow">
% biogas_control/NMPC_load_SubstrateFlow</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_control/nmpc_load_fermenterflow">
% biogas_control/NMPC_load_FermenterFlow</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/save">
% matlab/save</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/sim">
% matlab/sim</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/copyfile">
% matlab/copyfile</a>
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
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
% ,
% <html>
% <a href="matlab:doc validatestring">
% matlab/validatestring</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="startadmparamscalibration.html">
% startADMparamsCalibration</a>
% </html>
%
%% See Also
%
% <html>
% <a href="calib_biogasplantparams.html">
% calib_BiogasPlantParams</a>
% </html>
% 
%% TODOs
% # check appearance of documentation
% # make an working example
%
%% <<AuthorTag_ALSB/>>


