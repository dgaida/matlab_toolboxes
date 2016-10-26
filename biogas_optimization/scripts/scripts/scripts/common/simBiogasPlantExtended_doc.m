%% Preliminaries
% If you use only one worker at a time, then the simulation model is not
% loaded and not closed in this function, respectively not in
% <simbiogasplant.html |simBiogasPlant|>, (to save time). So you have to 
% load the model yourself, this is done with the function
% <matlab:doc('load_biogas_system') |load_biogas_system|>.  
% After you have finished everything, then you should 
% close the model again using <matlab:doc(close_biogas_system') 
% |close_biogas_system|> use more workers, then the model is 
% loaded, simulated and closed in this function. It is loaded and simulated
% calling <simbiogasplant.html simBiogasPlant> and at the end of this
% function closed. 
%
%% Syntax
%       [fitness, equilibrium]= simBiogasPlantExtended(equilibrium, plant,
%       substrate, plant_network, substrate_network, fitness_params) 
%       [...]= simBiogasPlantExtended(equilibrium, plant, substrate,
%       plant_network, substrate_network, fitness_params, timespan)
%       [...]= simBiogasPlantExtended(equilibrium, plant, substrate,
%       plant_network, substrate_network, fitness_params, timespan,
%       saveInEquilibrium) 
%       [...]= simBiogasPlantExtended(equilibrium, plant, substrate,
%       plant_network, substrate_network, fitness_params, timespan,
%       saveInEquilibrium, nWorker) 
%       [...]= simBiogasPlantExtended(equilibrium, plant, substrate,
%       plant_network, substrate_network, fitness_params, timespan,
%       saveInEquilibrium, nWorker, fitness_function) 
%       [...]= simBiogasPlantExtended(equilibrium, plant, substrate,
%       plant_network, substrate_network, fitness_params, timespan,
%       saveInEquilibrium, nWorker, fitness_function,
%       threshold_fitness_after_sim) 
%       [...]= simBiogasPlantExtended(equilibrium, plant, substrate,
%       plant_network, substrate_network, fitness_params, timespan,
%       saveInEquilibrium, nWorker, fitness_function,
%       threshold_fitness_after_sim, setNetworkFluxInModelWorkspace)
%       [...]= simBiogasPlantExtended(equilibrium, plant, substrate,
%       plant_network, substrate_network, fitness_params, timespan,
%       saveInEquilibrium, nWorker, fitness_function,
%       threshold_fitness_after_sim, setNetworkFluxInModelWorkspace,
%       setStateInModelWorkspace) 
%       [...]= simBiogasPlantExtended(equilibrium, plant, substrate,
%       plant_network, substrate_network, fitness_params, timespan,
%       saveInEquilibrium, nWorker, fitness_function,
%       threshold_fitness_after_sim, setNetworkFluxInModelWorkspace,
%       setStateInModelWorkspace, model_suffix) 
%       [...]= simBiogasPlantExtended(equilibrium, plant, substrate,
%       plant_network, substrate_network, fitness_params, timespan,
%       saveInEquilibrium, nWorker, fitness_function,
%       threshold_fitness_after_sim, setNetworkFluxInModelWorkspace,
%       setStateInModelWorkspace, model_suffix, control_horizon) 
%       [...]= simBiogasPlantExtended(equilibrium, plant, substrate,
%       plant_network, substrate_network, fitness_params, timespan,
%       saveInEquilibrium, nWorker, fitness_function,
%       threshold_fitness_after_sim, setNetworkFluxInModelWorkspace,
%       setStateInModelWorkspace, model_suffix, control_horizon,
%       lenGenomSubstrate)  
%       [...]= simBiogasPlantExtended(equilibrium, plant, substrate,
%       plant_network, substrate_network, fitness_params, timespan,
%       saveInEquilibrium, nWorker, fitness_function,
%       threshold_fitness_after_sim, setNetworkFluxInModelWorkspace,
%       setStateInModelWorkspace, model_suffix, control_horizon,
%       lenGenomSubstrate, lenGenomPump)  
%       [...]= simBiogasPlantExtended(equilibrium, plant, substrate,
%       plant_network, substrate_network, fitness_params, timespan,
%       saveInEquilibrium, nWorker, fitness_function,
%       threshold_fitness_after_sim, setNetworkFluxInModelWorkspace,
%       setStateInModelWorkspace, model_suffix, control_horizon,
%       lenGenomSubstrate, lenGenomPump, use_history)  
%       [...]= simBiogasPlantExtended(equilibrium, plant, substrate,
%       plant_network, substrate_network, fitness_params, timespan,
%       saveInEquilibrium, nWorker, fitness_function,
%       threshold_fitness_after_sim, setNetworkFluxInModelWorkspace,
%       setStateInModelWorkspace, model_suffix, control_horizon,
%       lenGenomSubstrate, lenGenomPump, use_history, init_substrate_feed)  
%       [fitness, equilibrium, database_file]= simBiogasPlantExtended(...) 
%
%% Description
% 
% |[fitness, equilibrium]= simBiogasPlantExtended(equilibrium, plant,
% substrate, plant_network, substrate_network, fitness_params)| calls
% <simbiogasplant.html simBiogasPlant>, which simulates the biogas plant
% starting at the given |equilibrium| and then saves good results (see
% parameter |threshold_fitness_after_sim|) in a database calling
% <matlab:doc('data_tool/writetodatabase') data_tool/writetodatabase>. 
%
%%
% @param |equilibrium| : equilibrium structure (see <defineequilibriumstruct.html
% defineEquilibriumStruct>)
%
%%
% @param |plant| : see the xml file, object of C# class |biogas.plant|
%
%%
% @param |substrate| : see the xml file, object of C# class
% |biogas.substrates| 
%
%%
% @param |plant_network| : see the struct file
%
%%
% @param |substrate_network| : see the struct file
%
%%
% @param |fitness_params| : structure with fitness parameters. Also
% contains the definition of the fitness function, what makes the parameter
% |fitness_function| obsolete. 
%
%%
% @return |fitness| : fitness of the new equilibrium at the end of the
% simulation, double scalar
%
%%
% @return |equilibrium| : the new or old equilibrium, depends on the 
% parameter |saveInEquilibrium|. If |saveInEquilibrium == 1|, then the new
% |equilibrium|, otherwise the old one. Independent of |saveInEquilibrium|
% the network fluxes which whom the simulation was started is saved inside
% the returned |equilibrium| as well as the |fitness| value at the end of
% the simulation. 
%
%%
% |[...]= simBiogasPlantExtended(equilibrium, plant, substrate,
% plant_network, substrate_network, fitness_params, timespan)|
%
%%
% @param |timespan| : the duration of the simulation : e.g. [0 50] for 50
% days. Default: [0 100], thus 100 days are simulated. 
%
%%
% |[...]= simBiogasPlantExtended(equilibrium, plant, substrate,
% plant_network, substrate_network, fitness_params, timespan,
% saveInEquilibrium)| 
%
%%
% @param |saveInEquilibrium| : 1 or 0
%
% * 1 : save the new (gotten after simulation) equilibrium state in the
% equilibrium structure. This setting is used when you search for new
% equilibria (Daniel).
% * 0 : don't save the new state. This setting is used, when you are not
% further interested in the new state (besides the fitness) (Christian).
% The standard value is 0.
%
%%
% |[...]= simBiogasPlantExtended(equilibrium, plant, substrate,
% plant_network, substrate_network, fitness_params, timespan,
% saveInEquilibrium, nWorker)|
%
%%
% @param |nWorker|    : number of workers to run in parallel : 
% 2 for a dual core, 4 for a quadcore, when using with 'multicore', else
% number of computers (workers) in the cluster. The standard value is 2,
% when using parallel computing, else 1. Standard value is 1.
%
% If |nWorker| > 1, then the simulation models are load and closed (see
% parameter |closeModel|) in this function, respectively in
% <simbiogasplant.html simBiogasPlant>. To check if a model is free the 
% existence of a mat file, called |plant__plant_id__1.mat|, is checked. If
% it is there, then the model is free, if not it is already simulated by
% another worker. Then before loading the model this mat file is deleted.
% At the end of the function this mat file is created again, but only if
% |closeModel == 1|. TODO: this raises the question, if |closeModel| is
% needed, or if this parameter can be deleted???
%
%%
% |[...]= simBiogasPlantExtended(equilibrium, plant, substrate,
% plant_network, substrate_network, fitness_params, timespan,
% saveInEquilibrium, nWorker, fitness_function)|
%
%% TODO
% fitness_function wird jetzt aus dem Optimierungsblock gelesen und muss
% hier nicht mehr übergeben werden, zu prüfen ist ledigleich ob es noch
% andere funktionen gibt die die fitness_function benötigen oder setzen.
% bei einer nächsten toolbox überholung prüfen. fitness function wird aus
% der fitness_params.mat datei gelesen.
%
%%
% |[...]= simBiogasPlantExtended(equilibrium, plant, substrate,
% plant_network, substrate_network, fitness_params, timespan,
% saveInEquilibrium, nWorker, fitness_function,
% threshold_fitness_after_sim)| 
%
%%
%
%
%%
% |[...]= simBiogasPlantExtended(equilibrium, plant, substrate,
% plant_network, substrate_network, fitness_params, timespan,
% saveInEquilibrium, nWorker, fitness_function,
% threshold_fitness_after_sim, setNetworkFluxInModelWorkspace)|
%
%%
% @param |setNetworkFluxInModelWorkspace| : 1 or 0
%
% * 0 : If you make many simulations in a row, then the network flux may
% stay constant. Then you don't have to set the constant values every time
% again. Then you have to define the network flux before calling this
% function. 
% * 1 : per default we read the network flux out of the equilibrium struct
% and set it in the modelworkspace of the model calling
% <setnetworkfluxinworkspace.html setNetworkFluxInWorkspace>. 
%
%%
% @param |setStateInModelWorkspace| : double, 1 or 0
%
% * 0 : If you make many simulations in a row, then the state may stay
% constant. Then you don't have to set the constant values every time. When
% you use the option setStateInModelWorkspace= 0, then be careful that you
% don't save the state in initstate after the simulation (uncheck the 
% checkboxes in the models ADM1 and pumps), otherwise the initial
% state of each new simulation will be the final state of the last
% simulation. 
% * 1 : per default we read the initial states out of the equilibrium
% struct and set them in the modelworkspace of the model calling
% <setinitstateinworkspace.html setInitStateInWorkspace>. 
%
%%
% @param |model_suffix| : a char specifying the to be simulated model
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
%%
% @return |database_file| : char containing the filename of the database in
% which the simulation data was written.
%
%% Example
% 
% [fitness, equilibrium]= simBiogasPlantExtended(equilibrium, ...
%                                    plant, substrate, ...
%                                    plant_network, substrate_network,
%                                    fitness_params) 
%
%% Dependencies
%
% This method calls:
%
% <html>
% <a href="simbiogasplant.html">
% simBiogasPlant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/writetodatabase')">
% data_tool/writetodatabase</a>
% </html>
% ,
% <html>
% <a href="getnetworkfluxthreshold.html">
% getNetworkFluxThreshold</a>
% </html>
% ,
% <html>
% <a href="savestateinequilibriumstruct.html">
% saveStateInEquilibriumStruct</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('load_file')">
% load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('save_system')">
% matlab/save_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('close_system')">
% matlab/close_system</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('adm1_analysis_reachability')">
% ADM1_analysis_reachability</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('adm1_analysis_substrate')">
% ADM1_analysis_substrate</a>
% </html>
% ,
% <html>
% <a href="fitnessfindoptimalequilibrium.html">
% fitnessFindOptimalEquilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nonlinearmpc')">
% biogas_control/nonlinearMPC</a>
% </html>
% ,
% <html>
% ...
% </html>
%
%% See Also
% 
% -
%
%% TODOs
% # create an example
% # delete parameter fitness_function
% # do TODOs in file
%
%% <<AuthorTag_DG/>>


