%% Preliminaries
% # This function depends on the MATLAB Kriging Toolbox DACE
% <http://www2.imm.dtu.dk/~hbn/dace/>
% so this toolbox has to be installed first. 
%
%% Syntax
%       [model_opt, theta_opt, fitness]= ...
%        findOptimalKrigingModel(method, inputs, outputs)
%       [...]= findOptimalKrigingModel(method, inputs, outputs,
%       validSet_index) 
%       [...]= findOptimalKrigingModel(method, inputs, outputs,
%       validSet_index, LB) 
%       [...]= findOptimalKrigingModel(method, inputs, outputs,
%       validSet_index, LB, UB) 
%       [...]= findOptimalKrigingModel(method, inputs, outputs,
%       validSet_index, LB, UB, parallel)
%       [...]= findOptimalKrigingModel(method, inputs, outputs,
%       validSet_index, LB, UB, parallel, nWorker) 
%       [...]= findOptimalKrigingModel(method, inputs, outputs,
%       validSet_index, LB, UB, parallel, nWorker, pop_size) 
%       [...]= findOptimalKrigingModel(method, inputs, outputs,
%       validSet_index, LB, UB, parallel, nWorker, pop_size, nGenerations) 
%
%% Description
% |[model_opt, theta_opt, fitness]= findOptimalKrigingModel(method, inputs,
% outputs)| creates an optimal Kriging model fitting to the data |outputs|=
% F(|inputs|). Therefore the parameter |theta| is optimized using 5-fold
% cross-correlation and the optimization method |method|. Please pay
% attention to the fact, that the data is splitted randomly into the 5
% folds (to avoid this see the argument |validSet_index|)! 
%
%%
% @param |method|     : char with the id of the global, stochastic
% optimization method. TODO: At the moment only CMAES and PSO are
% implemented in this function. 
%
% * 'GA'    : <matlab:doc('ga') genetic algorithms> using MATLAB's |Genetic
% Algorithm and Direct Search Toolbox|
% T(TM)
% * 'PSO'   : particle swarm optimization using the MATLAB toolbox 
% <http://www.mathworks.com/matlabcentral/fileexchange/7506-particle-swarm-optimization-toolbox 
% PSOt> by Brian Birge.
% * 'ISRES' : "Improved" Evolution Strategy using Stochastic Ranking using
% the <http://www3.hi.is/~tpr/index.php?page=software/sres/sres |ISRES|>
% toolbox.
% * 'DE' : <http://www.icsi.berkeley.edu/~storn/code.html Differential
% Evolution>
% * 'CMAES' : Covariance Matrix Adaptation Evolution Strategy using the
% <http://www.lri.fr/~hansen/cmaes_inmatlab.html |CMA-ES|> implementation
% * 'PS' : <matlab:doc('patternsearch') Pattern Search> using MATLAB's
% |Genetic Algorithm and Direct Search Toolbox|
% * ...
%
% The toolbox to which the method belongs to, has to be installed first.
%
%%
% @param |inputs| : Contains the input variables for the interpolation. The
% column number defines the dimension of the set, the number of rows the
% number of samples. 
%
%%
% @param |outputs| : Contains one or several output variables to
% interpolate.  The column number defines the dimension of the set, the
% number of rows the number of samples. Must have the same number of rows
% as |inputs|, otherwise an error is thrown. 
%
%%
% @return |model_opt| : optimal Kriging model
%
%%
% @return |theta_opt| : theta of optimal Kriging model
%
%%
% @return |fitness| : fitness of optimal Kriging model
%
%%
% |[...]= findOptimalKrigingModel(method, inputs, outputs, validSet_index)|
% lets you specify which element belongs to which set of the k-fold cross
% validation. If you do not pass this argument, then a 5-fold cross
% validation is performed and the data is divided randomly into the 5 sets.
%
%%
% @param |validSet_index| : vector defining which elements belong to which
% set of the k-fold cross validation. It ranges from 1 to k and has as many
% elements as has |inputs| rows. 
%
%%
% |[...]= findOptimalKrigingModel(method, inputs, outputs, validSet_index,
% LB)| lets you specify the lower boundary of the parameter |theta| used
% during optimization. Default: 1e-3. 
% 
%%
% @param |LB| : lower boundary for the Kriging model parameter $theta$.
% $theta$ is a vector with same dimension as has |inputs|. Thus |LB| must
% have same number of elements as |inputs| has columns. In case you want to
% work without a lower boundary set |LB| to |[]|. 
%
%%
% |[...]= findOptimalKrigingModel(method, inputs, outputs, validSet_index,
% LB, UB)| lets you specify the upper boundary of the parameter |theta|
% used during optimization. Default: 20. 
% 
%%
% @param |UB| : upper boundary for the Kriging model parameter $theta$.
% $theta$ is a vector with same dimension as has |inputs|. Thus |UB| must
% have same number of elements as |inputs| has columns. In case you want to
% work without a upper boundary set |UB| to |[]|. 
%
%%
% |[...]= findOptimalKrigingModel(method, inputs, outputs, validSet_index,
% LB, UB, parallel)| lets you solve the optimization problem in parallel. 
% 
%%
% @param |parallel| : Since the optimization process is quite complex it is 
% possible to distribute the work to a bunch of computers or processors to 
% solve the optimization problem in parallel. The standard value is 'none'.
%
% * 'none'          : use one single processor, no parallel computing
% * 'multicore'     : parallel computing using a multicore processor on one
% PC.
% * 'cluster'       : using Parallel Computing Toolbox functions and MATLAB
% Distributed Computing Server on a computer cluster, such that a number of
% computers can work on the problem. (Not yet working)
%
%%
% |[...]= findOptimalKrigingModel(method, inputs, outputs, validSet_index,
% LB, UB, parallel, nWorker)| lets you specify the number of workers, when
% running in parallel. 
% 
%%
% @param |nWorker|    : number of workers to run in parallel : 
% 2 for a dual core, 4 for a quadcore, when using with 'multicore', else
% number of computers (workers) in the cluster. The standard value is 2,
% when using parallel computing, else 1.
%
%%
% |[...]= findOptimalKrigingModel(method, inputs, outputs, validSet_index,
% LB, UB, parallel, nWorker, pop_size)| lets you define the population size
% of the used optimization method |method|. Default: 7. 
% 
%%
% @param |pop_size| : double scalar defining the population size of the
% optimization method |method|. 
%
%%
% |[...]= findOptimalKrigingModel(method, inputs, outputs, validSet_index,
% LB, UB, parallel, nWorker, pop_size, nGenerations)| lets you define the
% number of generations the used optimization method |method| runs.
% Default: 3. 
% 
%%
% @param |nGenerations| : double scalar defining the number of generations
% of the optimization method |method|. 
%
%% Example
%
% 

data= load_file('data_to_plot.mat');

inputs= [double(data(:, 8)), double(data(:, 2)), double(data(:, 3))];

outputs= double(data(:, end));

[model_opt, theta_opt, fitness]= findOptimalKrigingModel('CMAES', inputs, outputs);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="fitness_kriging.html">
% fitness_kriging</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('optimization_tool/startpso')">
% optimization_tool/startPSO</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('optimization_tool/startcmaes')">
% optimization_tool/startCMAES</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% doc validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validatestring')">
% doc validatestring</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('randi')">
% doc randi</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="evaluate_kriging.html">
% evaluate_kriging</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc(data_tool/plot3dsurface_alpha')">
% data_tool/plot3dsurface_alpha</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('cvpartition')">
% matlab/cvpartition</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('crossval')">
% matlab/crossval</a>
% </html>
%
%% TODOs
% # improve documentation and create it for script
% # add reference
% # add further optimization methods
%
%% <<AuthorTag_DG/>>
%% References
% # 
%
% http://sumo.intec.ugent.be/?q=SUMO_toolbox
%


