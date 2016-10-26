%% Syntax
%       [traindata, testdata]= addNoiseToTestTrainData(traindata, testdata)
%       [...]= addNoiseToTestTrainData(traindata, testdata, error_scl) 
%
%% Description
% |[traindata, testdata]= addNoiseToTestTrainData(traindata, testdata)|
% adds normally distributed noise to |testdata| and |traindata|. 
%
%%
% WARNING!!! WARNING!!! WARNING!!! WARNING!!! 
%
% At the moment the function does nothing!
%
% WARNING!!! WARNING!!! WARNING!!! WARNING!!! 
%
%%
% @param |traindata| : the data used to train a pattern recognition method. A double
% matrix. The elements of the matrix are rows, thus the number of columns
% define the dimension of the set and the number of rows the number of
% elements in the set. The first column must contain the goal vector. 
%
%%
% @param |testdata| : the data used to test the pattern recognition method. A double
% matrix. The elements of the matrix are rows, thus the number of columns
% define the dimension of the set and the number of rows the number of
% elements in the set. The first column must contain the goal vector. The
% number of columns must be identical to the number of columns of
% |traindata|. 
%
%%
% @return |traindata| : The |traindata| but with normally distributed noise
% added. 
%
%%
% @return |testdata| : The |testdata| but with normally distributed noise
% added. 
%
%%
% |[...]= addNoiseToTestTrainData(traindata, testdata, error_scl)| 
%
%%
% @param |error_scl| : scalar defining the maximal error added to the
% datasets. Default: 0.01. 
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('randn')">
% matlab/randn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
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
% <a href="matlab:doc('startsvm')">
% startSVM</a>
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
% # clean up script
% # check code
% # change rand to randn
%
%% <<AuthorTag_DG/>>


