%% Syntax
%       [substrate_feed, u_vflw]= get_feed_oo_equilibrium(equilibrium, substrate,
%       plant, type, lenGenomSubstrate) 
%
%% Description
% |[substrate_feed]= get_feed_oo_equilibrium(equilibrium, substrate, plant,
% type, lenGenomSubstrate)| gets substrate feed out of equilibrium and sums
% it up over the digesters. 
%
%% <<equilibrium/>>
%% <<substrate/>>
%% <<plant/>>
%%
% @param |type| : char
%
% * 'user' : returns the total (for all digesters as a sum) volumeflow for
% each substrate, as many values for each substrate as is given by
% |lenGenomSubstrate|. 
% * 'const_first' : returns the first value of the total (for all digesters
% as a sum) volumeflow for each substrate
% * 'const_last' : returns the last value of the total (for all digesters
% as a sum) volumeflow for each substrate
%
%%
% @param |lenGenomSubstrate| : number of steps of the substrate feed over
% some horizon. double scalar, natural number. Must fit to |equilibrium|. 
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
% of columns (if |type| == 'user'). If it is one of the 'const', then it
% has as many rows as there are substrates, number of columns stays
% unchanged. If |type| == 'const_first', the substrate values are the
% first, else the last over the control horizon. 
%
%% Example
% 
%

cd( fullfile( getBiogasLibPath(), 'examples/nmpc/Gummersbach' ) );

equilibrium= load_file('equilibrium_gummersbach_optimum.mat');

[substrate, plant]= load_biogas_mat_files('gummersbach');

%%

get_feed_oo_equilibrium(equilibrium, substrate, plant, 'user', 1)

%%

get_feed_oo_equilibrium(equilibrium, substrate, plant, 'const_first', 1)

%%

get_feed_oo_equilibrium(equilibrium, substrate, plant, 'const_last', 1)


%%
% # Example with |lenGenomSubstrate| == 2

equilibrium= load_file('equilibrium_sunderhook_optimum.mat');

[substrate, plant]= load_biogas_mat_files('sunderhook');

%%

get_feed_oo_equilibrium(equilibrium, substrate, plant, 'user', 2)

%%

get_feed_oo_equilibrium(equilibrium, substrate, plant, 'const_first', 2)

%%

get_feed_oo_equilibrium(equilibrium, substrate, plant, 'const_last', 2)



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
% <a href="matlab:doc reshape">
% matlab/reshape</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_control/nmpc_append2volumeflow_user_substratefile">
% biogas_control/NMPC_append2volumeflow_user_substratefile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_control/nmpc_save_ctrl_strgy_substrateflow">
% biogas_control/NMPC_save_ctrl_strgy_SubstrateFlow</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/get_volumeflow_outof_equilibrium">
% biogas_scripts/get_volumeflow_outof_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/get_feed_oo_equilibrium_and_save_to">
% biogas_scripts/get_feed_oo_equilibrium_and_save_to</a>
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


