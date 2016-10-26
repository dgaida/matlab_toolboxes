%% Syntax
%       Deltap= calc_Deltap(pf, approx, p)
%
%% Description
% |Deltap= calc_Deltap(pf, approx, p)| calculates Delta p : "Averaged
% Hausdorff Distance" between pareto front |pf| and an approximation
% |approx|. 
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
% @return |Deltap| : Delta p : "Averaged Hausdorff Distance"
%
%% Example
% 
% 



%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('max')">
% matlab/max</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('optimization_tool/calc_igdp')">
% optimization_tool/calc_IGDp</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('optimization_tool/calc_gdp')">
% optimization_tool/calc_GDp</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
%
% <html>
% <a href="matlab:doc('optimization_tool/startsmsemoa')">
% optimization_tool/startSMSEMOA</a>
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


