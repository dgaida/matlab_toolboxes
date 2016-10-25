%% Preliminaries
% The function uses the Random Forest toolbox for MATLAB, which you can find 
% <http://code.google.com/p/randomforest-matlab/ here>. You have to
% download and install it first. 
%
%% Syntax
%       rf_model= startRF(traindata_or_model, testdata)
%       [...]= startRF(traindata_or_model, testdata, regress)
%       [...]= startRF(traindata_or_model, testdata, regress, n_trees)
%       [...]= startRF(traindata_or_model, testdata, regress, n_trees,
%       mtry) 
%       [rf_model, perf]= startRF(...)
%       [rf_model, perf, perf_percent]= startRF(..., ..., 0)
%       [rf_model, perf, perf_percent, perf_1st]= startRF(..., ..., 0)
%       [rf_model, perf, perf_percent, perf_1st, confMatrix]= startRF(...,
%       ..., 0) 
%       [rf_model, perf, perf_percent, perf_1st, confMatrix, confPMatrix]=
%       startRF(..., ..., 0) 
%       [rf_model, perf, perf_percent, perf_1st, confMatrix, confPMatrix,
%       Y_hat]= startRF(..., ..., 0) 
%       [rf_model, perf, mse]= startRF(..., ..., 1)
%       [rf_model, perf, mse, Y_hat]= startRF(..., ..., 1)
%       [rf_model, perf, mse, Y_hat, e]= startRF(..., ..., 1)
%
%% Description
% |rf_model= startRF(traindata_or_model, testdata)| calls Random
% Forests to perform classification or regression. Calling without the
% parameter |regress| a classification problem is solved. 
%
%%
% @param |traindata_or_model| : the data used to train the Random Forest. A double
% matrix. The elements of the matrix are rows, thus the number of columns
% define the dimension of the set and the number of rows the number of
% elements in the set. The first column must contain the goal vector. 
%
% You may also pass a trained Random Forest model, then calling this
% function the model is only used to validate using the |testdata|. The
% model must either be a trained classification model (default, |regress ==
% 0|) or a trained regression model (|regress == 1|).
%
%%
% @param |testdata| : the data used to test the Random Forest. A double
% matrix. The elements of the matrix are rows, thus the number of columns
% define the dimension of the set and the number of rows the number of
% elements in the set. The first column must contain the goal vector. The
% number of columns must be identical to the number of columns of
% |traindata|. 
%
%%
% @return |rf_model| : the trained random forest model, which is a struct. 
%
%%
% |[...]= startRF(traindata_or_model, testdata, regress)|
%
%%
% @param |regress| : 0 or 1
%
% * 0 : solve a classification problem
% * 1 : solve a regression problem
%
% Depending on this parameter the first column inside |traindata| and
% |testdata| must either be the vector with the class numbers (|regress ==
% 0|) or the real values of the goal variable (|regress == 1|). 
%
%%
% |[...]= startRF(traindata_or_model, testdata, regress, n_trees)|
%
%%
% @param |n_trees| : number of trees inside the Random Forest. double
% scalar integer. Default: 15
%
%%
% @param |mtry| : at each node, a given number (denoted by mtry) of input
% variables are randomly chosen and the best split is calculated only
% within this subset
%
%%
% |[rf_model, perf]= startRF(...)|
%
%%
% @return |perf| : if a classification problem is solve, then the
% performance is the relative number of correctly classified elements in
% |testdata| measured in [%]. If a regression problem is solved then the
% performance is defined as the RMS between predicted and given |testdata|.
%
%%
% |[rf_model, perf, perf_percent]= startRF(..., ..., 0)|
%
%%
% @return |perf_percent| : 
%
%%
% |[rf_model, perf, perf_percent, perf_1st]= startRF(..., ..., 0)|
%
%%
% @return |perf_1st| : 
%
%%
% |[rf_model, perf, perf_percent, perf_1st, confMatrix]= startRF(..., ...,
% 0)| 
%
%%
% @return |confMatrix| : confusion matrix measured in absolute values
%
%%
% |[rf_model, perf, perf_percent, perf_1st, confMatrix, confPMatrix]=
% startRF(..., ..., 0)| 
%
%%
% @return |confPMatrix| : confusion matrix measured in 100 %
%
%%
% @return |Y_hat| : 
%
%%
% @return |mse| : mean squared estimation error
%
%%
% @return |e| : estimation error
%
%% Example
% 
%

traindata= load_file('ziptrain');
testdata=  load_file('ziptest');

[rf_model, perf, perf_percent, perf_1st, confMatrix, confPMatrix]= ...
  startRF(traindata, testdata, 0);

disp('rf_model: ')
disp(rf_model)
disp('perf: ')
disp(perf)
disp('perf %: ')
disp(perf_percent)
disp('perf_1st: ')
disp(perf_1st)
disp('confusion matrix: ')
disp(confMatrix)
disp('confusion matrix [100 %]: ')
disp(confPMatrix)

%%
% call it again with the trained random forest model, results should be the
% same
%

[rf_model, perf, perf_percent, perf_1st, confMatrix, confPMatrix]= ...
  startRF(rf_model, testdata);

disp('rf_model: ')
disp(rf_model)
disp('perf: ')
disp(perf)
disp('perf %: ')
disp(perf_percent)
disp('perf_1st: ')
disp(perf_1st)
disp('confusion matrix: ')
disp(confMatrix)
disp('confusion matrix [100 %]: ')
disp(confPMatrix)

%%
% call with a regression problem



%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('ml_tool/calcconfusionmatrix')">
% ml_tool/calcConfusionMatrix</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/classifierperformance')">
% ml_tool/classifierPerformance</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_ml/callrfforstateestimation')">
% biogas_ml/callRFforStateEstimation</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="startlda.html">
% startLDA</a>
% </html>
% ,
% <html>
% <a href="startsvm.html">
% startSVM</a>
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
% ,
% <html>
% <a href="matlab:doc('NaiveBayes')">
% matlab/NaiveBayes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('classregtree')">
% matlab/classregtree</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('TreeBagger')">
% matlab/TreeBagger</a>
% </html>
%
%% TODOs
% # improve documentation
% # reference zu paper überdenken
% # add regression example
%
%% <<AuthorTag_DG/>>
%% References
% 
% <html>
% <ol>
% <li> 
% Breiman, Leo: <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\01 Random Forests.pdf'', 
% biogas_ml.getHelpPath())'))">
% Random Forests</a>, in Machine Learning, 45, pp. 5-32, 2001
% </li>
% </ol>
% </html>
%


