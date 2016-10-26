%% Syntax
%       [paretoset]= startSMSEGO(fitnessfcn, LB, UB)
%       [...]= startSMSEGO(fitnessfcn, LB, UB, maxIter)
%       [paretoset, paretofront]= startSMSEGO(...)
%       [paretoset, paretofront, models]= startSMSEGO(...)
%       [paretoset, paretofront, models, {parameters, objectives, eval}]=
%       startSMSEGO(...) 
%
%% Description
% |[paretoset]= startSMSEGO(fitnessfcn, LB, UB)| minimizes the given
% objective function |fitnessfcn| using SMS-EGO S-Metric Selection based
% Efficient Global Optimization for multi-objective optimization problems
% between the lower and upper boundaries |LB| and |UB|, respectively. 
%
%%
% @param |fitnessfcn| : a <matlab:doc('function_handle') function_handle>
% with the objective function, which SMS-EGO minimizes.
%
%%
% @param |LB| : lower bound of the individual, double row or column vector
%
%%
% @param |UB| : upper bound of the individual, double row or column vector
%
%%
% @return |paretoset| : pareto optimal set
%
%%
% @param |maxIter| : the maximal number of iterations / generations
%
%%
% @return |paretofront| : pareto optimal front belonging to returned pareto
% optimal set. 
%
%%
% @return |models| : cell array of final Kriging models. For each dimension
% one Kriging model is created, thus the dimension of the cell array is
% equal to the dimension of the optimization problem. 
%
%%
% @return |{parameters, objectives, eval}| : cell of the three returned
% objectives:
%
% * |parameters| : all evaluated individuals. individuals are row vectors,
% this is a matrix with as many rows as |maxIter|. 
% * |objectives| : all evaluated objectives. objectives are row vectors,
% this is a matrix with as many rows as |maxIter|. 
% * |eval| : 
%
%% Example
% 
%

%% TODO
% SMS-EGO bleibt häufig bei calculate initial sampling hängen, Grund ist
% mir nicht klar. jetzt ok, vorher falsche boundaries gesetzt, s. pdf zu
% OKA2, immer noch nicht ok, bleibt in evaluateEntropy, JCS_LHSOptimizer
% hängen, jetzt aber, vorher war das problem, dass LHS zu wenig punkte
% hatte

[paretoset, paretofront, models, stuff]= ...
  startSMSEGO(@OKA2, [-pi, -5, -5], [pi 5 5], 40);

%%

disp(paretoset)

scatter(paretofront(:,1), paretofront(:,2), '.')

disp(models)

disp(stuff)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="setparallelconfiguration.html">
% setParallelConfiguration</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/existmpfile')">
% script_collection/existMPfile</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('findoptimalequilibrium')">
% findOptimalEquilibrium</a>
% </html>
%
%% See Also
%
% <html>
% <a href="startpso.html">
% startPSO</a>
% </html>
% ,
% <html>
% <a href="startpatternsearch.html">
% startPatternSearch</a>
% </html>
% ,
% <html>
% <a href="startga_patternsearch.html">
% startGA_PatternSearch</a>
% </html>
% ,
% <html>
% <a href="startga.html">
% startGA</a>
% </html>
% ,
% <html>
% <a href="startde.html">
% startDE</a>
% </html>
% ,
% <html>
% <a href="startsimulannealing.html">
% startSimulAnnealing</a>
% </html>
% ,
% <html>
% <a href="startisres.html">
% startISRES</a>
% </html>
% ,
% <html>
% <a href="startcmaes.html">
% startCMAES</a>
% </html>
% ,
% <html>
% <a href="startfmincon.html">
% startFMinCon</a>
% </html>
% ,
% <html>
% <a href="startstdpsokriging.html">
% startStdPSOKriging</a>
% </html>
% ,
% <html>
% <a href="startpsokriging.html">
% startPSOKriging</a>
% </html>
% ,
% <html>
% <a href="startsmsemoa.html">
% startSMSEMOA</a>
% </html>
%
%% TODOs
% # create docu for script file
% # improve documentation a bit
% 
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% W. Ponweiser, T. Wagner, D. Biermann and M. Vincze: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\smsego\\08 MO on a Limited Budget of Evaluations using Model-Assisted.pdf'', 
% optimization_tool.getHelpPath())'))">
% Multiobjective Optimization on a Limited Budget of Evaluations using Model-Assisted S-Metric Selection</a>, 
% PPSN X, LNCS 5199, pp. 784-794, 2008
% </li>
% <li> 
% T. Wagner, M. Emmerich, A. Deutz and W. Ponweiser: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\smsego\\10 On EI Criteria for Model-based MOO.pdf'', 
% optimization_tool.getHelpPath())'))">
% On Expected-Improvement Criteria for Model-based Multi-objective Optimization</a>, 
% PPSN XI, Part I, LNCS 6238, pp. 718-727, 2010
% </li>
% <li> 
% T. Okabe, Y. Jin, M. Olhofer and B. Sendhoff: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\smsego\\okabe04b.pdf'', 
% optimization_tool.getHelpPath())'))">
% On Test Functions for Evolutionary Multi-Objective Optimization</a>, 
% Parallel Problem Solving from Nature, pp. 792-802, 2004
% </li>
% </ol>
% </html>
%


