%% Preliminaries
% This function depends on the
% <http://ls11-www.cs.uni-dortmund.de/rudolph/hypervolume/start |SMS-EMOA|>
% implementation, so this toolbox has to be installed first. The
% installation is already realized with the installation of this toolbox.
%
%% Syntax
%       [paretoset]= startSMSEMOA(fitnessfcn, nObj, u0, LB, UB)
%       [...]= startSMSEMOA(fitnessfcn, nObj, u0, LB, UB, popSize)
%       [...]= startSMSEMOA(fitnessfcn, nObj, u0, LB, UB, popSize, maxIter)
%       [...]= startSMSEMOA(fitnessfcn, nObj, u0, LB, UB, popSize, maxIter,
%       outputGen) 
%       [paretoset, paretofront]= startSMSEMOA(...)
%       [paretoset, paretofront, out]= startSMSEMOA(...)
%
%% Description
% |[paretoset]= startSMSEMOA(fitnessfcn, nObj, u0, LB, UB)| prepares and
% starts SMS-EMOA S-Metric Selection Evolutionary Multiobjective 
% Optimization Algorithm to minimize the given fitness function
% |fitnessfcn|. 
%
%%
% @param |fitnessfcn| : a <matlab:doc('function_handle') function_handle>
% with the objective function, which SMS-EMOA minimizes.
%
%%
% @param |nObj| : number of objectives. double integer scalar. 
%
%%
% @param |u0| : initial population (start point), double matrix. may also
% be empty. If not empty, then number of columns define the dimension of
% the problem and number of rows the number of individuals in the initial
% population. If there are more rows then |popSize|, then the last rows are
% deleted. Not used at the moment. 
%
%%
% @param |LB| : lower bound of the individual, double row or column vector
%
%%
% @param |UB| : upper bound of the individual, double row or column vector
%
%%
% @return |paretoset| : pareto optimal set. double matrix. Number of rows
% equals |popSize|, number of columns equals |nObj|.
%
%%
% @param |popSize| : the population size, double salar integer
%
%%
% @param |maxIter| : the maximal number of iterations (generations).
% Maximal number of evaluations equals: |popSize| * |maxIter|. 
%
%%
% @param |outputGen| : defines if output should be written to files in each
% |outputGen| iteration. Set to 1 for each iteration. Set to inf for no
% output. default: |popSize| * |maxIter| + 1. 
%
%% Example
% 
%

[paretoset, paretofront, out]= ...
  startSMSEMOA(@GSP, 2, [], ones(1,6).*(-50), ones(1,6).*(50), ...
               50, 5000);

%%

scatter(paretofront(:,1), paretofront(:,2))

disp(out)


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
% <a href="setpopsize.html">
% setPopSize</a>
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
%
%% TODOs
% # create docu for script file
% # check documentation
% # ich glaube, dass SMSEMOA nicht damit klar kommt, wenn eine evaluation
% der fitness funktion fehl schlägt und bspw. NaN zurück gegeben wird.
% paretofront berechnung liefert dann NaN zurück. 
% paretofront(pf(all(~isnan(pf), 2),:)); würde nans vor berechnung heraus
% filtern. 
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% M. Emmerich, N. Beume and B. Naujoks: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\smsemoa\\05 An EMO Algorithm Using the Hypervolume Measure as Selection Criterion.pdf'', 
% optimization_tool.getHelpPath())'))">
% An EMO algorithm using the hypervolume measure as selection criterion</a>, 
% Evolutionary Multi-Criterion, 3410, pp. 62-76, 2005
% </li>
% <li> 
% N. Beume, B. Naujoks and M. Emmerich: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\smsemoa\\07 SMS-EMOA - Multiobjective selection based on dominated hypervolume.pdf'', 
% optimization_tool.getHelpPath())'))">
% SMS-EMOA: Multiobjective selection based on dominated hypervolume</a>, 
% European Journal of Operational Research, 181(3), pp. 1653-1669, 2007
% </li>
% <li> 
% N. Beume, B. Naujoks, and G. Rudolph: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\smsemoa\\08 SMS-EMOA - Effektive evolutionaere Mehrzieloptimierung.pdf'', 
% optimization_tool.getHelpPath())'))">
% SMS-EMOA - Effektive evolutionäre Mehrzieloptimierung</a>, 
% at - Automatisierungstechnik, 56(7), pp. 357-364, 2008
% </li>
% </ol>
% </html>
%


