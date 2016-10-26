%% Syntax
%       setInitStateInWorkspace(equilibrium, plant, plant_network,
%       initstate_type_hydraulic_delay) 
%       setInitStateInWorkspace(equilibrium, plant, plant_network,
%       initstate_type_hydraulic_delay, accesstofile) 
%
%% Description
% |setInitStateInWorkspace(equilibrium, plant, plant_network,
% initstate_type_hydraulic_delay)| reads the initial states for digesters 
% and hydraulic delays out of |equilibrium| 
% and sets them in the model workspace of the actual load model calling 
% <matlab:doc('createinitstatefile') createinitstatefile>. 
%
%% <<equilibrium/>>
%% <<plant/>>
%% <<plant_network/>>
%%
% @param |initstate_type_hydraulic_delay| : char: 'user' or 'default'
%
% * 'user' : load the initial state for the hydraulic delays from the
% |equilibrium| struct, then it is saved in initstate....'user'
% this option is used, when we want to simulate from a very specific
% equilibrium point
% * 'default' : here the initial state for the hydraulic delays is set in
% initstate to default.
% this option is used, when we find new equilibrium points for the
% digesters, then the state of the hydraulic delays is fixed to default,
% because it doesn't (or better may not) influence the fitness of the
% simulation
%
%%
% |setInitStateInWorkspace(equilibrium, plant, plant_network, ...
%                            initstate_type_hydraulic_delay, accesstofile)|
%
%%
% @param |accesstofile| : 
%
% * 1 : if 1, then really save the data to a file, 
% * 0 : if set to 0, then the data isn't saved to a file, but is saved to
% the base workspace (better for optimization purpose -> speed)
% * -1 : if it is -1, then save the data not to the workspace but to the
% model workspace, that's the default value. On new MATLAB versions (>=
% 7.11) initstate is not saved inside the modelworkspace anymore but also
% inside a file (see <matlab:doc('createinitstatefile')
% createinitstatefile>). 
%
%% Example
% 
% Save initstate in base workspace. First read it out of |equilibrium| and
% save states for digester and hydraulic delay.
%

[substrate, plant, substrate_network, plant_network]= ...
    load_biogas_mat_files('gummersbach');

equilibrium= defineEquilibriumStruct(plant, plant_network);
  
setInitStateInWorkspace(equilibrium, plant, plant_network, 'user', 0);

%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('createinitstatefile')">
% createinitstatefile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/change_initstate_oo_equilibrium')">
% biogas_scripts/change_initstate_oo_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/getnumrecirculations')">
% biogas_scripts/getNumRecirculations</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isz')">
% script_collection/isZ</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_equilibrium')">
% biogas_scripts/is_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validatestring')">
% matlab/validatestring</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('simbiogasplant')">
% simBiogasPlant</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('simbiogasplantextended')">
% simBiogasPlantExtended</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('load_biogas_mat_files')">
% load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="defineequilibriumstruct.html">
% defineEquilibriumStruct</a>
% </html>
% ,
% <html>
% <a href="setnetworkfluxinworkspace.html">
% setNetworkFluxInWorkspace</a>
% </html>
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


