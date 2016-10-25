%% Syntax
%       [confMatrix, confPMatrix]= calcConfusionMatrix(theta, theta_hat)
%       [confMatrix, confPMatrix, confPMatrix_red]= calcConfusionMatrix(...)
%       
%% Description
% |[confMatrix, confPMatrix]= calcConfusionMatrix(theta, theta_hat)|
% calculates confusion matrix for predicted |theta_hat| vs. given vector
% |theta|. 
%
%%
% @param |theta| : scalar or vector with double data. row or column vector.
% The values must be integers >= 0.
%
%%
% @param |theta_hat| : scalar or vector with double data, same dimension as
% |theta|. row or column vector. The values must be integers >= 0. 
%
%%
% @return |confMatrix| : confusion matrix whose elements are numbers of
% classified data. Along the columns the predicted data is written and
% along the rows the given data. 
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
% @return |confPMatrix| : confusion matrix normalized to [100 %], sum over
% each row is 1. Has always the same size as |confMatrix|. But could
% contain NaNs in case no test data for at least one class was not given,
% see the 2nd example. 
%
%%
% @return |confPMatrix_red| : confusion matrix normalized to [100 %], sum over
% each row usually is 1, but must not be. In the case that one row of
% |confMatrix| is completely 0 (this class was not given in the data |theta|), 
% then this row and the corresponding column is deleted in the matrix
% |confPMatrix|. Otherwise a normalisation would not be possible -> NaN.
% The resulting confusion matrix is smaller then the confusion matrix
% |confMatrix|, thus the results cannot be related anymore to the class
% numbers. The sum over the rows of the reduced confusion matrix is not 1
% anymore, see the 2nd example. 
%
%% Example
% 
%

theta= fix(4*rand(100,1));
theta_hat= max(min(theta + round(1.8*rand(100,1) - 0.9), 3), 0);

[confMatrix, confPMatrix]= calcConfusionMatrix(theta, theta_hat);

disp(confMatrix);
disp(confPMatrix);

%%
% in the given data theta class 2 is missing

theta= fix(4*rand(100,1));
theta_hat= max(min(theta + round(1.8*rand(100,1) - 0.9), 3), 0);

theta_hat(theta == 2)= [];
theta(theta == 2)= [];

[confMatrix, confPMatrix, confPMatrix_red]= calcConfusionMatrix(theta, theta_hat);

disp(confMatrix);
disp(confPMatrix);
disp(confPMatrix_red);

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href= matlab:doc('unique')>
% matlab/unique</a>
% </html>
% ,
% <html>
% <a href= matlab:doc('sort')>
% matlab/sort</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isn0n">
% script_collection/isN0n</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/kick0rowsoo2matrix')">
% ml_tool/kick0rowsoo2matrix</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('ml_tool/startrf')">
% ml_tool/startRF</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/startsvm')">
% ml_tool/startSVM</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc('biogas_ml/startmethodforstateestimation')">
% biogas_ml/startMethodforStateEstimation</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_ml/startstateestimation')">
% startStateEstimation</a>
% </html>
% ,
% <html>
% <a href="katz_lda.html">
% katz_lda</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('gscatter')">
% matlab/gscatter</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('classify')">
% matlab/classify</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('confusionmat')">
% matlab/confusionmat</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('cvpartition')">
% matlab/cvpartition</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('crossval')">
% matlab/crossval</a>
% </html>
%
%% TODOs
% # Check appearance of documentation
%
%% <<AuthorTag_DG/>>


