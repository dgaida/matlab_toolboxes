%% Syntax
%       [substratefeed, u_vflw]=
%       get_substratefeed_oo_networkflux(networkflux, n_substrate,
%       n_digester, lenGenomSubstrate)
%
%% Description
% |[substratefeed, u_vflw]= get_substratefeed_oo_networkflux(networkflux,
% n_substrate, n_digester, lenGenomSubstrate)| gets substrate feed out of
% network flux as it is saved in the equilibrium structure. 
%
%%
% @param |networkflux| : networkflux as it is saved in the equilibrium
% structure. 
%
%%
% @param |n_substrate| : number of substrates. double scalar, natural
% number. Must fit to |networkflux|. 
%
%%
% @param |n_digester| : number of digesters. double scalar, natural number.
% Must fit to |networkflux|. 
%
%%
% @param |lenGenomSubstrate| : number of steps of the substrate feed over
% some horizon. double scalar, natural number. Must fit to |networkflux|. 
%
%%
% @return |substratefeed| : total (for all digesters as a sum) volumeflow
% for each substrate. Can be a matrix or a vector. In general it is a
% matrix with |n_substrate| rows and |lenGenomSubstrate| columns, thus in
% first row there is the user substrate feed of the first substrate, ...
%
%%
% @return |u_vflw| : matrix with as many rows as there are number of
% substrates * |lenGenomSubstrate| and as many columns as there are number
% of digesters. 
%
%% Example
% 
%

cd( fullfile( getBiogasLibPath(), 'examples/nmpc/Gummersbach' ) );

equilibrium= load_file('equilibrium_gummersbach_optimum.mat');

[substrate, plant]= load_biogas_mat_files('gummersbach');

%%

n_substrate= substrate.getNumSubstratesD();
n_digester= plant.getNumDigestersD();

get_substratefeed_oo_networkflux(equilibrium.network_flux, n_substrate, n_digester, 1)


%%
% # Example with |lenGenomSubstrate| == 2

equilibrium= load_file('equilibrium_sunderhook_optimum.mat');

[substrate, plant]= load_biogas_mat_files('sunderhook');

%%

n_substrate= substrate.getNumSubstratesD();
n_digester= plant.getNumDigestersD();

get_substratefeed_oo_networkflux(equilibrium.network_flux, n_substrate, n_digester, 2)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/isrn">
% script_collection/isRn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isn">
% script_collection/isN</a>
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
% <a href="matlab:doc biogas_optimization/getsubstrateflowfromindividual">
% biogas_optimization/getSubstrateFlowFromIndividual</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/get_feed_oo_equilibrium">
% biogas_scripts/get_feed_oo_equilibrium</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="matlab:doc biogas_scripts/get_feed_oo_equilibrium_and_save_to">
% biogas_scripts/get_feed_oo_equilibrium_and_save_to</a>
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


