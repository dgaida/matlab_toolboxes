%% Syntax
%       equilibrium= getInitStateFromIndividual(obj, u, plant, plant_network, ...
%                            fitness, lenFluxIndividual)
%
%% Description
% |equilibrium= getInitStateFromIndividual(obj, u, plant, plant_network,
% fitness, lenFluxIndividual)| gets the initial states of the digesters
% from the individual |u| and writes them inside the returned |equilibrium|
% structure. Based on |digester_state_min| and |digester_state_max|, which
% the function reads out of the <popbiogas.html
% biogas.optimization.popBiogas> object |obj| it decides whether a value
% inside the individual |u| represents a part of the state vector of the
% digesters or not. Furthermore the initial states of the hydraulic delays
% are written inside the |equilibrium| structure. Always the default state
% is written. At the end the given |fitness| value is written inside the
% structure as well. 
%
%%
% @param |obj| : object of the class <popbiogas.html
% biogas.optimization.popBiogas>.
%
%%
% @param |u| : individual, double row vector. This |u| must contain the
% real physical values, not some scaled values, see
% <getequilibriumfromindividual.html 
% biogas.optimization.popBiogas.getEquilibriumFromIndividual>. 
%
%%
% @param |plant| : object of class |biogas.plant|
%
%%
% @param |plant_network| : double array defining the structure of the plant
%
%%
% @param |fitness| : fitness value, double scalar, is written inside
% |equilibrium| structure
%
%%
% @param |lenFluxIndividual| : length of the substrate + flux Individual,
% double scalar value. Must already contain the length of the genome. 
%
%%
% @return |equilibrium|: the equilibrium as a struct, see
% <matlab:doc('defineequilibriumstruct') defineEquilibriumStruct> 
%
%% Example
% 
% 
%% Dependencies
%
% The method calls:
%
% <html>
% <a href="matlab:doc('optimization_tool/getindividualbymask')">
% optimization_tool/optimization.conPopulation.getIndividualByMask</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="getequilibriumfromindividual.html">
% biogas.optimization.popBiogas.getEquilibriumFromIndividual</a>
% </html>
%
%% See Also
%
% <html>
% <a href="popbiogas.html">
% biogas.optimization.popBiogas</a>
% </html>
% ,
% <html>
% <a href="getnetworkfluxfromindividual.html">
% biogas.optimization.popBiogas.getNetworkFluxFromIndividual</a>
% </html>
%
%% TODOs
% # Es werden starke Annahmen bezüglich |plant_network| und die Anordnung
% der Fermenter gemacht, s. in der Datei. Evtl. kann man das noch lockern
% mit min/max von plant_network
% 
%% <<AuthorTag_DG/>>


