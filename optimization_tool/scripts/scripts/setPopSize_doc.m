%% Syntax
%       popSize= setPopSize(spacedimension)
%       popSize= setPopSize(spacedimension, maxPopSize)
%
%% Description
% |popSize= setPopSize(spacedimension)| calculates the population size for
% a population based optimization algorithm for a given problem, having the
% given |spacedimension|. 
%
% The needed population size is estimated like this: TODO
%
%%
% @param |spacedimension| : double vector with the range (= max - min) of
% each dimension, where the range is > 0.
%
%%
% @return |popSize| : double scalar with the population size
%
%%
% |popSize= setPopSize(spacedimension, maxPopSize)| lets you set the upper
% boundary for the population size to be returned. 
%
%%
% @param |maxPopSize| : upper boundary for the population size to be
% returned. Default: 75. 
%
%% Example
% 
% Calculate the population size for a 3dim problem with ranges: 10, 20 and
% 1 for the three dimensions. Thus, LB and UB could be like this: 
% 

LB= [0 10 1];
UB= [10 30 2];

spacedimension= UB - LB;

disp(spacedimension)

setPopSize(spacedimension)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('prod')">
% matlab/prod</a>
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
% <a href="matlab:doc('biogas_gui/gui_nmpc')">
% biogas_gui/gui_nmpc</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_gui/gui_optimization')">
% biogas_gui/gui_optimization</a>
% </html>
% ,
% <html>
% <a href="startcmaes.html">
% startCMAES</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('numerics_tool/getoptimalpopulation')">
% numerics_tool/numerics.conRandMatrix.getOptimalPopulation</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('numerics_tool/getvalidsetofpoints')">
% numerics_tool/numerics.conSetOfPoints.getValidSetOfPoints</a>
% </html>
%
%% See Also
%
%
%% TODOs
% # irgendwelche Referenzen finden die so was machen
% # Formel erklären und anzeigen in doku
% # check links in is called by section
%
%% <<AuthorTag_DG/>>
%% References
%
%


