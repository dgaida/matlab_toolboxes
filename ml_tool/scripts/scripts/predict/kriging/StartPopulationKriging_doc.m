%% Syntax
%       [ X ]= StartPopulationKriging(samplingMethod, nov, nosp,
%              vBoundaries)
%
%% Description
% |[ X ]= StartPopulationKriging(samplingMethod, nov, nosp, vBoundaries)| 
% creates the start population for an optimization run using
% different Kriging approximations of ADM1 model
% 
%% 
%
% @param |samplingMethod|    
%                   - indicates how the start combinations for the
%                     simulation model are chosen.
%                     Two Methods are available:
%                     'rectangular Grid'
%                     'latin hypercube'
%
%%
% @param |nov|    	- number of optimization variables
%
%%
% @param |nosp|     - sets the number of simulation points in the search
%                     space
% 
%%
% @param |vBoundaries|
%                   - contains lower and upper boundaries for each variable
%                     in each dimension
%                     
%                     *Example (3 dimensions):* 
%
%                     lower Bounds vBoundaries(1,:)= [10 12 14];
%                     
%                     upper Bounds vBoundaries(2,:)= [20 30 40];
%
%% Example
% 

vBoundaries= [10 12 14; 20 30 40];

X= StartPopulationKriging('latin hypercube', 3, 100, vBoundaries);

scatter3(X(:,1), X(:,2), X(:,3), 's', 'filled');


%% Dependencies
%
% This function calls
%
% <html>
% <a href="lhsampling.html">
% lhSampling</a>
% </html>
% ,
% <html>
% <a href="matlab:edit('gridsamp')">
% edit gridsamp</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% doc validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by
%
% <html>
% ...
% </html>
%
%% See Also
%
% -
%
%% TODOs
% # Rename this method!!! is used in
% numerics.conRandMatrix.getOptimalPopulation, but should be used inside
% conSetOfPoints.getValidSetOfPoints, see TODO there. Then if
% numerics.conRandMatrix is called with an empty solverlist, we have a set
% points which is created using latin hypercube sampling and meet all
% constraints. 
% # improve documentation
%
%% <<AuthorTag_DG/>>


