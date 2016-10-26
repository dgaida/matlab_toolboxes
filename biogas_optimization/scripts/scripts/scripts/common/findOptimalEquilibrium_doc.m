%% Preliminaries
% # You need a Simulink simulation model of a biogas plant created with
% this toolbox with the |*.mat| files used for simulation. For more
% informations on the needed files see the 
% <matlab:doc('create_config_mat_files_simu') documentation> 
% of this toolbox concerning the model development.
% # You need the following extra |*.mat| files (for further information look
% <matlab:doc('optimization_intro') #4 here>): 
%
% * |digester_state_min__plant_id_.mat| and
% |digester_state_max__plant_id_.mat|.
% : defining the minimal resp. maximal statevalues of each digester in the
% model, in between those values a simulation may be started. Both files
% contain matrices with the name |digester_state_min| resp.
% |digester_state_max| with the dimension ADM1_STATE_DIM -by- number of
% digesters, where ADM1_STATE_DIM= |biogas.ADMstate.dim_state|. If the
% state of the fermenter should 
% not be a parameter for your optimization task, then set
% |digester_state_min| = |digester_state_max| = |initial state of the
% biogas plant|.
% * |plant_network_min__plant_id_.mat| and
% |plant_network_max__plant_id_.mat| : 
% defining the minimal resp. maximal pumped flow between the fermenters in
% the model. Both files contain a matrix with the name |plant_network_min|
% resp. |plant_network_max|, which have the same dimension as
% |plant_network|. 
% * |substrate_network_min__plant_id_.mat| and
% |substrate_network_max__plant_id_.mat| : defining the minimal resp. maximal
% substrate flow into the fermenters. Both files contain a matrix with the
% name |substrate_network_min| resp. |substrate_network_max| which have the
% same dimension as |substrate_network|.
%
%%
% OPTIONAL:
%
% * |substrate_eq__plant_id_.mat| defines equality constraints on the
% substrates used in the model (e.g. constant mixture between some
% substrates). It contains a matrix |substrate_eq| with size: 
% number of equality constraints -by- |numel(substrate_network) + 1|. The
% vector of size 1 -by- |numel(substrate_network)| you get by concatenating the
% elements of substrate_network vertically from left to right and then
% transposing the vector. The last dimension '+1' (column) of the matrix
% defines the right side of the equality. So defining the equality as
% $Aeq \cdot \vec{x} = \vec{b}_{eq}$ the matrix is $[Aeq, \vec{b}_{eq}]$.
% * |substrate_ineq__plant_id_.mat|
% defines inequality constraints on the 
% substrates used in the model (e.g. <setlinearmanurebonusconstraint.html
% manure bonus (Gülle-Bonus)>). It contains a matrix 
% |substrate_ineq| with size: number of inequality
% constraints -by- |numel(substrate_network) + 1|. The vector of size
% 1 -by- |numel(substrate_network)| you get by concatenating the elements of
% |substrate_network| vertically from left to right and then transposing the
% vector. The last dimension '+1' (column) of the matrix defines the right
% side of the inequality. So defining the inequality as $A \cdot \vec{x}
% \leq \vec{b}$ the matrix is $[A, \vec{b}]$.
%
%% Syntax
%       equilibrium= findOptimalEquilibrium(plant_id, method)
%       equilibrium= findOptimalEquilibrium(plant_id, method, useInitPop)
%       equilibrium= findOptimalEquilibrium(plant_id, method, useInitPop,
%       parallel)  
%       equilibrium= findOptimalEquilibrium(plant_id, method, useInitPop,
%       parallel, nWorker)  
%       equilibrium= findOptimalEquilibrium(plant_id, method, useInitPop,
%       parallel, nWorker, pop_size)  
%       equilibrium= findOptimalEquilibrium(plant_id, method, useInitPop,
%       parallel, nWorker, pop_size, nGenerations)  
%       equilibrium= findOptimalEquilibrium(plant_id, method, useInitPop,
%       parallel, nWorker, pop_size, nGenerations, OutputFcn)  
%       equilibrium= findOptimalEquilibrium(plant_id, method, useInitPop,
%       parallel, nWorker, pop_size, nGenerations, OutputFcn, timespan)   
%       equilibrium= findOptimalEquilibrium(plant_id, method, useInitPop,
%       parallel, nWorker, pop_size, nGenerations, OutputFcn, timespan,
%       optParams)
%       equilibrium= findOptimalEquilibrium(plant_id, method, useInitPop,
%       parallel, nWorker, pop_size, nGenerations, OutputFcn, timespan,
%       optParams, model_suffix) 
%       equilibrium= findOptimalEquilibrium(plant_id, method, useInitPop,
%       parallel, nWorker, pop_size, nGenerations, OutputFcn, timespan,
%       optParams, model_suffix, nSteps) 
%       equilibrium= findOptimalEquilibrium(plant_id, method, useInitPop,
%       parallel, nWorker, pop_size, nGenerations, OutputFcn, timespan,
%       optParams, model_suffix, nSteps, timespan_steps) 
%       [equilibrium, u, fitness]= findOptimalEquilibrium(...)
%       [equilibrium, u, fitness, exitflag]= findOptimalEquilibrium(...)
%
%% Description
% |findOptimalEquilibrium| finds the (global,) optimal operating point
% of a biogas plant model using a stochastic optimization method.
%
%%
% |equilibrium= findOptimalEquilibrium(plant_id, method)| finds the
% (global,) optimal operating point, the optimal equilibrium point
% |equilibrium|, of the biogas plant simulation model |plant_id| using the
% optimization method |method|. The found equilibrium is a struct, which is
% explained in the <defineequilibriumstruct.html documentation> of this
% toolbox. 
%
%%
% # Loads and closes the biogas plant model
% # Runs the optimization method which tries to find an optimal equilibrium
% for the biogas plant model
% # Returns the files:
%
% - |equilibrium__plant_id__optimum.mat| : contains the optimal equilibrium
% struct found by the algorithm
%
% - |adm1_params_opt__plant_id__optimum.mat| : file with the optimal ADM1
% parameters found by the optimization algorithm
%
%% <<plant_id/>>
%% <<opt_method/>>
%%
% |equilibrium= findOptimalEquilibrium(plant_id, method, useInitPop)| 
%
% @param |useInitPop| : 
%
% * 1, if, then the initial population is loaded out of the
% file |equilibriaInitPop__plant_id_.mat|, else set to 0 or ignore this
% param (set to [] for ignoring, if you want to use the following params).
% The standard value is 0.
%
% |equilibrium= findOptimalEquilibrium(plant_id, method, useInitPop,
% parallel)|
%
%% <<parallel/>>
%%
% |equilibrium= findOptimalEquilibrium(plant_id, method, useInitPop,
% parallel, nWorker)| runs the problem with |nWorker| workers, if you have
% set |parallel| to 'multicore', then |nWorker| specifies the number of
% processors on one computer, or 'cluster', then |nWorker| specifies the
% number of computers.
%
%% <<nWorker/>>
%%
% |equilibrium= findOptimalEquilibrium(plant_id, method, useInitPop,
%  parallel, nWorker, pop_size)|
%
%% <<pop_size/>>
%%
% |equilibrium= findOptimalEquilibrium(plant_id, method, useInitPop,
%  parallel, nWorker, pop_size, nGenerations)|
%
%% <<nGenerations/>>
%%
% |equilibrium= findOptimalEquilibrium(plant_id, method, useInitPop,
%  parallel, nWorker, pop_size, nGenerations, OutputFcn)|
%
%%
% @param |OutputFcn| : function_handle to a function which is called after
% each generation of some optimization methods, at the momment only |ga|
% uses this method.
%
%%
% @param |timespan| : the duration of simulation : e.g. [0 50] for 50 days
%
%%
%
%
%%
% @param |modelSuffix| : a char specifying the to be simulated model
% the model has the name ['plant_sunderhook', modelSuffix]
%
% default is []
%
%%
% @param |nSteps| : number of steps of the substrate feed over the given
% |timespan|. Usually |nSteps| is set to 1, to have a constant substrate
% feed, thus a step function. If |nSteps| is set > 1, then you have a
% step-wise substrate feed with |nSteps| steps. 
%
%%
% @param |timespan_steps| : double scalar, defining on which time horizon
% the substrate feed should be changed, if |nSteps > 1|. Usually, if
% |nSteps > 1|, then the substrates are changed over the complete
% |timespan|. If you want to have them changed on a smaller timespan, you
% can specify it here. 
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
% |[equilibrium, u, fitness]= findOptimalEquilibrium(...)|
%
% @return |u| : the individual belonging to the optimal equilibrium point,
% wich is a vector of size 1-by-size of the individual : 
% the interpretation of the individual depends on many settings, but the
% main structure is |individual|= [the optimal substrate feed, the optimal
% pumped flow, the optimal digester states].
%
% @return |fitness| : the fitness of the equilibrium point, which is
% interpreted by the used fitness function used in the simulation model.
%
%%
% |[equilibrium, u, fitness, exitflag]= findOptimalEquilibrium(...)|
%
% @return varargout : further optional return values from the optimization
% algorithm, like e.g. the exitflag of the optimization method
%
%% Example
%
% 

clear;

%%

cd( fullfile( getBiogasLibPath(), 'examples/optimization/Gummersbach' ) );

%%
%
%

% [equilibrium, u, fitness, exitflag]= findOptimalEquilibrium('gummersbach', ...
%  'GA', 0, 'multicore', 4, 4, 2);


%% 
%
%
% |[equilibrium, u, fitness]= findOptimalEquilibrium('sunderhook', 'GA')|
%
% |[equilibrium, u, fitness]= findOptimalEquilibrium('sunderhook', 'PSO')|
%
% |[equilibrium, u, fitness]= findOptimalEquilibrium('sunderhook', 'ISRES')|
%

%%
% 
%

if(0)
  
[equilibrium, u, fitness]= findOptimalEquilibrium('gummersbach', 'CMAES', ...
                           [], [], [], 4, 2);

disp(equilibrium)
disp(u)
disp(fitness)

end


%%
% |[equilibrium, u, fitness]= findOptimalEquilibrium('sunderhook', 'DE')|
%
% |[equilibrium, u, fitness]= findOptimalEquilibrium('sunderhook',
% 'ISRES', 0, 'multicore', 4)|
%
% |[equilibrium, u, fitness]= findOptimalEquilibrium('sunderhook', 'PSO',
% 0, 'multicore', 4)| 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc startga">
% optimization_tool/startGA</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startpso">
% optimization_tool/startPSO</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startisres">
% optimization_tool/startISRES</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startcmaes">
% optimization_tool/startCMAES</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startde">
% optimization_tool/startDE</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startpatternsearch">
% optimization_tool/startPatternSearch</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startfmincon">
% optimization_tool/startFMinCon</a>
% </html>
% ,
% <html>
% <a href="matlab:doc load_biogas_mat_files">
% load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc load_biogas_system">
% load_biogas_system</a>
% </html>
% ,
% <html>
% <a href="nonlcon_substrate.html">
% nonlcon_substrate</a>
% </html>
% ,
% <html>
% <a href="nonlcon_plant.html">
% nonlcon_plant</a>
% </html>
% ,
% <html>
% <a href="digester_state_nonlcon.html">
% digester_state_nonlcon</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/getindividualfromequilibrium')">
% biogas_optimization/biogasM.optimization.popBiogas.getIndividualFromEquilibrium</a>
% </html>
% ,
% <html>
% <a href="fitnessfindoptimalequilibrium.html">
% fitnessFindOptimalEquilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/getequilibriumfromindividual')">
% biogas_optimization/biogasM.optimization.popBiogas.getEquilibriumFromIndividual</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/getadm1paramsfromindividual')">
% biogas_optimization/biogasM.optimization.popBiogas.getADM1ParamsFromIndividual</a>
% </html>
% ,
% <html>
% <a href="matlab:doc close_biogas_system">
% close_biogas_system</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_gui/gui_optimization')">
% biogas_gui/gui_optimization</a>
% </html>
%
%% See Also
%
% <matlab:edit('findOptimalEquilibrium.m') edit findOptimalEquilibrium.m>
% ,
% <html>
% <a href="getinitpopofequilibria.html">
% getInitPopOfEquilibria</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nonlinearmpc')">
% biogas_control/nonlinearMPC</a>
% </html>
%
%% TODOs
% # implement cluster option
% # improve documentation
% # a few TODOs
% # parallel option nicht nutzen
%
%% <<AuthorTag_DG/>>


