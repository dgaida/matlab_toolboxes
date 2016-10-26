%% Syntax
%       equilibria= defineEquilibriumStruct(plant, plant_network)
%       equilibria= defineEquilibriumStruct(plant, plant_network, state_vec)
%
%% Description
% |equilibria= defineEquilibriumStruct(plant, plant_network)|
% defines the structure of the equilibrium struct. An equilibrium structure
% is defined as a <matlab:doc('matlab/struct') struct> containing the
% states of the digesters and hydraulic delays. Furthermore it contains the
% flux streams on the plant, namely the substrate feed and the pumped
% values between the fermenters. Furthermore it contains the fitness value
% of the equilibrium.
%
% The structure is as follows:
%
% * |equilibria.fermenter.( fermenter_id ).x0| contains the 37 dimensional
% state vector of the ADM1 model for the digester with the given ID
% |fermenter_id|. The state for every digester on the plant is saved like
% that. 
% * |equilibria.hydraulic_delay.( [ fermenter_id_start '_'
% fermenter_id_destiny ] ).x0| contains the 33 dimensional state vector of
% the hydraulic delays, which are inside pumps which are used for
% recirculating sludge between fermenters. The function automatically
% detects the pumps which transport recirculating sludge using
% |plant_network|, here it is assumed that sludge between
% |fermenter_id_start| and |fermenter_id_destiny| is recirculated. 
% * |equilibria.fitness| is a scalar describing the fitness of the
% equilibrium. Here it is set to 0. 
% * |equilibria.network_flux| contains flux on the plant, which is
% substrate input and recirculated sludge. |network_flux| is a row vector.
% The first entries are the substrate feeds in each fermenter, starting
% with all substrates for the first fermenter, then all substrates for the
% second fermenter, etc. Then the recirculated sludge values are added. The
% recirculations are sorted like that: TODO
% * |equilibria.network_flux_string| describes the values inside
% |equilibria.network_flux| in form of a cell array of chars. 
%
% For more informations see
% <matlab:docsearch(''Definition,of,equilibrium'') here> 
%
%% <<plant/>>
%% <<plant_network/>>
%%
% @param |state_vec| : state vectors of digesters, number of columns as
% there are digesters on the plant
%
%%
% @return |equilibria| : the equilibria structure
%
%% Example
% 
% Create new equilibrium for the plant Gummersbach

[substrate, plant, substrate_network, plant_network]= ...
    load_biogas_mat_files('gummersbach');

defineEquilibriumStruct(plant, plant_network)

%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant')">
% biogas_scripts/is_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant_network')">
% biogas_scripts/is_plant_network</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/getnumrecirculations')">
% biogas_scripts/getNumRecirculations</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('adm1_analysis_substrate')">
% ADM1_analysis_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('adm1_analysis_reachability')">
% ADM1_analysis_reachability</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('getinitpopofequilibria')">
% getInitPopOfEquilibria</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc('findoptimalequilibrium')">
% findOptimalEquilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('simequilibria')">
% simEquilibria</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/getequilibriumfromindividual')">
% biogas_optimization/biogasM.optimization.popBiogas.getEquilibriumFromIndividual</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/getindividualfromequilibrium')">
% biogas_optimization/biogasM.optimization.popBiogas.getIndividualFromEquilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_equilibrium')">
% biogas_scripts/is_equilibrium</a>
% </html>
%
%% TODOs
% # Es werden starke Annahmen bezüglich |plant_network| und die Anordnung
% der Fermenter gemacht, s. in der Datei. Evtl. kann man das noch lockern
% mit min/max von plant_network
% # man könnte überlegen, ob man nicht eine equilibrium Klasse einführt
% 
%% <<AuthorTag_DG/>>

    
