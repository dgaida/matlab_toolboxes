%% Preliminaries
%
% # Einstellungen im Simulationsmodell:
% 
% * Zustände und Substratvolumenstrom werden vom modelworkspace gelesen
% * Zustand für Fermenter= user
% * Zustand für Totzeit= default
% * Volumenstrom= const
%
% # wenn vorhanden equilibria_|plant_id|.mat vorher in den Arbeitsspeicher
% laden, oder besser equilibria_best_|plant_id|.mat, dann werden die neuen
% equilibria an diese Struktur angehangen
%
%% Syntax
%       equilibria= getInitPopOfEquilibria(plant_id)
%       equilibria= getInitPopOfEquilibria(plant_id, parallel)
%       equilibria= getInitPopOfEquilibria(plant_id, parallel, nWorker)
%       equilibria= getInitPopOfEquilibria(plant_id, parallel, nWorker,
%       setting) 
%
%% Description
%
% |equilibria= getInitPopOfEquilibria(plant_id)| gets the initial
% population for an optimization problem, which tries to minimize a fitness
% defined in a simulation model created with the library of the 'Biogas
% Plant Modeling' toolbox.
%
% The function just makes a random search for good equilibria. If a point
% near an equilibrium is found then it is simulated. If the fitness in the
% new equilibrium is good enough, this new equilibrium is saved in the
% initial population. 
% 
%%
% @return |equilibria| : a struct of good equilibria which can be used as
% initial population for an optimzation problem like the function
% <findoptimalequilibrium.html findOptimalEquilibrium>
%
%%
% |equilibria= getInitPopOfEquilibria(plant_id, parallel)|
%
%%
% @param |parallel| : evaluate the individuals in parallel?
% 'none' : single processor, no parallel computing
% 'multicore' : parallel computing using a multicore processor on one PC
% 'cluster' : using Parallel Computing Toolbox functions and MATLAB
% Distributed Computing Server on a computer cluster (not yet implemented)
%
%%
% |equilibria= getInitPopOfEquilibria(plant_id, parallel, nWorker)|
%
%%
% @param |nWorker| : number of workers to run in parallel : 
% 2 for a dual core, 4 for a quadcore, when user with 'multicore', else
% number of computers (workers) in the cluster
%
%% Example
%
% |equilibria= getInitPopOfEquilibria('sunderhook', 'multicore', 4)|
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_mat_files')">
% biogas_scripts/load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_system')">
% biogas_scripts/load_biogas_system</a>
% </html>
% ,
% <html>
% <a href="defineequilibriumstruct.html">
% defineEquilibriumStruct</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/popbiogas')">
% biogas_optimization/biogasM.optimization.popBiogas</a>
% </html>
% ,
% <html>
% <a href="setnetworkfluxinworkspace.html">
% setNetworkFluxInWorkspace</a>
% </html>
% ,
% <html>
% <a href="simbiogasplantextended.html">
% simBiogasPlantExtended</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/close_biogas_system')">
% biogas_scripts/close_biogas_system</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
%
% <html>
% <a href="findoptimalequilibrium.html">
% findOptimalEquilibrium</a>
% </html>
% ,
% <html>
% <a href="simbiogasplant.html">
% simBiogasPlant</a>
% </html>
%
%% TODOs
% # improve documentation
% # check code
% # make a running example
%
%% <<AuthorTag_DG/>>


