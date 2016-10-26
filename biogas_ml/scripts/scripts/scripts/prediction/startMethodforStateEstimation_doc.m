%% Syntax
%       [status]= startMethodforStateEstimation(streams, dataset,
%       goal_variables, plant, bins) 
%       [status]= startMethodforStateEstimation(streams, dataset,
%       goal_variables, plant, bins, dim_low) 
%       [status]= startMethodforStateEstimation(streams, dataset,
%       goal_variables, plant, bins, dim_low, method) 
%       [status]= startMethodforStateEstimation(streams, dataset,
%       goal_variables, plant, bins, dim_low, method, index_file) 
%       [status]= startMethodforStateEstimation(streams, dataset,
%       goal_variables, plant, bins, dim_low, method, index_file, cutter) 
%       [status]= startMethodforStateEstimation(streams, dataset,
%       goal_variables, plant, bins, dim_low, method, index_file, cutter,
%       streams_test)  
%       [status]= startMethodforStateEstimation(streams, dataset,
%       goal_variables, plant, bins, dim_low, method, index_file, cutter,
%       streams_test, dataset_test)  
%       [status]= startMethodforStateEstimation(streams, dataset,
%       goal_variables, plant, bins, dim_low, method, index_file, cutter,
%       streams_test, dataset_test, min_class_ub)  
%
%% Description
% |[status]= startMethodforStateEstimation(streams, dataset, goal_variables,
% plant, bins)| 
%
%%
% The function does the following:
%
% * For each digester ...
% * For each state vector variable ...
% * Cluster the simulated data of the corresponding state vector variable
% into |bins| classes calling <matlab:doc('biogas_ml/getvectoroutofstream')
% biogas_ml/getVectorOutOfStream>. If a class is too small, then merge the
% too small class with the smaller neighbouring class calling
% <matlab:doc('biogas_ml/mergetoosmallclasses')
% biogas_ml/mergeTooSmallClasses>. 
% * Train a model with the given Machine Learning method |method| using
% 5-fold cross validation. The training- and testdata is created calling
% <matlab:doc('biogas_ml/createtraintestdata') 
% biogas_ml/createTrainTestData>.
% 
% Different Machine Learning methods are available:
%
% * Random Forests : <matlab:doc('biogas_ml/callrfforstateestimation') 
% biogas_ml/callRFforStateEstimation>
% * Support Vector Machines : <matlab:doc('ml_tool/startsvm')
% ml_tool/startSVM> 
% * Linear Discriminant Analysis : <matlab:doc('ml_tool/startlda')
% ml_tool/startLDA> 
% * GerDA : not yet implemented!
%
% * Results are saved in a latex file calling
% <matlab:doc('biogas_ml/addnewrowinlatextable')  
% biogas_ml/addNewRowInLatexTable>
% * MAT files |digester_state_dataset_min.mat| and
% |digester_state_dataset_max.mat| are created.
% * If |method == 'LDA'| the following three files are saved:
% |TransMatnorms.mat|, |ClassMeanMs.mat| and |alphas.mat|. 
%
%%
% @param |streams| : structure containing the double arrays for each
% digester with the ADM stream which has to be predicted. 
%
%%
% @param |dataset| : structure containing the double arrays for each
% digester used for prediction. The double arrays containt measurements,
% such as pH, Co2, CH4, biogas production and the substrate feed and
% recirculation sludge
%
%%
% @param |goal_variables| : 37 dimensional vector of cellstrings containing
% the abbreviations for the ADM1 state vector components. {'Ssu'}, {'Saa'},
% ...
%
%%
% @param |plant| : object of the C# class |biogas.plant|
%
%%
% @param |bins| : Dimension of the classification problem. If a regression
% problem should be solved, then set |bins| to -1. Usually an integer
% number. 
%
%%
% @return |status| : 
%
%%
% |[status]= startMethodforStateEstimation(streams, dataset, goal_variables,
% plant, bins, dim_low)| 
%
%%
% @param |dim_low| : double scalar value defining the dimension of the
% space in which discriminant methods like GerDA and LDA should project the
% original features. Per default |dim_low| is chosen to be |bins - 1|.
%
%%
% |[status]= startMethodforStateEstimation(streams, dataset, goal_variables,
% plant, bins, dim_low, method)| 
%
%%
% @param |method| : char with the pattern recognition method to be used.
% Possible values are:
%
% * 'RF' : Random Forest
% * 'LDA' : Linear Discriminant Analysis
% * 'SVM' : Support Vector Machines (not recommended, because very slow)
% * 'GerDA' : Generalized Discriminant Analysis (not yet implemented)
%
%%
% |[status]= startMethodforStateEstimation(streams, dataset, goal_variables,
% plant, bins, dim_low, method, index_file)| 
%
%%
% @param |index_file| : 3dimensional cell containing double values 
%
%%
% |[status]= startMethodforStateEstimation(streams, dataset, goal_variables,
% plant, bins, dim_low, method, index_file, cutter)| 
%
%%
% @param |cutter| : Specifies to which simulation the data in |dataset| and
% |streams| belongs. The reason for this parameter is that data from one
% simulation only should completely be inside the test- or trainingdata.
% This is to avoid similar data in test and training data due to a to small
% sample rate.
%
%%
% |[status]= startMethodforStateEstimation(streams, dataset, goal_variables,
% plant, bins, dim_low, method, index_file, cutter, streams_test)| 
%
%%
% @param |streams_test| : Usually the testdataset is created inside this
% function by 5-fold cross validation, using |streams|. If you want to
% specify the test data differently, then use |streams_test|.
%
%%
% |[status]= startMethodforStateEstimation(streams, dataset, goal_variables,
% plant, bins, dim_low, method, index_file, cutter, streams_test,
% dataset_test)| 
%
%%
% @param |dataset_test| : Usually the testdataset is created inside this
% function by 5-fold cross validation, using |dataset|. If you want to
% specify the test data differently, then use |dataset_test|.
%
%%
% @param |min_class_ub| : min. size of a class. Default: 100. 
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="getvectoroutofstream.html">
% getVectorOutOfStream</a>
% </html>
% ,
% <html>
% <a href="mergetoosmallclasses.html">
% mergeTooSmallClasses</a>
% </html>
% ,
% <html>
% <a href="get_cutting_points_test.html">
% get_cutting_points_test</a>
% </html>
% ,
% <html>
% <a href="createtraintestdata.html">
% createTrainTestData</a>
% </html>
% ,
% <html>
% <a href="callrfforstateestimation.html">
% callRFforStateEstimation</a>
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
% ,
% <html>
% <a href="matlab:doc ml_tool/startlda">
% ml_tool/startLDA</a>
% </html>
% ,
% <html>
% <a href="matlab:doc ml_tool/classifierperformance">
% ml_tool/classifierPerformance</a>
% </html>
% ,
% <html>
% <a href="saveresultsinlatexfile.html">
% saveResultsInLatexFile</a>
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
% <a href="matlab:doc('script_collection/isz')">
% script_collection/isZ</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant')">
% biogas_scripts/is_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validatestring')">
% matlab/validatestring</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="startstateestimation.html">
% startStateEstimation</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="createstateestimator.html">
% createStateEstimator</a>
% </html>
% ,
% <html>
% <a href="createdatasetforpredictor.html">
% createDataSetForPredictor</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/katz_lda')">
% ml_tool/katz_lda</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/startrf')">
% ml_tool/startRF</a>
% </html>
% ,
% <html>
% <a href="simbiogasplantforprediction.html">
% simBiogasPlantForPrediction</a>
% </html>
%
%% TODOs
% # improve documentation
% # maybe add an example
%
%% <<AuthorTag_DG/>>


