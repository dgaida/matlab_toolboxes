%% Syntax
%       [sludge]= get_sludge_oo_equilibrium(equilibrium, substrate, plant,
%       type, lenGenomSubstrate) 
%       [...]= get_sludge_oo_equilibrium(equilibrium, substrate, plant,
%       type, lenGenomSubstrate, lenGenomPump) 
%       [...]= get_sludge_oo_equilibrium(equilibrium, substrate, plant,
%       type, lenGenomSubstrate, lenGenomPump, plant_network) 
%       [...]= get_sludge_oo_equilibrium(equilibrium, substrate, plant,
%       type, lenGenomSubstrate, lenGenomPump, plant_network,
%       plant_network_max) 
%
%% Description
% |[sludge]= get_sludge_oo_equilibrium(equilibrium, substrate, plant, type,
% lenGenomSubstrate)| gets recirculation sludge out of |equilibrium|. 
%
%% <<equilibrium/>>
%% <<substrate/>>
%% <<plant/>>
%%
% @param |type| : char
%
% * 'user' : returns the recycle flow for each recirculation with as many
% values as given by |lenGenomPump|
% * 'const_first' : returns the first value of the recirculations
% * 'const_last' : returns the last value of the recirculations
%
%%
% @param |lenGenomSubstrate| : number of steps of the substrate feed over
% some horizon. double scalar, natural number. Must fit to |equilibrium|. 
%
%%
% @param |lenGenomPump| : number of steps of the recirculation sludge over
% some horizon. double scalar, natural number. Default: 1. Must fit to
% |equilibrium|. 
%
%% <<plant_network/>>
%% <<plant_network_max/>>
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

get_sludge_oo_equilibrium(equilibrium, substrate, plant, 'user', 1)

%%

get_sludge_oo_equilibrium(equilibrium, substrate, plant, 'const_first', 1)

%%

get_sludge_oo_equilibrium(equilibrium, substrate, plant, 'const_last', 1)


%%
% # Example with |lenGenomSubstrate| == 2

equilibrium= load_file('equilibrium_sunderhook_optimum.mat');

[substrate, plant]= load_biogas_mat_files('sunderhook');

%%

get_sludge_oo_equilibrium(equilibrium, substrate, plant, 'user', 2)

%%

get_sludge_oo_equilibrium(equilibrium, substrate, plant, 'const_first', 2)

%%

get_sludge_oo_equilibrium(equilibrium, substrate, plant, 'const_last', 2)


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
% <a href="matlab:doc biogas_scripts/getnumdigestersplits">
% biogas_scripts/getNumDigesterSplits</a>
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
% <a href="matlab:doc biogas_control/nmpc_append2volumeflow_user_sludgefile">
% biogas_control/NMPC_append2volumeflow_user_sludgefile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_control/nmpc_save_ctrl_strgy_fermenterflow">
% biogas_control/NMPC_save_ctrl_strgy_FermenterFlow</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/get_volumeflow_outof_equilibrium">
% biogas_scripts/get_volumeflow_outof_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/get_sludge_oo_equilibrium_and_save_to">
% biogas_scripts/get_sludge_oo_equilibrium_and_save_to</a>
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
% <a href="matlab:doc biogas_scripts/get_initstate_outof_equilibrium">
% biogas_scripts/get_initstate_outof_equilibrium</a>
% </html>
%
%% TODOs
% # do documentation for script file
% # improve documentation
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


