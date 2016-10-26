%% Syntax
%       getRegionOfAttraction(plant_id, equilibrium)
%       getRegionOfAttraction(plant_id, equilibrium, lenGenomSubstrate)
%       getRegionOfAttraction(plant_id, equilibrium, lenGenomSubstrate,
%       feed_steps) 
%       [grid, fit_array]= getRegionOfAttraction(...)
%       
%% Description
% |getRegionOfAttraction(plant_id, equilibrium)| plots the region of
% attraction of teh given |equilibrium| which must belong to the given
% plant's ID |plant_id|. The function must be called in the folder of the
% model. As default the first two substrates are changed between
% |substrate_network_min| and |substrate_network_max| with step size 5
% m³/d. From the equilibria of these substrate feeds simulations are
% started with the substrate feed of the |equilibrium|. The achieved
% fitness value then is plotted. 
%
% The volumeflow source and the initial state of the model must be set to
% file. 
%
% Results are saved in the file 'results_RoA.mat'. 
%
%%
% @param |plant_id| : ID of the plant, char.
%
%% <<equilibrium/>>
%
%%
% @return |grid| : 
%
%%
% @return |fit_array| : 
%
%%
% @param |lenGenomSubstrate| : number of steps in substrate feed of
% |equilibrium|, scalar integer. 
%
%%
% @param |feed_steps| : double vector with number of components equal to
% number of substrates. Must contain two values not NaN, the rest NaN. The
% two values define the step size of the grid defined by
% |substrate_network_min| and |substrate_network_max|. Default: the first
% two substrates: 5 m³/d. 
%
%% Example
%
%

cd( fullfile( getBiogasLibPath(), 'examples/nmpc/Gummersbach' ) );

load('equilibrium_gummersbach_optimum.mat')

%[grid, fit_array]= getRegionOfAttraction('gummersbach', equilibrium)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_equilibrium">
% biogas_scripts/is_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/load_biogas_mat_files">
% biogas_scripts/load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/load_file">
% biogas_scripts/load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/get_initstate_outof_equilibrium">
% biogas_scripts/get_initstate_outof_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/get_volumeflow_outof_equilibrium">
% biogas_scripts/get_volumeflow_outof_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/createvolumeflowfile">
% biogas_scripts/createvolumeflowfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_optimization/simbiogasplantbasic">
% biogas_optimization/simBiogasPlantBasic</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% -
%
%% TODOs
% # improve documentation 
% # add code documentation
% # add an example
% # make todos
%
%% <<AuthorTag_DG/>>


