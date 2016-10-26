%% Syntax
%       initstate= get_initstate_dig_oo_equilibrium(equilibrium, initstate)
%       get_initstate_dig_oo_equilibrium(equilibrium, initstate, plant_id)
%       get_initstate_dig_oo_equilibrium(equilibrium, initstate, plant_id,
%       id_write) 
%       
%% Description
% |initstate= get_initstate_dig_oo_equilibrium(equilibrium, initstate)| 
%
%% <<equilibrium/>>
%%
% @param |initstate| : 
%
%%
% @param |plant_id| : char with the id of the simulation model of the
% biogas plant. The plant's id is defined in the object |plant| and has 
% to be set in the simulation model, which is
% <matlab:doc('develop_model_stepbystep') created> 
% using the toolbox's library. 
%
%%
% @param |id_write| : select the id in which the *.mat files results will 
% be saved for the NMPC optimization; e.g. initstate_plant_id_1.mat. 
% If empty the standard value is []. 
%
%% Example
%
% 

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

%%

initstate= load_file('initstate_gummersbach');

[plant, plant_network]= load_biogas_mat_files('gummersbach', [], {'plant', 'plant_network'});

equilibrium= defineEquilibriumStruct(plant, plant_network);

get_initstate_dig_oo_equilibrium(equilibrium, initstate, 'gummersbach', 1)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('matlab/save')">
% matlab/save</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/fieldnames')">
% matlab/fieldnames</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_equilibrium')">
% biogas_scripts/is_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_initstate')">
% biogas_scripts/is_initstate</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_control/nmpc_save_simoptmimdata')">
% biogas_control/NMPC_save_SimOptmimData</a>
% </html>
% 
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_scripts/get_initstate_outof_equilibrium')">
% biogas_scripts/get_initstate_outof_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/createdigesterstateminmax')">
% biogas_scripts/createDigesterStateMinMax</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nonlinearmpc')">
% biogas_control/nonlinearMPC</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('defineequilibriumstruct')">
% defineEquilibriumStruct</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_mat_files')">
% biogas_scripts/load_biogas_mat_files</a>
% </html>
%
%% TODOs
% # improve documentation a little
% # check appearance of documentation
%
%% <<AuthorTag_ALSB/>>


