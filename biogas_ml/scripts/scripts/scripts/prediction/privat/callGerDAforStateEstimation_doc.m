%% Syntax
%       [perf_temp, perf_1st_temp]= callGerDAforStateEstimation(traindata,
%       testdata, my_dim_low, fermenter_id, itest, goal_variable)
%
%% Description
% |[perf_temp, perf_1st_temp]= callGerDAforStateEstimation(traindata,
% testdata, my_dim_low, fermenter_id, itest, goal_variable)| calls GerDA to
% perform State Estimation. 
%
% WARNING!!! WARNING!!! WARNING!!! WARNING!!! WARNING!!!
%
% Not yet implemented!!!
%
% WARNING!!! WARNING!!! WARNING!!! WARNING!!! WARNING!!!
%
%%
% @param |traindata| : the data used to train GerDA. A double
% matrix. The elements of the matrix are rows, thus the number of columns
% define the dimension of the set and the number of rows the number of
% elements in the set. The first column must contain the goal vector. 
%
%%
% @param |testdata| : the data used to test GerDA. A double
% matrix. The elements of the matrix are rows, thus the number of columns
% define the dimension of the set and the number of rows the number of
% elements in the set. The first column must contain the goal vector. The
% number of columns must be identical to the number of columns of
% |traindata|. 
%
%%
% @param |my_dim_low| : dimension of the space to which GerDA will project
% the data. 
%
%%
% @param |fermenter_id| : char with the id of the fermenter as defined in
% the C# object |biogas.plant|. The data belongs to this fermenter. 
%
%%
% @param |itest| : The index of the test when doing e.g. a k-fold
% cross-validation. Running from 1 to number of test. 
%
%%
% @param |goal_variable| : char with the goal variable. This is the name
% of the state vector component belonging to |ivariable|. 
%
%%
% @return |perf_temp| : the performance is the relative number of correctly
% classified elements in |testdata| measured in [%]. 
%
%%
% @return |perf_1st_temp| : 
%
%% Example
% 
%
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
% <a href="matlab:doc('ml_tool/getstddevofconfmatrix')">
% ml_tool/getStdDevOfConfMatrix</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('startsvm')">
% startSVM</a>
% </html>
% ,
% <html>
% <a href="callrfforstateestimation.html">
% callRFforStateEstimation</a>
% </html>
%
%% TODOs
% # improve documentation
% # implement method
% # check links to pdfs
%
%% <<AuthorTag_DG/>>
%% References
% 
% <html>
% <ol>
% <li> 
% Stuhlsatz, A.; Lippel, J.; Zielke, T.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\10 Discriminative feature extraction with deep neural networks.pdf'', 
% biogas_ml.getHelpPath())'))">
% Discriminative feature extraction with deep neural networks</a>, 
% in Proceedings of the 2010 International Joint Conference on Neural
% Networks (IJCNN), Barcelona, Spain, 2010. 
% </li>
% <li> 
% Stuhlsatz, A.; Lippel, J.; Zielke, T.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\10 Feature Extraction for Simple Classification.pdf'', 
% biogas_ml.getHelpPath())'))">
% Feature Extraction for Simple Classification</a>, 
% in Proceedings of the International Conference on Pattern Recognition
% (ICPR). Istanbul, Turkey, 2010. 
% </li>
% <li> 
% Stuhlsatz, A.; Lippel, J.; Zielke, T.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\12 Feature Extraction with DNN by a Generalized Discriminant Analysis.pdf'', 
% biogas_ml.getHelpPath())'))">
% Feature Extraction with Deep Neural Networks by a Generalized Discriminant Analysis</a>, 
% in IEEE Transactions on neural networks and learning systems, vol. 23,
% no. 4, pp. 596-608, april 2012. 
% </li>
% </ol>
% </html>
%


