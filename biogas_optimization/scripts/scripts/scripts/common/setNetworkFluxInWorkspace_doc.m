%% Syntax
%       [errflag, substrate_network]=
%       setNetworkFluxInWorkspace(equilibrium,
%       lenGenomSubstrate, lenGenomPump, substrate, plant,
%       substrate_network) 
%       [...]= setNetworkFluxInWorkspace(equilibrium,
%       lenGenomSubstrate, lenGenomPump, substrate, plant,
%       substrate_network, accesstofile)
%       [...]= setNetworkFluxInWorkspace(equilibrium,
%       lenGenomSubstrate, lenGenomPump, substrate, plant,
%       substrate_network, accesstofile, control_horizon)
%
%% Description
% |[errflag, substrate_network]= setNetworkFluxInWorkspace(equilibrium,
% lenGenomSubstrate, lenGenomPump, substrate, plant,
% substrate_network)| writes the network flux (substrate 
% flow and pump flow) arrays in the model workspace of the actual model,
% from there the simulation model can load the arrays to simulate
% (<matlab:doc('createvolumeflowfile') createvolumeflowfile>). 
% Furthermore |substrate_network| is changed, depends on substrate flow
% given in |networkFlux| and also saved in modelworkspace. On new MATLAB
% versions (>= 7.11) all the values are not saved in the modelworkspace
% anymore but saved to files.
% 
%% <<equilibrium/>>
%%
% @param |lenGenomSubstrate| : length of the substrate flow genome coding ->
% its the number of changes over the control horizon, if it is
% constant, then it is 1, if it changes once, then it is 2, etc., double
% scalar
%
% * 1 : then |volumeflow_..._const| variables or files are created
% * > 1 : then |volumeflow_..._user| variables or files are created
%
%%
% @param |lenGenomPump| : the same for the pump flows. 
%
%% <<plant/>>
%% <<substrate/>>
%% <<substrate_network/>>
%%
% @return |substrate_network| : the new |substrate_network|, it depends on
% |networkFlux|, since it describes the relation of one substrate flow going 
% in every fermenter. 
% The variable is already written into the model workspace, such that the
% model can work with it
%
%%
% |[...]= setNetworkFluxInWorkspace(networkFlux, fluxString,
% lenGenomSubstrate, lenGenomPump, substrate, plant, substrate_network,
% accesstofile)| defines where the variables |volumeflow_...| and
% |substrate_network| are saved. 
%
%%
% @param |accesstofile| : double scalar integer
%
% * 1 : if 1, then really save the data to a file, 
% * 0 : if set to 0, then the data isn't saved to a file, but is saved to the 
% base workspace (better for optimization purpose -> speed)
% * -1 : if it is -1, then save the data not to the workspace but to the 
% model workspace, that's the default value. On new MATLAB
% versions (>= 7.11) all the values are not saved in the modelworkspace
% anymore but saved to files.
%
%%
% |[...]= setNetworkFluxInWorkspace(networkFlux, fluxString,
% lenGenomSubstrate, lenGenomPump, substrate, plant, substrate_network,
% accesstofile, control_horizon)| only applies if |lenGenomSubstrate > 1|.
%
%%
% @param |control_horizon| : control horizon in days. if
% |lenGenomSubstrate| > 1, then the time duration between a change of the
% substrate feed is |control_horizon| / |lenGenomSubstrate|. If
% |lenGenomSubstrate| = 1, then this parameter is not used. 
%
%% Example
%
% 

[substrate, plant, substrate_network, plant_network]= ...
    load_biogas_mat_files('gummersbach');

try
  equilibrium= load_file('equilibrium_gummersbach');
catch ME
  disp(ME.message);
  
  equilibrium= defineEquilibriumStruct(plant, plant_network);
end

setNetworkFluxInWorkspace(equilibrium, 1, 1, ...
                          substrate, plant, substrate_network, 0)
      
                 
%%
% example for |lenGenomSubstrate= 2|

plant_id= 'gummersbach';

parallel= 'none';
nWorker= 1;

[substrate, plant, substrate_network, plant_network, ...
   substrate_network_min, substrate_network_max, ...
   plant_network_min, plant_network_max, ...
   digester_state_min, digester_state_max, ...
   params_min, params_max, ...
   substrate_eq, substrate_ineq, fitness_params]= ...
                                load_biogas_mat_files(plant_id);

[popBiogas]= biogasM.optimization.popBiogas(0, ...
                    substrate_network_min, substrate_network_max, ...
                    plant_network_min, plant_network_max, ...
                    digester_state_min, digester_state_max, ...
                    params_min, params_max, ...
                    substrate_ineq, substrate_eq, ...
                    @(obj)@(u)nonlcon_substrate(u, plant, substrate, ...
                                        obj, fitness_params.TS_feed_max), ...
                    [], [], @(u)nonlcon_plant(u), ...
                    [], [], [], ...
                    @(u)nonlcon_params(u), ...
                    parallel, nWorker, [], 2);

%%

[equilibrium]= getEquilibriumFromIndividual(popBiogas, [5 7 3 2 5 3], ...
                                 plant, substrate, plant_network, 0);
  
setNetworkFluxInWorkspace(equilibrium, 2, 1, ...
                          substrate, plant, substrate_network, 0, 1)
      
      
%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/get_feed_oo_equilibrium_and_save_to')">
% biogas_scripts/get_feed_oo_equilibrium_and_save_to</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/save_substrate_network_to')">
% biogas_scripts/save_substrate_network_to</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_sludge_oo_equilibrium_and_save_to')">
% biogas_scripts/get_sludge_oo_equilibrium_and_save_to</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
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
%
% and is called by:
%
% <html>
% <a href="matlab:doc('adm1_analysis_substrate')">
% ADM1_analysis_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('getinitpopofequilibria')">
% getInitPopOfEquilibria</a>
% </html>
% ,
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
% <a href="setinitstateinworkspace.html">
% setInitStateInWorkspace</a>
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
% # go through examples
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


