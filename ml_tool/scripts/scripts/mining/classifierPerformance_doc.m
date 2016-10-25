%% Syntax
%       [performance, err]= classifierPerformance(confusionmatrix)
%       [performance, err, performance1storder]=
%       classifierPerformance(confusionmatrix) 
%       [performance, err, performance1storder, err1storder]=
%       classifierPerformance(confusionmatrix) 
%       
%% Description
% |[performance, err]= classifierPerformance(confusionmatrix)| calculates
% the performance of a classification result using the confusion 
% matrix returned by the classifier. If the confusion matrix contains NaNs,
% then these rows are kicked out of the matrix before calculating the error
% and performance. A NaN could come if a class was not evaluated in the
% confusion matrix, so during normalization we get 1/0s= Inf. 
%
%%
% @param |confusionmatrix| : confusion matrix where the sum of each row
% must be 100 or 1.
%
%%
% @return |performance| : classification performance in %, measured by
% |mean(diag(confusionmatrix))| 
% 
%%
% @return |err| : classification error in %, measured by 100 -
% |performance|
% 
%%
% @return |performance1storder| : classification performance in % also
% regarding the secondary diagonals, so it is called 1st order
% 
%%
% @return |err1storder| : classification error in %, measured by 100 -
% |performance1storder| 
% 
%% Example
% 
%

[performance, err]= classifierPerformance(eye(5,5));

disp(performance)
disp(err)

%%

theta= fix(4*rand(100,1));
theta_hat= max(min(theta + round(1.8*rand(100,1) - 0.9), 3), 0);

theta_hat(theta == 2)= [];
theta(theta == 2)= [];

[confMatrix, confPMatrix]= calcConfusionMatrix(theta, theta_hat);

disp(confMatrix);
disp(confPMatrix);

[performance, err, performance1storder, err1storder]= classifierPerformance(confPMatrix);

disp(performance)
disp(err)
disp(performance1storder)
disp(err1storder)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('diag')">
% matlab/diag</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/kicknansoo2matrix')">
% ml_tool/kickNaNsoo2matrix</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_ml/startmethodforstateestimation')">
% biogas_ml/startMethodforStateEstimation</a>
% </html>
% ,
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
% <a href="calcconfusionmatrix.html">
% calcConfusionMatrix</a>
% </html>
% ,
% <html>
% <a href="katz_lda.html">
% katz_lda</a>
% </html>
% ,
% <html>
% <a href="startlda.html">
% startLDA</a>
% </html>
% ,
% <html>
% <a href="lda_evaluation.html">
% LDA_evaluation</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('goodnessoffit')">
% matlab/goodnessOfFit</a>
% </html>
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


