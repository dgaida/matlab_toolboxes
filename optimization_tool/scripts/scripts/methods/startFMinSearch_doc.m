%% Preliminaries
% This function depends on the |Optimization
% Toolbox| so this toolbox has to be installed first. 
%
%% Syntax
%       u= startFMinSearch(ObjectiveFunction, u0)
%       u= startFMinSearch(ObjectiveFunction, u0, LB)
%       u= startFMinSearch(ObjectiveFunction, u0, LB, UB)
%       u= startFMinSearch(ObjectiveFunction, u0, LB, UB, noGenerations)
%       startFMinSearch(ObjectiveFunction, u0, LB, UB, noGenerations,
%       tolerance) 
%       startFMinSearch(ObjectiveFunction, u0, LB, UB, noGenerations,
%       tolerance, OutputFcn) 
%       [u, fitness]= startFMinSearch(ObjectiveFunction, u0, ...)
%       [u, fitness, exitflag]= startFMinSearch(ObjectiveFunction, u0, ...)
%       [u, fitness, exitflag, output]= startFMinSearch(ObjectiveFunction, u0, ...)
%
%% Description
% |[u]= startFMinSearch(ObjectiveFunction, u0)| prepares and
% starts <matlab:doc('fminsearch') |fminsearch|> with standard settings to
% minimize given fitness function |ObjectiveFunction|. 
%
% fminsearch uses Nelder-Mead simplex algorithm
%
%%
% @param |ObjectiveFunction| : a <matlab:doc('function_handle') function
% handle> with the objective function, which |fminsearch| minimizes.
%
%%
% @param |u0| : (part of the) initial population. double matrix with number
% of columns equals dimension of the problem and number of rows
% arbitrarily (number of individuals to evaluate). 
%
%%
% @return |u| : optimal individual, row vector
%
%%
% |[u]= startFMinSearch(ObjectiveFunction, u0, LB)|
%
%%
% @param |LB| : lower bound of the individual, double vector
%
%%
% |[u]= startFMinCon(ObjectiveFunction, u0, LB, UB)|
%
%%
% @param |UB| : upper bound of the individual, double vector
%
%%
% |startFMinSearch(ObjectiveFunction, u0, LB, UB, noGenerations)|
%
%%
% @param |noGenerations| : number of generations to run, double scalar
%
%%
% |startFMinSearch(ObjectiveFunction, lenIndividual, LB, UB, noGenerations,
% tolerance)| 
%
%%
% @param |tolerance| : tolerance in the change of the fitness before ending
% the optimization process, double scalar
%
%%
% |startFMinSearch(ObjectiveFunction, lenIndividual, LB, UB, noGenerations,
% tolerance, OutputFcn)| 
%
%%
% @param |OutputFcn| : function handle which is called after one iteration
% is done 
%
%%
% |[u, fitness]= startFMinSearch(ObjectiveFunction, u0, ...)|
%
%%
% @return |fitness| : fitness of the optimal individual
%
%%
% |[u, fitness, exitflag]= startFMinSearch(ObjectiveFunction, u0, ...)|
%
%%
% @return |exitflag| : exitflag of |fmincon|
%
%%
% |[u, fitness, exitflag, output]= startFMinSearch(ObjectiveFunction, u0, ...)|
%
%%
% @return |output| : output message of the optimization algorithm
%
%% Example
% 
%

nvars= 5;

LB= -5.12.*ones(nvars,1);
UB=  5.12.*ones(nvars,1);

maxIter= 75;

[u, fitnessFMin]= startFMinSearch(@fitness_rastrigin, ...
                                  rand(nvars,1)', LB, UB, maxIter);

disp(u)
disp(fitnessFMin)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc fminsearch">
% fminsearch</a>
% </html>
% ,
% <html>
% <a href="setfminsearchoptions.html">
% setFMinSearchOptions</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validatestring')">
% matlab/validatestring</a>
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
% <a href="startde.html">
% startDE</a>
% </html>
% ,
% <html>
% <a href="startcmaes.html">
% startCMAES</a>
% </html>
% ,
% <html>
% <a href="startisres.html">
% startISRES</a>
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
% <a href="fitness_rastrigin.html">
% fitness_rastrigin</a>
% </html>
% ,
% <html>
% <a href="fitness_schwefel.html">
% fitness_schwefel</a>
% </html>
%
%% TODOs
% # Parameterreihenfolge sollte noch mal überdacht werden,
% objfunction,...,A,b,Aeq,beq,LB,UB, und dann die Optionen sollte besser
% sein 
% # Lagere die Überprüfung d. params in eine separete Funktion aus, welche von
% allen Methoden aufgerufen wird.
% # improve documentation a bit
% # check documentation and script
% # Nelder mead paper referenzieren
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% <a href="http://www.mathworks.com/products/global-optimization/index.html?ref=pfo" 
% target="_top">
% Global Optimization Toolbox 3.0
% </li>
% </ol>
% </html>
%


