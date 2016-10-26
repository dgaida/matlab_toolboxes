%% Syntax
%       [fitness]= fitness_rastrigin(x)
%       [fitness, linearconstraints]= fitness_rastrigin(x)
%
%% Description
% |[fitness]= fitness_rastrigin(x)| evaluates the generalized n-dimensional
% Rastrigin's function at |x|. The function is defined as:
%
% $$f(x) := \sum_{i= 1}^{cols(x)} \left[ x_i^2 - 10 cos(2 \pi x_i) + 10 \right]$$
%
% $$-5.12 \leq x_i \leq 5.12$$
%
%%
% @param |x| : double scalar or n-dimensional double row vector. You also
% can pass a matrix, where the number of rows defines the number of
% particles, respectively number of evaluations which have to be evaluated
% at the same time. Thus, the column size always defines the dimension of the
% problem. 
%
%%
% @return |fitness| : fitness at |x|, a double value. When |x| is a matrix,
% then |fitness| is a double vector of the dimension equal to the number of
% rows of |x|.
%
%%
% |[fitness, linearconstraints]= fitness_rastrigin(x)| evaluates the
% generalized n-dimensional Rastrigin's function at |x|.
%
%%
% @return |linearconstraints| : is needed by some optimization
% algorithms. Here it is just a zero value or a "number of
% rows(|x|)"-dimensional zero vector. 
%
%% Example
%
% # Solve generalized Rastrigin's Function using
% <matlab:doc('optimization_tool/startga') Genetic Algorithms> 

nvars= 5;

LB= -5.12.*ones(nvars,1);
UB= 5.12.*ones(nvars,1);

popSize= 75;
maxIter= 75;

%%

tic

[u, fitnessGA]= startGA(@fitness_rastrigin, ...
                        nvars, LB, UB, [], popSize, maxIter);
    
disp(u);
disp(fitnessGA);

toc

%%
% # Solve generalized Rastrigin's Function using
% <matlab:doc('optimization_tool/startcmaes') CMA Evolution Strategy> 

tic

[u, fitnessCMAES]= startCMAES(@fitness_rastrigin, ...
                              [], LB, UB, popSize, maxIter);

disp(u);
disp(fitnessGA);

toc

%%
% # Solve generalized Rastrigin's Function using
% <matlab:doc('optimization_tool/startpso') Particle Swarm Optimization>

tic

[u, fitnessPSO]= startPSO(@fitness_rastrigin, ...
                          nvars, LB, UB, [], popSize, maxIter);
                        
disp(u);
disp(fitnessGA);

toc

%%
% # Solve generalized Rastrigin's Function using
% <matlab:doc('optimization_tool/startde') Differential Evolution> 

tic

[u, fitnessDE]= startDE(@fitness_rastrigin, ...
                        nvars, LB, UB, [], popSize, maxIter);

disp(u);
disp(fitnessGA);

toc

%%
% # Solve generalized Rastrigin's Function using
% <matlab:doc('optimization_tool/startpatternsearch') Pattern Search>

tic

[u, fitnessPS]= startPatternSearch(@fitness_rastrigin, ...
                                   [], LB, UB, maxIter);

disp(u);
disp(fitnessGA);

toc

%%
% # Solve generalized Rastrigin's Function using
% <matlab:doc('optimization_tool/startsimulannealing') Simulated Annealing>

tic

[u, fitnessSA]= startSimulAnnealing(@fitness_rastrigin, ...
                                    [], LB, UB, maxIter);

disp(u);
disp(fitnessGA);

toc

%%
% # Solve generalized Rastrigin's Function using
% <matlab:doc('optimization_tool/startisres') Improved Stochastic 
% Ranking Evolution Strategy> 

tic

[u, fitnessISRES]= startISRES(@fitness_rastrigin, ...
                              LB, UB, [], popSize, maxIter);

disp(u);
disp(fitnessGA);

toc
                            
%%
% Plot generalized Rastrigin's Function

[X, Y]= meshgrid(-5.12:0.05:5.12, -5.12:0.05:5.12);

Xv= X(:);
Yv= Y(:);
Zv= fitness_rastrigin([Xv, Yv]);

Z= reshape(Zv, size(Y,1), size(X,1));

figure
surface(X, Y, Z);
shading interp;
view(3);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/summary">
% script_collection/summary</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% <html>
% <a href="fitness_schwefel.html">
% fitness_schwefel</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startcmaes">
% optimization_tools/startCMAES</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startga">
% optimization_tools/startGA</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startpso">
% optimization_tools/startPSO</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startisres">
% optimization_tools/startISRES</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startde">
% optimization_tools/startDE</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startsimulannealing">
% optimization_tools/startSimulAnnealing</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startpatternsearch">
% optimization_tools/startPatternSearch</a>
% </html>
%
%% TODOs
% # do documentation for script file
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% Mezura-Montes, E., Velázquez-Reyes, J. and Coello Coello, C.A.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\06 A Comparative Study of Differential Evolution Variants for Global Optimization.pdf'', 
% optimization_tool.getHelpPath())'))">
% A Comparative Study of Differential Evolution Variants for Global Optimization</a>, GECOO'06,
% 2006
% </li>
% </ol>
% </html>
%


