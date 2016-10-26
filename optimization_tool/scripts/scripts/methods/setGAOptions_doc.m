%% Syntax
%       options= setGAOptions(u0) 
%       options= setGAOptions(u0, popSize) 
%       options= setGAOptions(u0, popSize, noGenerations) 
%       options= setGAOptions(u0, popSize, noGenerations,
%       timelimit) 
%       options= setGAOptions(u0, popSize, noGenerations,
%       timelimit, tolerance) 
%       options= setGAOptions(u0, popSize, noGenerations,
%       timelimit, tolerance, OutputFcn) 
%
%% Description
% |options= setGAOptions(u0)| sets some standard options for the
% <matlab:doc('ga') |ga|> algorithm, and further the initial population
% |u0|. The standard options are: 
%
% * 'PlotFcns', {@gaplotbestf , @gaplotbestindiv}
% * 'Display', 'iter'
% * 'UseParallel', 'always'
% * 'FitnessLimit', -Inf
% 
%%
% @param |u0| : initial population, which is a double matrix. Number of
% columns equal to dimension of the problem and number of rows equal to
% number of individuals in the initial population.
%
%%
% |options= setGAOptions(u0, popSize)| furthermore sets the population
% size.
%
%%
% @param |popSize| : double scalar defining the size of the population,
% integer
%
%%
% |options= setGAOptions(u0, popSize, noGenerations)| additionally sets the
% number of generations.
%
%%
% @param |noGenerations| : double scalar defining the number of generations
% to run, integer
%
%%
% |options= setGAOptions(u0, popSize, noGenerations, timelimit)| sets the
% time limit in seconds the total optimization process may last.
%
%%
% @param |timelimit| : time limit for the whole optimization process in
% seconds, double scalar
%
%%
% |options= setGAOptions(u0, popSize, noGenerations, timelimit, tolerance)|
% sets the tolerance of the fitness value improvement before the
% optimization algorithm terminates.
%
%%
% @param |tolerance| : tolerance in the change of the fitness before ending
% the optimization process, double scalar
%
%%
% |options= setGAOptions(u0, popSize, noGenerations, timelimit, tolerance,
% OutputFcn)| 
%
%%
% @param |OutputFcn| : <matlab:doc('function_handle') function_handle>
% called during optimisation after one iteration has finished.
%
%% Example
% 

setGAOptions([], 10)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc gaoptimset">
% gaoptimset</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
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
% <a href="startga.html">
% startGA</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="startga_patternsearch.html">
% startGA_PatternSearch</a>
% </html>
% ,
% <html>
% <a href="matlab:doc ga">
% matlab/ga</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


