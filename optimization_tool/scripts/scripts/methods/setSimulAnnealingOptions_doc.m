%% Syntax
%       options= setSimulAnnealingOptions(maxIter) 
%       options= setSimulAnnealingOptions(maxIter, timelimit) 
%       options= setSimulAnnealingOptions(maxIter, timelimit, tolerance) 
%
%% Description
% |options= setSimulAnnealingOptions(maxIter)| sets additionally to some
% standard parameters the maximal number of iterations of the Simulated
% Annealing algorithm <matlab:doc('simulannealbnd') simulannealbnd>. The
% standard parameters are: 
%
% * 'PlotFcns', {@saplotbestf , @saplotbestx}
% * 'ObjectiveLimit', -Inf
%
%%
% @param |maxIter| : double scalar defining the maximum number of
% iterations allowed to run, integer
%
%%
% |options= setSimulAnnealingOptions(maxIter, timelimit)| sets furthermore
% the maximal timelimit in seconds before the algorithm stops.
%
%%
% @param |timelimit| : time limit for the whole optimization process in
% seconds, double scalar
%
%%
% |options= setSimulAnnealingOptions(maxIter, timelimit, tolerance)| sets
% the tolerance in the improvement of the fitness function before the
% algorithm terminates.
%
%%
% @param |tolerance| : tolerance in the change of the fitness before ending
% the optimization process, double scalar
%
%% Example
% 

setSimulAnnealingOptions([], 120)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc saoptimset">
% saoptimset</a>
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
% <a href="startsimulannealing.html">
% startFMinCon</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="matlab:doc simulannealbnd">
% simulannealbnd</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


