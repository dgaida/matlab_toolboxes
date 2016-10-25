%% Syntax
%       [rmse, mse, se, e, foundValues]= calcRMSE_Classifier(foundClass,
%       target_class, target_reg) 
%       
%% Description
% |[rmse, mse, se, e, foundValues]= calcRMSE_Classifier(foundClass,
% target_class, target_reg)| calculates rmse for a classification result. 
%
%%
% @param |foundClass| : vector with class labels, from 0 to nclass - 1.
% values predicted by a classification method. 
%
%%
% @param |target_class| : vector with class labels, from 0 to nclass - 1.
% Target values. 
%
%%
% @param |target_reg| : vector with real target values, not the class
% labels. If it originally was a regression problem. 
%
%%
% @return |rmse| : root mean squared error of predicted class mean values
% and |target_reg| values. 
% 
%%
% @return |mse| : mean squared error of predicted class mean values
% and |target_reg| values.
% 
%%
% @return |se| : squared error of predicted class mean values
% and |target_reg| values.
% 
%%
% @return |e| : error of predicted class mean values
% and |target_reg| values.
% 
%% Example
% 
%

foundClass= [0 1 1 0 1 0];
target_class= [0 0 1 0 1 0];
target_reg= [0.5 0.1 2.0 0.3 1.7 0.6];

calcRMSE_Classifier(foundClass, target_class, target_reg)

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
% <a href="matlab:doc('sqrt')">
% matlab/sqrt</a>
% </html>
%
% and is called by:
%
% (the user)
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
% <a href="startlda.html">
% startLDA</a>
% </html>
% ,
% <html>
% <a href="lda_evaluation.html">
% LDA_evaluation</a>
% </html>
%
%% TODOs
% # check appearance of documentation
% # improve documentation a little
%
%% <<AuthorTag_DG/>>


