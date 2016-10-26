%% Syntax
%       [IGD]= calc_IGDp(pf, approx, p)
%
%% Description
% |[IGD]= calc_GDp(pf, approx, p)| calculates modified inverted generational
% distance between pareto front |pf| and an approximation |approx|. 
%
%%
% @param |pf| : pareto front. A double matrix, where the numbe rof columns
% is the dimension of the space and the number of rows the number of pareto
% optimal points. 
%
%%
% @param |approx| : approximation of pareto front. Must have the same
% dimension as the given pareto front |pf|. 
%
%%
% @param |p| : 
%
%%
% @return |IGD| : modified inverted generational distance
%
%% Example
% 
% 



%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('min')">
% matlab/min</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('repmat')">
% matlab/repmat</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('numerics_tool/numerics.math.edist')">
% numerics_tool/numerics.math.edist</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('optimization_tool/calc_deltap')">
% optimization_tool/calc_Deltap</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc('optimization_tool/calc_gdp')">
% optimization_tool/calc_GDp</a>
% </html>
%
%% TODOs
% # improve documentation
% # add example
% # add equation
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% O. Schütze, X. Esquivel, A. Lara, and C. A. C. Coello: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\Using the Averaged Hausdorff Distance.pdf'', 
% optimization_tool.getHelpPath())'))">
% Using the Averaged Hausdorff Distance as a Performance Measure in
% Evolutionary Multiobjective Optimization</a>, 
% IEEE Transactions on Evolutionary Computation, 16(4):504–522, Aug. 2012
% </li>
% </ol>
% </html>
%


