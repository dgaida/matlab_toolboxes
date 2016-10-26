%% Syntax
%       [u, fitness]= get_optimum_oo_paretofront(paretofront, paretoset,
%       fitness_params) 
%       [u, fitness, index, scalar_min_fitness]= get_optimum_oo_paretofront(...) 
%       
%% Description
% |[u, fitness]= get_optimum_oo_paretofront(paretofront, paretoset,
% fitness_params)| gets optimal individual |u| out of |paretofront|. The
% optimal fitness is a weighted sum of the fitness values of the rows of
% |paretofront|. If the dimension of the problem, equal to number of
% columns of |paretofront|, is not 2, then a warning is thrown. 
%
%%
% @param |paretofront| : double matrix. Rows equals number of individuals
% and number of columns the number of objectives. 
%
%%
% @param |paretoset| : double matrix. Number of rows equals number of
% individuals and number of columns the number of optimization variables. 
%
%% <<fitness_params/>>
%%
% @return |u| : optimal individual. It is a row out of the given
% |paretoset|. 
%
%%
% @return |fitness| : optimal fitness vector corresponding to individual
% |u|. It is a row out of the given |paretofront|. 
%
%%
% @return |index| : index in paretofront which is optimal
%
%%
% @return |scalar_min_fitness| : optimal fitness value as scalar
%
%% Example
%
%

pf= randn(10, 2);
ps= rand(10, 3);

disp(pf)
disp(ps)

fitparams= load_fitness_params('gummersbach');

[u, fitness, index, scalar_min_fitness]= ...
  get_optimum_oo_paretofront(pf, ps, fitparams);

disp(u)
disp(fitness)
disp(index)
disp(scalar_min_fitness)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/isrnm">
% script_collection/isRnm</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_fitness_params">
% biogas_scripts/is_fitness_params</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/min">
% matlab/min</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_optimization/findoptimalequilibrium">
% biogas_optimization/findOptimalEquilibrium</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc biogas_optimization/fitnessfindoptimalequilibrium">
% biogas_optimization/fitnessFindOptimalEquilibrium</a>
% </html>
%
%% TODOs
% # improve documentation a bit
% # check code, solve TODOs
% # only works for 2 dim objective function
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


