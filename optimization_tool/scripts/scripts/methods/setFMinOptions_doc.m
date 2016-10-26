%% Syntax
%       options= setFMinOptions(noGenerations) 
%       options= setFMinOptions(noGenerations, timelimit) 
%       options= setFMinOptions(noGenerations, timelimit, tolerance) 
%       options= setFMinOptions(noGenerations, timelimit, tolerance,
%       OutputFcn)  
%
%% Description
%
% |options= setFMinOptions(noGenerations)| sets the number of generations.
% Furthermore some standard parameters are always set. These are:
% 
% * 'PlotFcns', {@optimplotx}
% * 'Display', 'iter'
% * 'UseParallel', 'always'
% * 'ObjectiveLimit', -Inf
% * 'Algorithm', 'interior-point'
%
% Throws an error if the optimization toolbox is not installed. The
% parameters set are used by the <matlab:doc('fmincon') fmincon> algorithm.
%
%%
% @param |noGenerations| : number of generations to run, double integer
% scalar 
%
%%
% |options= setFMinOptions(noGenerations, timelimit)| sets the
% time limit in seconds the total optimization process may last.
%
%%
% @param |timelimit| : time limit for the whole optimization process in
% seconds, double scalar
%
%%
% |options= setFMinOptions(noGenerations, timelimit, tolerance)|
% sets the tolerance of the fitness value improvement before the
% optimization algorithm terminates.
%
%%
% @param |tolerance| : tolerance in the change of the fitness before ending
% the optimization process, double scalar
%
%%
% |options= setFMinOptions(noGenerations, timelimit, tolerance, OutputFcn)|
%
%%
% @param |OutputFcn| : <matlab:doc('function_handle') function_handle>
% called during optimisation after one iteration has finished.
%
%% Example
% 

options= setFMinOptions(10);
disp(options)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc optimset">
% optimset</a>
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
% <a href="startfmincon.html">
% startFMinCon</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="startga.html">
% startGA</a>
% </html>
% ,
% <html>
% <a href="startga_patternsearch.html">
% startGA_PatternSearch</a>
% </html>
% ,
% <html>
% <a href="matlab:doc fmincon">
% matlab/fmincon</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


