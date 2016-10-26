%% Preliminaries
% If you use only one worker at a time, then the simulation model is not
% loaded and not closed in this function (to save time). So you have to
% load the model yourself, this is done with the function
% <matlab:doc('load_biogas_system') |load_biogas_system|>. 
% After you have finished everything, then you should 
% close the model again using <matlab:doc(close_biogas_system') 
% |close_biogas_system|>. If you use more workers (|nWorker > 1|), then the 
% model is loaded, simulated and closed in this function, this depends on 
% the parameter |closeModel|.  
%
%% Syntax
%       [fitness, equilibrium]= simBiogasPlant(equilibrium, plant,
%       substrate, plant_network, substrate_network) 
%       [...]= simBiogasPlant(equilibrium, plant, substrate, plant_network,
%       substrate_network, timespan) 
%       [...]= simBiogasPlant(equilibrium, plant, substrate, plant_network,
%       substrate_network, timespan, initstate_type_hydraulic_delay) 
%       [...]= simBiogasPlant(equilibrium, plant, substrate, plant_network,
%       substrate_network, timespan, initstate_type_hydraulic_delay,
%       saveInEquilibrium)  
%       [...]= simBiogasPlant(equilibrium, plant, substrate, plant_network,
%       substrate_network, timespan, initstate_type_hydraulic_delay,
%       saveInEquilibrium, nWorker)  
%       [...]= simBiogasPlant(equilibrium, plant, substrate, plant_network,
%       substrate_network, timespan, initstate_type_hydraulic_delay,
%       saveInEquilibrium, nWorker, setNetworkFluxInModelWorkspace)  
%       [...]= simBiogasPlant(equilibrium, plant, substrate, plant_network,
%       substrate_network, timespan, initstate_type_hydraulic_delay,
%       saveInEquilibrium, nWorker, setNetworkFluxInModelWorkspace,
%       setStateInModelWorkspace)
%       [...]= simBiogasPlant(equilibrium, plant, substrate, plant_network,
%       substrate_network, timespan, initstate_type_hydraulic_delay,
%       saveInEquilibrium, nWorker, setNetworkFluxInModelWorkspace,
%       setStateInModelWorkspace, closeModel)
%       [...]= simBiogasPlant(equilibrium, plant, substrate, plant_network,
%       substrate_network, timespan, initstate_type_hydraulic_delay,
%       saveInEquilibrium, nWorker, setNetworkFluxInModelWorkspace,
%       setStateInModelWorkspace, closeModel, model_suffix)
%       [...]= simBiogasPlant(equilibrium, plant, substrate, plant_network,
%       substrate_network, timespan, initstate_type_hydraulic_delay,
%       saveInEquilibrium, nWorker, setNetworkFluxInModelWorkspace,
%       setStateInModelWorkspace, closeModel, model_suffix,
%       control_horizon) 
%       [...]= simBiogasPlant(equilibrium, plant, substrate, plant_network,
%       substrate_network, timespan, initstate_type_hydraulic_delay,
%       saveInEquilibrium, nWorker, setNetworkFluxInModelWorkspace,
%       setStateInModelWorkspace, closeModel, model_suffix,
%       control_horizon, lenGenomSubstrate) 
%       [...]= simBiogasPlant(equilibrium, plant, substrate, plant_network,
%       substrate_network, timespan, initstate_type_hydraulic_delay,
%       saveInEquilibrium, nWorker, setNetworkFluxInModelWorkspace,
%       setStateInModelWorkspace, closeModel, model_suffix,
%       control_horizon, lenGenomSubstrate, lenGenomPump) 
%       [...]= simBiogasPlant(equilibrium, plant, substrate, plant_network,
%       substrate_network, timespan, initstate_type_hydraulic_delay,
%       saveInEquilibrium, nWorker, setNetworkFluxInModelWorkspace,
%       setStateInModelWorkspace, closeModel, model_suffix,
%       control_horizon, lenGenomSubstrate, lenGenomPump, use_history) 
%       [...]= simBiogasPlant(equilibrium, plant, substrate, plant_network,
%       substrate_network, timespan, initstate_type_hydraulic_delay,
%       saveInEquilibrium, nWorker, setNetworkFluxInModelWorkspace,
%       setStateInModelWorkspace, closeModel, model_suffix,
%       control_horizon, lenGenomSubstrate, lenGenomPump, use_history,
%       init_substrate_feed) 
%       [...]= simBiogasPlant(equilibrium, plant, substrate, plant_network,
%       substrate_network, timespan, initstate_type_hydraulic_delay,
%       saveInEquilibrium, nWorker, setNetworkFluxInModelWorkspace,
%       setStateInModelWorkspace, closeModel, model_suffix,
%       control_horizon, lenGenomSubstrate, lenGenomPump, use_history,
%       init_substrate_feed, fitness_params) 
%       [fitness, equilibrium, fcn]= simBiogasPlant(...)
%
%% Description
% |[fitness, equilibrium]= simBiogasPlant(equilibrium, plant, substrate,
% plant_network, substrate_network)| 
% simulates a biogas plant created with the library of the toolbox _Biogas
% Plant Modeling_. The simulation is started in the given |equilibrium|,
% which defines the initial state and the network flux (substrate flow and
% recirculation between digesters). The initial state 
% of the models (see parameter |setStateInModelWorkspace|) and the network
% flux is set in the model workspace (see parameter
% |setNetworkFluxInModelWorkspace|) of the model calling 
% <setinitstateinworkspace.html setInitStateInWorkspace> and
% <setnetworkfluxinworkspace.html setNetworkFluxInWorkspace>, respectively.
% If you make many simulations in a row, then the state or the 
% network flux may stay constant. Then you do not have to set the constant
% values every time, such that you should use the options
% |setNetworkFluxInModelWorkspace| respectvely |setStateInModelWorkspace|
% and set them to 0. Then you have to set both variables in the model
% workspace (or somewhere else) before calling this function. When 
% you use the option |setStateInModelWorkspace|= 0, then be careful that 
% you do not save the state in |initstate| after the simulation (uncheck
% checkboxes in the model blocks ADM1 and pumps), otherwise the initial
% state of each new simulation will be the final state of the last
% simulation. 
%
%% <<equilibrium/>>
%% <<plant/>>
%% <<substrate/>>
%% <<plant_network/>>
%% <<substrate_network/>>
%%
% @return |fitness| : fitness of the new equilibrium at the end of the
% simulation, double scalar. The lower the value, the better the result. 
%
%%
% @return |equilibrium| : the new or old |equilibrium|, depends on the 
% parameter |saveInEquilibrium|. If |saveInEquilibrium == 1|, then the new
% |equilibrium|, otherwise the old one. Independent of |saveInEquilibrium|
% the network fluxes which whom the simulation was started is saved inside
% the returned |equilibrium| as well as the |fitness| value at the end of
% the simulation. 
%
%%
% |[...]= simBiogasPlant(equilibrium, plant, substrate, plant_network,
% substrate_network, timespan)| 
%
%%
% @param |timespan| : the duration of the simulation : e.g. [0 50] for 50
% days. Default: [0 100], thus 100 days are simulated. 
%
%%
% |[...]= simBiogasPlant(equilibrium, plant, substrate, plant_network,
% substrate_network, timespan, initstate_type_hydraulic_delay)|
%
%%
% @param |initstate_type_hydraulic_delay| : 'user' or 'default'
%
% * 'user' : load the initial state of the hydraulic delays in the model
% from the |equilibrium| struct and save it in
% initstate.hydraulic_delays....'user'. This option is used, when you want 
% to simulate from a very specific equilibrium point.
% * 'default' : here the initial state for the hydraulic delays is set in
% initstate.hydraulic_delays... to default. This option is used, when you
% want to find new equilibrium points for the digesters, then the state of
% the hydraulic delays is fixed to default, because it doesn't (or better
% may not) influence the fitness of the simulation.
%
% The standard value is 'default'.
%
%%
% |[...]= simBiogasPlant(equilibrium, plant, substrate, plant_network,
% substrate_network, timespan, initstate_type_hydraulic_delay,
% saveInEquilibrium)| 
%
%%
% @param |saveInEquilibrium| : 1 or 0
%
% * 1 : save the new (gotten after simulation) equilibrium state in the
% equilibrium structure. This setting is used when you search for new
% equilibria (Daniel). To save the new state, you have to save the final
% state in the blocks, see the checkboxes of ADM1 and pump blocks. 
% * 0 : don't save the new state. This setting is used, when you are not
% further interested in the new state (besides the fitness) (Christian).
% The standard value is 0.
%
%%
% |[...]= simBiogasPlant(equilibrium, plant, substrate, plant_network,
% substrate_network, timespan, initstate_type_hydraulic_delay,
% saveInEquilibrium, nWorker)| 
%
%%
% @param |nWorker|    : number of workers to run in parallel : 
% 2 for a dual core, 4 for a quadcore, when using with 'multicore', else
% number of computers (workers) in the cluster. The standard value is 2,
% when using parallel computing, else 1. Standard value is 1.
%
% If |nWorker| > 1, then the simulation models are load and closed (see
% parameter |closeModel|) in this function. To check if a model is free the
% existence of a mat file, called |plant__plant_id__1.mat|, is checked. If
% it is there, then the model is free, if not it is already simulated by
% another worker. Then before loading the model this mat file is deleted.
% At the end of the function this mat file is created again, but only if
% |closeModel == 1|. TODO: this raises the question, if |closeModel| is
% needed, or if this parameter can be deleted???
%
%%
% |[...]= simBiogasPlant(equilibrium, plant, substrate, plant_network,
% substrate_network, timespan, initstate_type_hydraulic_delay,
% saveInEquilibrium, nWorker, setNetworkFluxInModelWorkspace)|
%
%%
% @param |setNetworkFluxInModelWorkspace| : 1 or 0
%
% * 0 : If you make many simulations in a row, then the network flux may
% stay constant. Then you don't have to set the constant values every time
% again. Then you have to define the network flux before calling this
% function. 
% * 1 : per default we read the network flux out of the |equilibrium| struct
% and set it in the modelworkspace of the model calling
% <setnetworkfluxinworkspace.html setNetworkFluxInWorkspace>. 
%
%%
% |[...]= simBiogasPlant(equilibrium, plant, substrate, plant_network,
% substrate_network, timespan, initstate_type_hydraulic_delay,
% saveInEquilibrium, nWorker, setNetworkFluxInModelWorkspace,
% setStateInModelWorkspace)| 
%
%%
% @param |setStateInModelWorkspace| : 1 or 0
%
% * 0 : If you make many simulations in a row, then the state may stay
% constant. Then you don't have to set the constant values every time. When
% you use the option |setStateInModelWorkspace= 0|, then be careful that you
% don't save the state in |initstate| after the simulation (uncheck the 
% checkboxes in the models ADM1 and pumps), otherwise the initial
% state of each new simulation will be the final state of the last
% simulation. 
% * 1 : per default we read the initial states out of the |equilibrium|
% struct and set them in the modelworkspace of the model calling
% <setinitstateinworkspace.html setInitStateInWorkspace>. 
%
%%
% |[...]= simBiogasPlant(equilibrium, plant, substrate, plant_network,
% substrate_network, timespan, initstate_type_hydraulic_delay,
% saveInEquilibrium, nWorker, setNetworkFluxInModelWorkspace,
% setStateInModelWorkspace, closeModel)| 
%
%%
% @param |closeModel| : 1 or 0
%
% * 0 : then don't close the model, the model is closed elsewhere, used
% when this function is called from <simbiogasplantextended.html
% |simBiogasPlantExtended|>.
% * 1 : close the model after simulation, standard
%
% TODO: at the moment this parameter only applies if |nWorker > 1|, either
% change this behaviour or delete the |closeModel| parameter. 
%
%%
% @param |model_suffix| : a char specifying the to be simulated model, 
% the model has the name ['plant_sunderhook', model_suffix]. Not used at
% the moment. 
%
% default is []
%
%%
% @param |control_horizon| : double scalar defining the control horizon in
% days (only needed for control purposes). The default value is the last
% value in |timespan|. 
%
%%
% @param |lenGenomSubstrate| : double scalar, defining the length of coding
% of Substrate genome, only needed for optimization. The default value is
% 1. If |lenGenomSubstrate > 1|, then in the volumeflow_..._user variable is
% written, else in a volumeflow_..._const variable. What is written in the
% user and const variables is defined in |equilibrium|. If
% |lenGenomSubstrate > 1| then the user variable has steps of 
% |control_horizon/lenGenomSubstrate| length. Thus |lenGenomSubstrate|
% steps. 
%
%%
% @param |lenGenomPump| : double scalar, defining the length of coding
% of pumped flux genome, only needed for optimization. At the moment not
% used and always equal to 1. 
%
%%
% @param |use_history| : 0 or 1, integer (double) or boolean
%
% * 0 : default behaviour, just the last row of |y| is returned as
% |fitness|. 
% * 1 : First, each column of |y| is resampled onto a sampletime of 1 day.
% Then fitness is the sum of the resampled |y| values over each column.
% Therefore the fitness value depends on the simulation duration, given by
% |t|. To |fitness| also a terminal cost is added. It is just the last
% value in |y| for each column of |y| and gets a weight of 10 %. 
%
%%
% @param |init_substrate_feed| : this is the initial substrate feed of the
% plant, before the simulation is started. This is needed to calculate the
% change of the substrate feed from the initial to the one first applied to
% the plant. If this is unknown, it is assumed, that the feed which is
% applied in the beginning of the simulation is equal to the initial feed.
% It is in the responsibility of the user to assure this, otherwise the
% returned value of the called function <getudotnorm.html getudotnorm> will
% not be exact. It is a double matrix 
% with number of rows equal to the substrates and number of columns equal
% to number of digesters. The values are the feeds measured in m³/d. 
%
%% <<fitness_params/>>
%%
% @return |fcn| : char with the name of the plant simulated, which is
% 'plant__plant_id_'. If |nWorker| > 1, then the numerical id (1,2,3,4,...)
% is appended at the end of |fcn|. 
%
%% Example
% 
% [fitness, equilibrium]= simBiogasPlant(equilibrium, ...
%                                    plant, substrate, ...
%                                    plant_network, substrate_network)
%
%% Dependencies
%
% This method calls:
%
% <html>
% <a href="setnetworkfluxinworkspace.html">
% setNetworkFluxInWorkspace</a>
% </html>
% ,
% <html>
% <a href="setinitstateinworkspace.html">
% setInitStateInWorkspace</a>
% </html>
% , 
% <html>
% <a href="getrecordedfitnessextended.html">
% getRecordedFitnessExtended</a>
% </html>
% , 
% <html>
% <a href="savestateinequilibriumstruct.html">
% saveStateInEquilibriumStruct</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/calcdxnorm')">
% script_collection/calcDXNorm</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/getmatlabversion')">
% script_collection/getMATLABVersion</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('sim')">
% matlab/sim</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('close_system')">
% matlab/close_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('save_system')">
% matlab/save_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/evalinmws')">
% script_collection/evalinMWS</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
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
% <a href="simbiogasplantextended.html">
% simBiogasPlantExtended</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="simrealbiogasplant.html">
% simRealBiogasPlant</a>
% </html>
% ,
% <html>
% <a href="simbiogasplantbasic.html">
% simBiogasPlantBasic</a>
% </html>
%
%% TODOs
% # check appearance of documentation
% # create an example
% # is model_suffix needed?
% # is closeModel needed?
%
%% <<AuthorTag_DG/>>

    
