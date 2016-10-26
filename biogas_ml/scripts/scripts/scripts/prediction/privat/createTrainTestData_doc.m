%% Syntax
%       [traindata, testdata]= createTrainTestData(dataset, dataset_test,
%       cutting_points_test, cutter, itest) 
%
%% Description
% |[traindata, testdata]= createTrainTestData(dataset, dataset_test,
% cutting_points_test, cutter, itest)| creates |traindata| and |testdata|
% out of given data |dataset| and if not empty also |dataset_test|. If
% |dataset_test| is empty, then |dataset| is divided into train and
% testdata as the params |cutting_points_test| and |cutter| define (see
% below). If |dataset_test| is not empty, then 
%
% |traindata|= |dataset|
% |testdata|= |dataset_test|
%
% In the first case (|dataset_test == []|) the data inside |dataset| is
% scaled before it is splitted calling <matlab:doc('data_tool/scale_data') 
% data_tool/scale_Data>. In the 2nd case it is not!
%
%%
% @param |dataset| : the data used to train and test a pattern recognition
% method. A double matrix. The elements of the matrix are rows, thus the
% number of columns define the dimension of the set and the number of rows
% the number of elements in the set. The first column must contain the goal
% vector. 
%
%%
% @param |dataset_test| : you have two options:
%
% * [] : then |dataset| is divided into |traindata| and |testdata|
% * double matrix : then |testdata| becomes |dataset_test| and |traindata|
% is set to |dataset|. If it is a double matrix, then the elements of the
% matrix are rows, thus the number of columns define the dimension of the
% set and the number of rows the number of elements in the set. The first
% column must contain the goal vector. The number of columns must be
% identical to the number of columns of |dataset|. 
%
%%
% @param |cutting_points_test| : cell vector containing double row vectors,
% which define which simulation belongs to the test and which to the train
% dataset. If we do a k-fold cross validation the cell vector inside
% |cutting_points_test| contains k elements. Each of them a double row
% vector. 
%
%%
% @param |cutter| : double row vector defining indices inside |dataset|,
% which define the end of one simulation. As the data in |dataset| is
% created running simulations it is important to know where a simulation
% stops, such that the data of one simulation is either put inside the
% train- or testdata set. 
%
% Example:
%
% |[1234 3400 5000]|
%
% Three simulations were performed. The last value inside |dataset|
% belonging to the first simulation is |1234|. The data of the 2nd
% simulation is saved from |1235| to |3400| and the last simulation until
% |5000|. Here it is assumed that |dataset| has 5000 rows. 
%
%%
% @param |itest| : The index of the test when doing e.g. a k-fold
% cross-validation. Running from 1 to number of tests. 
%
%%
% @return |traindata| : the data used to train a pattern recognition method. A double
% matrix. The elements of the matrix are rows, thus the number of columns
% define the dimension of the set and the number of rows the number of
% elements in the set. The first column contains the goal vector. 
%
%%
% @return |testdata| : the data used to test the pattern recognition method. A double
% matrix. The elements of the matrix are rows, thus the number of columns
% define the dimension of the set and the number of rows the number of
% elements in the set. The first column contains the goal vector. The
% number of columns are identical to the number of columns of
% |traindata|. 
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('data_tool/scale_data')">
% data_tool/scale_Data</a>
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
% <a href="startstateestimation.html">
% startStateEstimation</a>
% </html>
% ,
% <html>
% <a href="createstateestimator.html">
% createStateEstimator</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/startsvm')">
% ml_tool/startSVM</a>
% </html>
% ,
% <html>
% <a href="callrfforstateestimation.html">
% callRFforStateEstimation</a>
% </html>
% ,
% <html>
% <a href="callgerdaforstateestimation.html">
% callGerDAforStateEstimation</a>
% </html>
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


