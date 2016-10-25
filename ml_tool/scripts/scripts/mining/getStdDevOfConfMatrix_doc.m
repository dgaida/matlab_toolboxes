%% Syntax
%       mean_std_dev= getStdDevOfConfMatrix(confMatrix)
%       getStdDevOfConfMatrix(confMatrix, plotdistribution)
%       
%% Description
% |mean_std_dev= getStdDevOfConfMatrix(confMatrix)| calculates std
% deviation of confusion matrix. The standard deviation is calculated out
% of the distribution found for each given class seperately. Thus for each
% row of the confusion matrix a standard deviation value is calculated and
% the maximal value is returned as |mean_std_dev|. 
%
%%
% @param |confMatrix| : confusion matrix whose elements are numbers of
% classified data. May not measured in %. 
%
%       [predicted class]
%       [ 1 ][ 2 ][ 3 ][ 4 ][ 5 ]
% [g][1][100    3    0    0    0]
% [i][2][  3  200   10    1    0]
% [v][3][  1    5   90    2    1]
% [e][4][  0    0    4  120   10]
% [n][5][  0    0    0    8   80]
%
%%
% @return |mean_std_dev| : double scalar with the maximal standard
% deviation of the standard deviations over each given class of the
% confusion matrix
%
%%
% @param |plotdistribution| : 0 or 1.
%
% * 1 : plots the distributions over each row, centered around 0. 
% * 0 : does nothing (default)
%
%% Example
%

theta= fix(4*rand(100,1));
theta_hat= max(min(theta + round(1.8*rand(100,1) - 0.9), 3), 0);

[confMatrix, confPMatrix]= calcConfusionMatrix(theta, theta_hat);

disp(confMatrix);
disp(confPMatrix);

%%

getStdDevOfConfMatrix(confMatrix, 1)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href= matlab:doc('bsxfun')>
% matlab/bsxfun</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('subplot')">
% matlab/subplot</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('hist')">
% matlab/hist</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/is0or1">
% script_collection/is0or1</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('startmethodforstateestimation')">
% startMethodforStateEstimation</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="calcconfusionmatrix.html">
% calcConfusionMatrix</a>
% </html>
% ,
% <html>
% <a href="classifierperformance.html">
% classifierPerformance</a>
% </html>
% ,
% <html>
% <a href="katz_lda.html">
% katz_lda</a>
% </html>
%
%% TODOs
% # Improve documentation a bit
% # why do we return the max of the std. deviation?
%
%% <<AuthorTag_DG/>>


