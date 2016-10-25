%% Syntax
% Function: out=preprocessing(X,method)
%
%% Description
% Aim:
% Data preprocessing
% 
%%
% Input: 
% X, matrix (n,p), data matrix n-objects, p-variables 
% method, string defining type of data preprocessing
% 
% classical preprocessing:
% 'mean centering' - columnwise centering of X
% 'standardisation' - columnwise standardisation of X
% 'SNV' - Standard Normal Variate
%
% robust preprocessing:
% 'median centering' - columnwise centering of X with classical median
% 'l1-median centering' - columnwise centering of X with L1-median
% 'qn-standardisation' - columnwise standardisation of X with Qn-estimator
% 'qn-autoscaling' - autoscaling by centering around L1-median and Qn
% standardisation
% 'sn-standardisation' - columnwise standardisation of X with Sn-estimator
% 'sn-autoscaling' - autoscaling by centering around L1-median and Sn
% standardisation
% 'mad' - columnwise Median of Absolute Deviation
% 'median-snv' - Standard Normal Variate with classical median
% 'sn-snv' - Standard Normal Variate with Qn-estimator
% 'sn-snv' - Standard Normal Variate with Sn-estimator
% 
%%
% Output:
% out, preprocessed X
% 
%%
% Example: 
% out=preprocessing(X,'mean centering')
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
% <a href="matlab:doc('std')">
% matlab/std</a>
% </html>
% ,
% <html>
% <a href="matlab:doc data_tool/l1median">
% data_tool/L1median</a>
% </html>
% ,
% <html>
% <a href="matlab:doc data_tool/qn">
% data_tool/qn</a>
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
% # make documentation
% # make an example
% # understand code
%
%%
% Written by Sven Serneels
% MiTAC, University of Antwerp
% December 2004
%
%% References
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


