%% Syntax
%       substrate_feed= get_feed_oo_equilibrium_and_save_to(equilibrium, substrate,
%       plant) 
%       substrate_feed= get_feed_oo_equilibrium_and_save_to(equilibrium, substrate,
%       plant, accesstofile) 
%       substrate_feed= get_feed_oo_equilibrium_and_save_to(equilibrium, substrate,
%       plant, accesstofile, control_horizon) 
%       substrate_feed= get_feed_oo_equilibrium_and_save_to(equilibrium, substrate,
%       plant, accesstofile, control_horizon, lenGenomSubstrate) 
%       [substrate_feed, u_vflw]= get_feed_oo_equilibrium_and_save_to(...) 
%
%% Description
% |substrate_feed= get_feed_oo_equilibrium_and_save_to(equilibrium,
% substrate, plant)| gets substrate feed out of equilibrium and saves it to
% volumeflow variables and saves them to file (see parameter
% |accesstofile|). If |lenGenomSubstrate| == 1 (default), then const files
% are created, else volumeflow_..._user files. 
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
% @param |control_horizon| : control horizon, measured in days
%
%%
% @param |lenGenomSubstrate| : number of steps of the substrate feed over
% |control_horizon|. double scalar, natural number. Must fit to |equilibrium|. 
%
%%
% @return |substrate_feed| : total (for all digesters as a sum) volumeflow
% for each substrate. Can be a matrix (|type == 'user'|) or a vector, for
% |type| being the other two choices. If |type| is 'user', then it is a
% matrix with n_substrate rows and |lenGenomSubstrate| columns, thus in
% first row there is the user substrate feed of the first substrate, ...
%
%%
% @return |u_vflw| : matrix with as many rows as there are number of
% substrates * |lenGenomSubstrate| and as many columns as there are number
% of columns (if |type| == 'user'). If |type| is one of the 'const', then it
% has as many rows as there are substrates, number of columns stays
% unchanged. If |type| == 'const_first', the substrate values are the
% first, else the last over the control horizon. 
%
%% Example
% 
% # Example with |lenGenomSubstrate| == 1

cd( fullfile( getBiogasLibPath(), 'examples/nmpc/Gummersbach' ) );

equilibrium= load_file('equilibrium_gummersbach_optimum.mat');

[substrate, plant]= load_biogas_mat_files('gummersbach');

%%

get_feed_oo_equilibrium_and_save_to(equilibrium, substrate, plant, 0);

% display results

volumeflow_grass_const

volumeflow_maize_const

volumeflow_manure_const


%%
% # Example with |lenGenomSubstrate| == 2

equilibrium= load_file('equilibrium_sunderhook_optimum.mat');

[substrate, plant]= load_biogas_mat_files('sunderhook');

get_feed_oo_equilibrium_and_save_to(equilibrium, substrate, plant, 0, 7, 2);

% display results

volumeflow_bullmanure_user

volumeflow_grass_user

volumeflow_greenrye_user

volumeflow_maize1_user

volumeflow_oat_user

volumeflow_silojuice_user

volumeflow_stiffmanure_user



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
% <a href="matlab:doc biogas_scripts/get_feed_oo_equilibrium">
% biogas_scripts/get_feed_oo_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/create_volumeflow_files">
% biogas_scripts/create_volumeflow_files</a>
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
% <a href="matlab:doc biogas_scripts/get_sludge_oo_equilibrium">
% biogas_scripts/get_sludge_oo_equilibrium</a>
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
%
%% <<AuthorTag_DG/>>


