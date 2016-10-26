%% Syntax
%       [fitness]= fitness_schwefel(x)
%       [fitness, linearconstraints]= fitness_schwefel(x)
%
%% Description
% |[fitness]= fitness_schwefel(x)| evaluates the n-dimensional
% Schwefel Problem 2.21 at |x|. The function is defined as:
%
% $$f(x) := max_i{|x_i|, 1 \leq i \leq cols(x)}$$
%
% $$-100 \leq x_i \leq 100$$
%
%%
% @param |x| : double scalar or n-dimensional double row vector. You also
% can pass a matrix, where the number of rows defines the number of
% particles, respectively number of evaluations which have to be evaluated
% at the same time. Thus the column size always defines the dimension of the
% problem. 
%
%%
% @return |fitness| : fitness at |x|, a double value. When |x| is a matrix,
% then |fitness| is a double vector of the dimension equal to the number of
% rows of |x|.
%
%%
% |[fitness, linearconstraints]= fitness_schwefel(x)| evaluates the
% n-dimensional Schwefel Problem 2.21 at |x|.
%
%%
% @return |linearconstraints| : is needed by some optimization algorithms.
% Here it is just a zero value or a "number of 
% rows(|x|)"-dimensional zero vector. 
%
%% Example
%
% # Solve Schwefel's Problem 2.21 using <matlab:doc('startga') Genetic
% Algorithms>

nvars= 5;

LB= -100.*ones(nvars,1);
UB=  100.*ones(nvars,1);

popSize= 75;
maxIter= 75;

%%

tic

[u, fitnessGA]= startGA(@fitness_schwefel, ...
                        nvars, LB, UB, [], popSize, maxIter);
    
disp(u);
disp(fitnessGA);

toc


%%
% Plot Schwefel's Problem 2.21

[X, Y]= meshgrid(-5:0.1:5, -5:0.1:5);

Xv= X(:);
Yv= Y(:);
Zv= fitness_schwefel([Xv, Yv]);

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
% <a href="fitness_rastrigin.html">
% fitness_rastrigin</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startcmaes">
% optimization_tool/startCMAES</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startga">
% optimization_tool/startGA</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startpso">
% optimization_tool/startPSO</a>
% </html>
% ,
% <html>
% <a href="matlab:doc startisres">
% optimization_tool/startISRES</a>
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


