%% Syntax
%       [fitness]= numerics.conSetOfPoints.fitnessSatisfyContraints(obj, u,
%       popSize) 
%       [fitness]= numerics.conSetOfPoints.fitnessSatisfyContraints(obj, u,
%       popSize, A, b) 
%       [fitness]= numerics.conSetOfPoints.fitnessSatisfyContraints(obj, u,
%       popSize, A, b, nonlcon) 
%       [fitness, linconstraints]=
%       numerics.conSetOfPoints.fitnessSatisfyContraints(...) 
%
%% Description
% |[fitness]= numerics.conSetOfPoints.fitnessSatisfyContraints(obj, u,
% popSize)| evaluates the 
% individual |u| with respect to constraints. |u| is assumed to be
% representing a set of row vectors, which are concatenated to one row
% vector. Thus, |numel(u)/popSize| defines the dimension of each one of
% these vectors and |popSize| the number of vectors in the set. As
% boundaries lower and upper bounds defined in |obj| are 
% checked. Furthermore |A,b| and |nonlcon| are checked if they are passed
% to this function. 
%
%% 
% @param |obj| : object of the class <consetofpoints.html
% |numerics.conSetOfPoints|>
%
%%
% @param |u| : individual. double row vector, whose length must be a
% multiple of |popSize|. This is because all |popSize| row vectors inside 
% the dataset are concatenated to form this vector |u|. 
%
%%
% @param |popSize| : scalar double integer defining the population size of
% the dataset. This is the number of row vectors in the dataset. 
%
%%
% @return |fitness| : 0, if |u| satisfies all boundaries, else a positive
% number. Each not satisfied boundary is reflected with a number of |1e4|,
% which is summed up to build the |fitness| value. 
%
%%
% |[fitness]= fitnessSatisfyContraints(obj, u, popSize, A, b)| define linear
% inequality constraint matrix |A| and vector |b|.
%
%%
% @param |A| : double matrix of the inequality constraint $A \cdot x \leq
% b$. The number of columns of |A| must be equal to |numel(u)| and the
% number of rows define the number of constraints defined by |A|. 
%
%%
% @param |b| : double column vector of the inequality constraint $A \cdot x
% \leq b$. The number of elements must be equal to the row-size of |A|. 
%
%%
% |[fitness]= fitnessSatisfyContraints(obj, u, popSize, A, b, nonlcon)|
% lets you define |nonlcon|, which is a <matlab:doc('function_handle')
% function_handle> defining nonlinear (in-)equality constraints.
%
%%
% @param |nonlcon| : <matlab:doc('function_handle') function_handle>
% defining a nonlinear constraint. The first value returned by
% the function defines the inequality constraint, the second value the
% equality constraint. 
%
%%
% |[fitness, linconstraints]= fitnessSatisfyContraints(...)| additionally
% returns the evaluated linear inequality constraints. These are used by
% some optimization methods.
%
%%
% @return |linconstraints| : evaluated linear inequality constraints, which
% is a column vector with the size of |numel(u)|. 
%
%% Example
%
%
%% Dependencies
%
% This method calls:
%
% <html>
% <a href="getpointsinfulldimension.html">
% numerics.conSetOfPoints.getPointsInFullDimension</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/feval')">
% matlab/feval</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="getvalidsetofpoints.html">
% numerics.conSetOfPoints.private.getValidSetOfPoints</a>
% </html>
%
%% See Also
%
% <html>
% <a href="consetofpoints.html">
% numerics.conSetOfPoints</a>
% </html>
%
%% TODOs
% # die frage ist ob |u| alle elemente des datensatzes enthalten muss, oder
% ob es nicht sinnvoller ist, alle elemente des datensatzes einzeln auf
% boundaries zu überprüfen. damit wäre es auch möglich, elemente eines
% datensatzes im vorherein zu behalten falls diese schon die rb's erfüllen.
% ist das nicht möglich in dem man den optimierungsmethoden eine
% startpopulation übergibt?
% # sollten boundaries evtl. nicht mit 1e4 bestraft werden, sondern mit
% einem vorgebbaren Wert?
%
%% <<AuthorTag_DG/>>


