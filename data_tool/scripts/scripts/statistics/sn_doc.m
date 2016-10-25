%% Syntax
%         s=sn(X)
%
%% Description
% |s=sn(X)| Computing SN - scale estimator
% 
% $$S_n = c \cdot med_i ( med_j | x_i - x_j | )$$
%
%%
% @param |X| : matrix (n,p), data matrix n-objects, p-variables  
% 
%%
% @return |s| : vector (1,p) containing the Sn scale estimates of the
% columns of X 
% 
%% Example
%

X= randn(500, 1);

sn(X)

qn(X)

mad(X)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('median')">
% matlab/median</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('mod')">
% matlab/mod</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/sort">
% matlab/sort</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matab/floor">
% matlab/floor</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('data_tool/preprocessing')">
% data_tool/preprocessing</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc('data_tool/rpca')">
% data_tool/rPCA</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/qn')">
% data_tool/qn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/mad')">
% data_tool/mad</a>
% </html>
%
%% TODOs
% # improve documentation
% # improve code
%
%% Author
% Written by Sven Serneels, University of Antwerp
%
%% References
%
% <html>
% <ol>
% <li> 
% P.J. Rousseeuw, C. Croux: 
% <a href="matlab:feval(@open, eval('sprintf(''%s\\pdfs\\93 Alternatives to the median absolute deviation.pdf'', data_tool.getHelpPath())'))">
% Alternatives to the median absolute deviation</a>, 
% Journal of American Statististical Association 88, pp. 1273-1283, 1993
% </li>
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


