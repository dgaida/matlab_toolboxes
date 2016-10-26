%% Preliminaries
% The function uses the Random Forest toolbox for MATLAB, which you can find 
% <http://code.google.com/p/randomforest-matlab/ here>. You have to
% download and install it first. 
%
%% Syntax
%       [perf_temp, perf_1st_temp, max_std]=
%       callRFforStateEstimation(traindata, testdata, fermenter_id,
%       ivariable, itest, index_file, y, my_bins, goal_variable, regress)
%       [...]= callRFforStateEstimation(traindata, testdata, fermenter_id,
%       ivariable, itest, index_file, y, my_bins, goal_variable, regress,
%       n_trees) 
%       [...]= callRFforStateEstimation(traindata, testdata, fermenter_id,
%       ivariable, itest, index_file, y, my_bins, goal_variable, regress,
%       n_trees, train_rf) 
%
%% Description
% |[perf_temp, perf_1st_temp, max_std]= callRFforStateEstimation(traindata,
% testdata, fermenter_id, ivariable, itest, index_file, y, my_bins,
% goal_variable, regress)| calls Random Forests to perform State
% Estimation. As default the Random Forest is trained using the |traindata|
% and evaluated using |testdata| calling <matlab:doc('ml_tool/startrf')
% ml_tool/startRF>. The trained model is saved to a file called
% |rf_model_classify_...mat| such that it can be used afterwards. 
%
%%
% @param |traindata| : the data used to train the Random Forest. A double
% matrix. The elements of the matrix are rows, thus the number of columns
% define the dimension of the set and the number of rows the number of
% elements in the set. The first column must contain the goal vector. 
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
% @param |fermenter_id| : char with the id of the fermenter as defined in
% the C# object |biogas.plant|. The data belongs to this fermenter. Only
% used to load and save the Random Forest model from/in a filename, which
% contains the ID of the fermenter. 
%
%%
% @param |ivariable| : The index of the variable inside the state vector of
% the fermenter. Running from 1 to dimension of state vector. The data
% belongs to this variable. Only used to load and save the Random Forest
% model from/in a filename, which contains the number of the variable. 
%
%%
% @param |itest| : The index of the test when doing e.g. a k-fold
% cross-validation. Running from 1 to number of tests. Only used to load and
% save the Random Forest model from/in a filename, which contains the
% number of the test. 
%
%%
% @param |index_file| : 3-dim cell vector containg doubles. TODO: meaning!
%
%%
% @param |y| : the goal vector of the complete dataset including
% |traindata| and |testdata|, but the real values, not the classes. Only
% used to scale the calculation of |max_std|. 
%
%%
% @param |my_bins| : number of classes used in the classification problem.
% double scalar, integer. 
%
%%
% @param |goal_variable| : char with the goal variable. This is the name
% of the state vector component belonging to |ivariable|. Only used for
% display. 
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
% @return |perf_temp| : if a classification problem is solved, then the
% performance is the relative number of correctly classified elements in
% |testdata| measured in [%]. If a regression problem is solved then the
% performance is defined as the RMS between predicted and given |testdata|.
%
%%
% @return |perf_1st_temp| : only returned for the classification problem.
% It is the performance measure, allowing a misclassification with the
% neighbor classes. So usually |perf_1st_temp| is greater then |perf_temp|.
%
%%
% @return |max_std| : it is only returned for the classification problem.
% It is the max value of the standard deviation of the confusion amtrix
% calculated over the rows of the matrix. It is measured in the same unit
% as is |y|.
%
%%
% |[...]= callRFforStateEstimation(traindata, testdata, fermenter_id,
% ivariable, itest, index_file, y, my_bins, goal_variable, regress,
% n_trees)| 
%
%%
% @param |n_trees| : number of trees inside the Random Forest. double
% scalar integer
%
%%
% |[...]= callRFforStateEstimation(traindata, testdata, fermenter_id,
% ivariable, itest, index_file, y, my_bins, goal_variable, regress,
% n_trees, train_rf)| 
%
%%
% @param |train_rf| : 0 or 1
%
% * 0 : do not train Random Forest, but load a trained Random Forest model
% from file: '../matlab_promo/result_perform_digesters_RF_%ih_%in_%if/', ...
% 'rf_model_classify_%s_v%02i_%ih_%in_%if_%it.mat'
% * 1 : train Random Forest and save trained model in a mat file. 
%
%% Example
% 
%

traindata= load_file('ziptrain');
testdata= load_file('ziptest');

[perf_temp, perf_1st_temp]= ...
          callRFforStateEstimation(traindata, testdata, [], 1, 1, ...
                                   {}, 1, 1, '', 0);

disp('perf_temp: ')
disp(perf_temp)
disp('perf_1st_temp: ')
disp(perf_1st_temp)

%%
% add an example for regression



%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('matlab/save')">
% matlab/save</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('load_file')">
% load_file</a>
% </html>
% ,
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
% <a href="matlab:doc('ml_tool/startrf')">
% ml_tool/startRF</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/getstddevofconfmatrix')">
% ml_tool/getStdDevOfConfMatrix</a>
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
% <a href="startmethodforstateestimation.html">
% startMethodforStateEstimation</a>
% </html>
%
%% See Also
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
% <a href="matlab:doc('ml_tool/startsvm')">
% ml_tool/startSVM</a>
% </html>
% ,
% <html>
% <a href="callgerdaforstateestimation.html">
% callGerDAforStateEstimation</a>
% </html>
%
%% TODOs
% # improve documentation a little
% # add an example for regression
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


