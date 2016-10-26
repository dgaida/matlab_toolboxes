%% Syntax
%       equilibrium= saveStateInEquilibriumStruct(equilibrium, plant,
%       plant_network, fitness) 
%       equilibrium= saveStateInEquilibriumStruct(equilibrium, plant,
%       plant_network, fitness, accesstofile) 
%
%% Description
% |equilibrium= saveStateInEquilibriumStruct(equilibrium, plant,
% plant_network, fitness)| loads the variable |initstate| from model
% workspace of the current load model and saves it in the |equilibrium| 
% struct. And writes given |fitness| value into the struct. The struct is
% used to save good equilibrium points, this function can be called after a
% simulation, when the equilibrium is good. Inside the variable |initstate|
% the initial or final states of the fermenters and hydraulic delays are
% saved. If it is the initial or final state, depends on the fact whether
% the final simulation state is saved or not. If it is saved it must be
% saved inside the model workspace, see parameter |accesstofile|. 
%
%%
% @param |equilibrium| : structure, defined in
% <defineequilibriumstruct.html defineEquilibriumStruct> 
%
%%
% @param |plant| : object of class |biogas.plant|
%
%%
% @param |plant_network| : double array, see file
% |plant_network__plant_id_.mat| in the <matlab:feval('getConfigPath()')
% |config_mat|> folder. 
%
%%
% @param |fitness| : double scalar value, defining the fitness of the
% simulation
%
%%
% |equilibrium= saveStateInEquilibriumStruct(equilibrium, plant,
% plant_network, fitness, accesstofile)| 
%
%%
% @param |accesstofile| : double scalar
%
% * 1 : if 1, then really load the data from a file, 
% * 0 : if set to 0, then the data isn't load from a file, but is load from the 
% base workspace (better for optimization purpose -> speed)
% * -1 : if it is -1, then load the data not from the workspace but to the model
% workspace, that's the default value. On new MATLAB versions (>= 7.11)
% initstate is not evaluated in the modelworkspace anymore but also load 
% from a file (see <matlab:doc(eval_initstate_inmws')
% eval_initstate_inMWS>). 
%
%% Example
%
% # load initstate from workspace and save in equilibrium struct. Therefore
% initstate first has to be written into workspace, this is done using
% <setinitstateinworkspace.html setInitStateInWorkspace> 

[substrate, plant, substrate_network, plant_network]= ...
    load_biogas_mat_files('gummersbach');

equilibrium= defineEquilibriumStruct(plant, plant_network);
  
setInitStateInWorkspace(equilibrium, plant, plant_network, 'user', 0);

saveStateInEquilibriumStruct(equilibrium, plant, plant_network, -Inf, 0)

%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('eval_initstate_inmws')">
% eval_initstate_inMWS</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isz')">
% script_collection/isZ</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('evalin')">
% matlab/evalin</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="simbiogasplant.html">
% simBiogasPlant</a>
% </html>
% ,
% <html>
% <a href="simbiogasplantextended.html">
% simBiogasPlantExtended</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="defineequilibriumstruct.html">
% defineEquilibriumStruct</a>
% </html>
% ,
% <html>
% <a href="setinitstateinworkspace.html">
% setInitStateInWorkspace</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('load_biogas_mat_files')">
% load_biogas_mat_files</a>
% </html>
%
%% TODOs
% # Es werden starke Annahmen bezüglich |plant_network| und die Anordnung
% der Fermenter gemacht, s. in der Datei. Evtl. kann man das noch lockern
% mit min/max von plant_network
%
%% <<AuthorTag_DG/>>


