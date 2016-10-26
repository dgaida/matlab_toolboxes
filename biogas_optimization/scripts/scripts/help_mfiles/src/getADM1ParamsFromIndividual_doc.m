%% Syntax
%        adm1_params= getADM1ParamsFromIndividual(obj, u, plant)
%
%% Description
% |getADM1ParamsFromIndividual| creates the ADM1 parameter struct
% |adm1_params| out of the passed individual |u|.
%
%%
% @param |u| : the individual, double row vector
%
%%
% @param |plant| : object of the C# class |biogas.plant|
%
%%
% @return |adm1_params| : the ADM1 parameter structure for the given individual
%
%% Example
% 
%
%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('numerics_tool/getpointsinfulldimension')">
% numerics_tool/getPointsInFullDimension</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('optimization_tool/getindividualbymask')">
% optimization_tool/getIndividualByMask</a>
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
% <a href="matlab:doc('fitnessfindoptimalequilibrium')">
% fitnessFindOptimalEquilibrium</a>
% </html>
%
%% See Also
%
% <html>
% <a href="popbiogas.html">
% biogasM.optimization.popBiogas</a>
% </html>
% ,
% <html>
% <a href="getnetworkfluxfromindividual.html">
% biogasM.optimization.popBiogas.getNetworkFluxFromIndividual</a>
% </html>
% ,
% <html>
% <a href="getinitstatefromindividual.html">
% biogasM.optimization.popBiogas.getInitStateFromIndividual</a>
% </html>
% ,
% <html>
% <a href="getequilibriumfromindividual.html">
% biogasM.optimization.popBiogas.getEquilibriumFromIndividual</a>
% </html>
%
%% TODOs
% # improve documentation
% # add an example
%
%% <<AuthorTag_DG/>>


