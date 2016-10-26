%% Syntax
%       cutting_points_test= get_cutting_points_test(cutter)
%       cutting_points_test= get_cutting_points_test(cutter, k)
%
%% Description
% |cutting_points_test= get_cutting_points_test(cutter)| creates
% |cutting_points_test| out of file or given |cutter|. First it tries to load
% the file 'cutting_points_test.mat'. If it is not existent, then
% |cutting_points_test| is created out of |cutter| and then saved as
% 'cutting_points_test.mat'. 
%
% Warning! 
%
% This function only works for a k-fold cross validation.
%
%
%%
% @param |cutter| : double row vector defining indices inside a dataset
% defining a classification problem, which define the end of one
% simulation. As the data in the dataset is created running simulations
% (see <simbiogasplantforprediction.html simBiogasPlantForPrediction>) it
% is important to know where a simulation 
% stops, such that the data of one simulation is either put inside the
% training- or testdata set. 
%
% Example:
%
% |[1234 3400 5000]|
%
% Three simulations were performed. The last value inside the dataset
% belonging to the first simulation is |1234|. The data of the 2nd
% simulation is saved from |1235| to |3400| and the last simulation until
% |5000|. Here it is assumed that the dataset has 5000 rows. 
%
%%
% @return |cutting_points_test| : cell vector containing double row vectors,
% which define which simulation belongs to the test and which to the train
% dataset. If we do a k-fold cross validation the cell vector inside
% |cutting_points_test| contains k elements. Each of them a double row
% vector. The integer numbers given in the row vectors represent the
% simulation numbers in the test data. The training data contains all other
% simulations. 
%
%%
% |cutting_points_test= get_cutting_points_test(cutter, k)| 
%
%%
% @param |k| : k of k-fold cross-validation. double integer scalar.
%
% If you set |k == 1|, then one third of the simulations are used as test
% data, and two thirds are used as training data. Then
% |cutting_points_test| is a one dimensional cell vector, containg one row
% vector which contains the numbers of the test simulations
%
%% Example
% 
% using 5-fold cross validation

cutter= [500 1234 2130 3400 4321 5000 6000 7200 8900 10000];

get_cutting_points_test( cutter )

if exist('cutting_points_test.mat', 'file')
  delete('cutting_points_test.mat');
end

%%
% using 3-fold cross validation

get_cutting_points_test( cutter, 3 )

if exist('cutting_points_test.mat', 'file')
  delete('cutting_points_test.mat');
end

%%
% using 1-fold cross validation, then test-/training data is split 1/3 and
% 2/3. 

get_cutting_points_test( cutter, 1 )

if exist('cutting_points_test.mat', 'file')
  delete('cutting_points_test.mat');
end

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('load_file')">
% load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('randperm')">
% matlab/randperm</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('save')">
% matlab/save</a>
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
% ,
% <html>
% <a href="createtraintestdata.html">
% createTrainTestData</a>
% </html>
%
%% TODOs
% # check appearance of documentation
% # only works for k-fold cross validation
%
%% <<AuthorTag_DG/>>


