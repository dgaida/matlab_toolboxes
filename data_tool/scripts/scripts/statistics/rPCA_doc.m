%% Syntax
% Function: [rpc,rv,rd,ROD,RD,pct]=rPCA(x,fn)
% 
%%
% Aim:
% Robust Principal Component Analysis (with Croux and Ruiz-Gazen algorithm)  
% 
%%
% Input: 
% x, matrix (n,p), data matrix n-objects, p-variables
% fn, scalar, number of robust PCs to be extracted
% 
%%
% Output:
% rpc, matrix (n,f), containing in columns robust Principal Components
% rv, vector (1,f), with eigenvalues
% rd, matrix (n,f), containing in columns loadings 
% ROD, matrix (n,f), scaled Robust Orthogonal Distances obtained for each 
% object for increasing number of factors in the model computed as follows:
% {ROD-median(ROD)}/qn(ROD) (cutoff value 3)
% RD, matrix (n,f), scaled Robust Distances obtained for each object
% for increasing number of factors in the model computed as follows:
% {RD-median(RD)}/qn(RD) (cutoff value e.g. 3)
% 
%%
% Example:
% [rpc,rv,rd,exRD,ROD,RD]=rPCA(x,fn)
% 
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('mean')">
% matlab/mean</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('l1median')">
% data_tool/l1median</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/sqrt">
% matlab/sqrt</a>
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
% <a href="matlab:doc('data_tool/pca')">
% data_tool/pca</a>
% </html>
%
%% TODOs
% # make documentation
% # add an example
% # understand code
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
%% References
%
% <html>
% <ol>
% <li> 
% C. Croux, A. Ruiz-Gazen: 
% <a href="matlab:feval(@open, eval('sprintf(''%s\\pdfs\\05 High breakdown estimators for principal components.pdf'', data_tool.getHelpPath())'))">
% High breakdown estimators for principal components: the
% projection-pursuit approach revisited</a>, 
% Journal of Multivariate Analysis 95 (2005) 206-226 
% </li>
% <li> 
% I. Stanimirova, B. Walczak, D.L. Massart, V. Simeonov: 
% <a href="matlab:feval(@open, eval('sprintf(''%s\\pdfs\\04 A comparison between two robust PCA algorithms.pdf'', data_tool.getHelpPath())'))">
% A comparison between two robust PCA algorithms</a>, 
% Chemometrics and Intelligent Laboratory Systems 71 (2004) 83-95
% </li>
% </ol>
% </html>
%
% [1] G. Li, Z. Chen, Projection Pursuit Approach to Robust Dispersion 
% Matrices and Principal Components: Primary Theory and Monte-Carlo,
% J. Amer. Stat. Ass. 80 (1985) 759-766
%
% [3] M. Hubert, P.J. Rousseeuw, S. Verboven, A fast algorithm for 
% robust principal components with application to chemometrics, 
% Chemometrics and Intelligent Laboratory Systems 60 (2002) 101-111
%
%


