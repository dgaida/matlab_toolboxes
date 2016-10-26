%% Syntax
%       options= setFMinSearchOptions(noGenerations) 
%       options= setFMinSearchOptions(noGenerations, tolerance) 
%       options= setFMinSearchOptions(noGenerations, tolerance,
%       OutputFcn)  
%
%% Description
%
% |options= setFMinSearchOptions(noGenerations)| sets the number of generations.
% Furthermore some standard parameters are always set. These are:
% 
% * 'PlotFcns', {@optimplotx}
% * 'Display', 'iter'
%
% Throws an error if the optimization toolbox is not installed. The
% parameters set are used by the <matlab:doc('fminsearch') fminsearch> algorithm.
%
%%
% @param |noGenerations| : number of generations to run, double integer
% scalar 
%
%%
% |options= setFMinSearchOptions(noGenerations, tolerance)|
% sets the tolerance of the fitness value improvement before the
% optimization algorithm terminates.
%
%%
% @param |tolerance| : tolerance in the change of the fitness before ending
% the optimization process, double scalar
%
%%
% |options= setFMinSearchOptions(noGenerations, tolerance, OutputFcn)|
%
%%
% @param |OutputFcn| : <matlab:doc('function_handle') function_handle>
% called during optimisation after one iteration has finished.
%
%% Example
% 

options= setFMinSearchOptions(10);
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
% <a href="startfminsearch.html">
% startFMinSearch</a>
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
% <a href="setfminoptions.html">
% setFMinOptions</a>
% </html>
% ,
% <html>
% <a href="matlab:doc fminsearch">
% matlab/fminsearch</a>
% </html>
% ,
% <html>
% <a href="matlab:doc fmincon">
% matlab/fmincon</a>
% </html>
%
%% TODOs
% # check documentation and script
% # improve documentation
%
%% <<AuthorTag_DG/>>


