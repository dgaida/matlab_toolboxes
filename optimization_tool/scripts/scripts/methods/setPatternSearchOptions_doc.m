%% Syntax
%       options= setPatternSearchOptions(maxIter) 
%       options= setPatternSearchOptions(maxIter, timelimit) 
%       options= setPatternSearchOptions(maxIter, timelimit, tolerance) 
%       options= setPatternSearchOptions(maxIter, timelimit, tolerance,
%       searchMethod) 
%
%% Description
% |options= setPatternSearchOptions(maxIter)| sets besides some standard
% parameters of the <matlab:doc('patternsearch') |patternsearch|> algorithm
% the maximal number of iterations, before the algorithm terminates. The
% standard parameters are: 
%
% * 'PlotFcns', {@psplotbestf , @psplotbestx}
% * 'UseParallel', 'always'
%
%%
% @param |maxIter| : double integer scalar defining the maximum number of
% iterations allowed to run
%
%%
% |options= setPatternSearchOptions(maxIter, timelimit)| additionally sets
% the timelimit in seconds, before the algorithm exits.
%
%%
% @param |timelimit| : time limit for the whole optimization process in
% seconds, double scalar
%
%%
% |options= setPatternSearchOptions(maxIter, timelimit, tolerance)| sets
% the tolerance of the fitness value improvement, before the algorithm
% quits.
%
%%
% @param |tolerance| : tolerance in the change of the fitness before ending
% the optimization process, double scalar
%
%%
% |options= setPatternSearchOptions(maxIter, timelimit, tolerance,
% searchMethod)| sets the type of search used in pattern search.
%
%%
% @param |searchMethod| : <matlab:doc('function_handle') function_handle>
% with the search method:
% 
% * @GPSPositiveBasis2N
% * @GPSPositiveBasisNp1
% * @GSSPositiveBasis2N
% * @GSSPositiveBasisNp1 
% * @MADSPositiveBasis2N 
% * @MADSPositiveBasisNp1 
% * @searchga 
% * @searchlhs 
% * @searchneldermead     
%
%% Example
% 

setPatternSearchOptions([], 120)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc psoptimset">
% matlab/psoptimset</a>
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
% <a href="startpatternsearch.html">
% startPatternSearch</a>
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
% <a href="matlab:doc patternsearch">
% matlab/patternsearch</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


