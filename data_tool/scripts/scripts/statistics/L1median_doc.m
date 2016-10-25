%% Syntax
%        [mX]= L1median(X)
%        [mX]= L1median(X, tol)
%
%% Description
% |[mX]= L1median(X)| computes the L1-median (multivariate L1-median) of
% matrix |X|. 
%
%%
% @param |X| : double matrix (n,p), data matrix n-objects, p-variables
%
%%
% |[mX]= L1median(X, tol)| lets you specify the convergence criterion of
% the algorithm. 
%
%%
% @param |tol| : double scalar, the convergence criterion (if not specified
% tol=1.e-08) 
%
%%
% @return |mX| : vector (1,p), the L1-median
%
%% Example
% # Load data from a substrate feed optimization scenario for a biogas
% plant, select columns 2 to 8 (substrate feed) and last column (fitness
% value). 
% 

dataAnalysis= load_file('data_to_plot.mat');

X= double(dataAnalysis);
X= [X(:,2:8), X(:,end)];

L1median(X)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('sortrows')">
% matlab/sortrows</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc numerics_tool/norme">
% numerics_tool/numerics.math.norme</a>
% </html>
%
% and is called by:
%
%
%
%% See Also
%
% <html>
% <a href="matlab:doc('median')">
% matlab/median</a>
% </html>
%
%% TODOs
% # improve documentation
% # understand script
%
%% Author & Copyright
% 
% <html>
% <ol>
% <li> 
% M. Daszykowski, S. Serneels, K. Kaczmarek, P. Van Espen, C. Croux, B. Walczak: 
% <a href="matlab:feval(@open, eval('sprintf(''%s\\pdfs\\2007 TOMCAT.pdf'', data_tool.getHelpPath())'))">
% TOMCAT: A MATLAB toolbox for multivariate calibration techniques</a>, 
% Chemometrics and Intelligent Laboratory Systems, vol.85, issue 2, pp.
% 269-277, 2007
% </li>
% </ol>
% </html>
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% O. Hossjer, C. Croux: 
% <a href="matlab:feval(@open, eval('sprintf(''%s\\pdfs\\95 Generalizing Univariate Signed Rank Statistics for Testing.pdf'', data_tool.getHelpPath())'))">
% Generalizing Univariate Signed Rank Statistics for Testing and Estimating
% a Multivariate Location Parameter</a>, 
% Non-parametric Statistics 4, pp. 293-308, 1995
% </li>
% </ol>
% </html>
%
%


