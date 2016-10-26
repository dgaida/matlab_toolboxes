%% Syntax
%       [networkFluxThres, fluxStringThres]=
%       getNetworkFluxThreshold(networkFlux, fluxString) 
%       [networkFluxThres, fluxStringThres]=
%       getNetworkFluxThreshold(networkFlux, fluxString, threshold) 
%
%% Description
% |[networkFluxThres, fluxStringThres]=
% getNetworkFluxThreshold(networkFlux, fluxString)| returns the parts of 
% the |networkFlux| and |fluxString| vector as vectors, for which
% |networkFlux| is > 0. 
%
%%
% @param |networkFlux| : total network flux vector in the model (consists of
% substrate mix and pumps), as double row vector. 
%
%%
% @param |fluxString| : corresponding <matlab:doc('cellstr') cell of
% strings>, naming the fluxes as cellstring row vector. 
%
%%
% @return |networkFluxThres| : is equal to |networkFlux|, without the elements,
% which are not bigger then threshold
%
%%
% @return |fluxStringThres| : is equal to |fluxString|, without the elements,
% for which the elements of |networkFlux| are not bigger then threshold
%
%%
% |[networkFluxThres, fluxStringThres]=
% getNetworkFluxThreshold(networkFlux, fluxString, threshold)| 
%
%%
% @param |threshold| : double scalar value defining the threshold, default:
% 0
%
%% Example
%
% 

equilibrium= load_file('equilibrium_gummersbach');

[networkFluxThres, fluxStringThres]= getNetworkFluxThreshold(...
            equilibrium.network_flux, equilibrium.network_flux_string, 0);
          
disp('networkFluxThres: ')    
disp(networkFluxThres)  
disp('fluxStringThres: ')
disp(fluxStringThres)

%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="simbiogasplantextended.html">
% simBiogasPlantExtended</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc('biogas_optimization/getnetworkfluxfromindividual')">
% biogas_optimization/biogasM.optimization.popBiogas.getNetworkFluxFromIndividual</a>
% </html>
% ,
% <html>
% <a href="defineequilibriumstruct.html">
% defineEquilibriumStruct</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('load_biogas_mat_files')">
% load_biogas_mat_files</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


