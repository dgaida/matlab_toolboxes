%% Syntax
%       X= lhSampling(nosp, nod, lob, upb)
%
%% Description
% |X= lhSampling(nosp, nod, lob, upb)| creates |nosp| sample points lying
% in a |nod| dimensional space, bounded by |lob| and |upb| using latin
% hypercube sampling method. 
%
%%
% @param |nosp|    - number of sample points, double scalar
%  
%%
% @param |nod|     - number of dimensions, double scalar
%
%%
% @param |lob|     - lower bound for each dimension, double vector
% 
%%
% @param |upb|     - upper bound for each dimension, double vector
% 
%% Example
% 
% 

X= lhSampling(100, 3, [10 12 14], [20 30 40]);

axis tight

scatter3(X(:,1), X(:,2), X(:,3), 's', 'filled');

            
%% Dependencies
%
% This function calls
%
% <html>
% <a href="matlab:doc('ml_tool/lhsamp')">
% ml_tool/lhsamp</a>
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
% <a href="startpopulationkriging.html">
% StartPopulationKriging</a>
% </html>
%
%% See Also
%
% -
%
%% TODOs
% # make documentation for script file
% # solve TODO inside file
%
%% <<AuthorTag_DG/>>


