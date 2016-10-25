%% Syntax
%        [pc,s,v,d,pr]= pca(x)
%
%% Description
% |[pc,s,v,d,pr]= pca(x)| performs Principal Component Analysis by Singular
% Value Decomposition always on the smaller data dimension. 
%
%%
% @param |x| : matrix (n,p), data matrix n-objects, p-variables
%
%%
% @return |pc| : matrix, contains in columns Principal Components
%
%%
% @return |s| : matrix, contains in columns normalized scores
%
%%
% @return |v| : vector, with eigenvalues
%
%%
% @return |d| : matrix, contains in columns loadings
%
%%
% @return |pr| : vector, % of explained data variance by each PC
%
%% Example
% # Load data from a substrate feed optimization scenario for a biogas
% plant, select columns 2 to 8 (substrate feed). 
%

dataAnalysis= load_file('data_to_plot.mat');

X= double(dataAnalysis);
x= X(:,2:8);
  
[pc,s,v,d,pr]= pca(x);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('eig')">
% matlab/eig</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('diag')">
% matlab/diag</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/sort">
% matlab/sort</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matab/svd">
% matlab/svd</a>
% </html>
%
% and is called by:
%
% -
%
%% See Also
%
% <html>
% <a href="matlab:doc('data_tool/rpca')">
% data_tool/rPCA</a>
% </html>
%
%% TODOs
% # improve documentation
% # improve example
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
% [1] E.R. Malinowski, Factor analysis in chemistry, John Wiley & Sons, 
% INC., New York, 1991.
%
% <html>
% <ol>
% <li> 
% W. Wu, D.L. Massart, S. de Jong: 
% <a href="matlab:feval(@open, eval('sprintf(''%s\\pdfs\\97 The kernel PCA algorithms for wide data.pdf'', data_tool.getHelpPath())'))">
% The kernel PCA algorithms for wide data. Part I: theory and algorithms</a>, 
% Chemometrics and Intelligent Laboratory Systems 36 (1997) 165-172
% </li>
% </ol>
% </html>
%


