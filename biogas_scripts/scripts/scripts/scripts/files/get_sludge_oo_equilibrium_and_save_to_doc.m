%% Syntax
%       sludge= get_sludge_oo_equilibrium_and_save_to(equilibrium, substrate,
%       plant) 
%       sludge= get_sludge_oo_equilibrium_and_save_to(equilibrium, substrate,
%       plant, accesstofile) 
%       sludge= get_sludge_oo_equilibrium_and_save_to(equilibrium, substrate,
%       plant, accesstofile, control_horizon) 
%       sludge= get_sludge_oo_equilibrium_and_save_to(equilibrium, substrate,
%       plant, accesstofile, control_horizon, lenGenomSubstrate) 
%       sludge= get_sludge_oo_equilibrium_and_save_to(equilibrium, substrate,
%       plant, accesstofile, control_horizon, lenGenomSubstrate, lenGenomPump) 
%
%% Description
% |sludge= get_sludge_oo_equilibrium_and_save_to(equilibrium,
% substrate, plant)| gets recirculation sludge out of equilibrium and saves it to
% volumeflow variables and saves them to files (see parameter
% |accesstofile|). If |lenGenomPump| == 1, then const files are created,
% else volumeflow_..._user.mat files are created. 
%
%% <<equilibrium/>>
%% <<substrate/>>
%% <<plant/>>
%%
% @param |accesstofile| : 
%
% * 1 : if 1, then really save the data to a file. 
% * 0 : if set to 0, then the data isn't saved to a file, but is saved to
% the base workspace (better for optimization purpose -> speed) 
% * -1 : if it is -1, then save the data not to the workspace but to the
% model workspace. In the newest MATLAB versions, from 7.11 on, it is not
% allowed anymore to save into the modelworkspace while the model is
% running. So then we save to a file using <matlab:doc('save')
% matlab/save>. In case we are running the models in parallel, then to the
% filename an integer is appended, this is the integer of the currently
% load model. 
%
%%
% @param |control_horizon| : control horizon measured in days
%
%%
% @param |lenGenomSubstrate| : number of steps of the substrate feed over
% |control_horizon|. double scalar, natural number. Must fit to |equilibrium|. 
%
%%
% @param |lenGenomPump| : number of steps of the recirculation sludge over
% |control_horizon|. double scalar, natural number. Must fit to |equilibrium|. 
%
%%
% @return |sludge| : double matrix or vector. If it is a matrix, then it is
% a matrix with nSplits rows and |lenGenomPump| columns, thus in first row
% there is the user recycle between two digesters, ... 
%
%% Example
% 
%

cd( fullfile( getBiogasLibPath(), 'examples/nmpc/Gummersbach' ) );

equilibrium= load_file('equilibrium_gummersbach_optimum.mat');

[substrate, plant]= load_biogas_mat_files('gummersbach');

%%

get_sludge_oo_equilibrium_and_save_to(equilibrium, substrate, plant, 0);

volumeflow_fermenter2nd_main_const


%%
% # Example with |lenGenomSubstrate| == 2

equilibrium= load_file('equilibrium_sunderhook_optimum.mat');

[substrate, plant]= load_biogas_mat_files('sunderhook');

get_sludge_oo_equilibrium_and_save_to(equilibrium, substrate, plant, 0, 7, 2);

% display results

volumeflow_fermenter2nd_main_const



%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc biogas_scripts/is_equilibrium">
% biogas_scripts/is_equilibrium</a>
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
% <a href="matlab:doc biogas_scripts/get_sludge_oo_equilibrium">
% biogas_scripts/get_sludge_oo_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/create_volumeflow_sludge_files">
% biogas_scripts/create_volumeflow_sludge_files</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_optimization/setnetworkfluxinworkspace">
% biogas_optimization/setNetworkFluxInWorkspace</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="matlab:doc biogas_scripts/create_volumeflow_files">
% biogas_scripts/create_volumeflow_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/createvolumeflowfile">
% biogas_scripts/createvolumeflowfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/get_initstate_dig_oo_equilibrium">
% biogas_scripts/get_initstate_dig_oo_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/get_feed_oo_equilibrium">
% biogas_scripts/get_feed_oo_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/get_feed_oo_equilibrium_and_save_to">
% biogas_scripts/get_feed_oo_equilibrium_and_save_to</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/get_initstate_outof_equilibrium">
% biogas_scripts/get_initstate_outof_equilibrium</a>
% </html>
%
%% TODOs
% # do documentation for script file
% # improve documentation a little
% # check appearance of documentation
% # add an example for lenGenomPump > 1
%
%% <<AuthorTag_DG/>>


