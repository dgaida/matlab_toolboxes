%% Preliminaries
% The function uses the libSVM toolbox for MATLAB, which you can find 
% <http://www.csie.ntu.edu.tw/~cjlin/libsvm/ here>. You have to
% download and install it first. 
%
%% Syntax
%       perf_temp= startSVM(traindata, testdata, regress)
%       perf_temp= startSVM(traindata, testdata, regress, write_files)
%
%% Description
% |perf_temp= startSVM(traindata, testdata, regress)|
% calls Support Vector Machines to perform classification. 
%
%%
% @param |traindata| : the data used to train the SVM. A double
% matrix. The elements of the matrix are rows, thus the number of columns
% define the dimension of the set and the number of rows the number of
% elements in the set. The first column must contain the goal vector. 
%
%%
% @param |testdata| : the data used to test the SVM. A double
% matrix. The elements of the matrix are rows, thus the number of columns
% define the dimension of the set and the number of rows the number of
% elements in the set. The first column must contain the goal vector. The
% number of columns must be identical to the number of columns of
% |traindata|. 
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
% @param |write_files| : 0 or 1
%
% * 0 : do not save in files
% * 1 : save training and test data in txt files. can be used to run svn
% outside of matlab, which is much faster
%
%%
% @return |confMatrix| : confusion matrix measured in absolute values
%
%%
% @return |confPMatrix| : confusion matrix measured in 100 %
%
%% Example
% 
%

traindata= load_file('ziptrain');
testdata= load_file('ziptest');

[perf_temp, perf_1st_temp, confMatrix]= startSVM(traindata, testdata, 0);

disp('perf_temp: ')
disp(perf_temp)
disp('perf_1st_temp: ')
disp(perf_1st_temp)
disp('confMatrix: ')
disp(confMatrix) 

%%

data= load('iris.dat');

data= [data(:, end) - 1, data(:, 2:end - 1)];

scatter3(data(:,2), data(:,3), data(:,4), [], ...
data(:,1), 's', 'filled', 'LineWidth', 0.01, ...
'MarkerEdgeColor', 'k');

[perf_temp, perf_1st_temp, confMatrix, predict_label]= startSVM(data, data, 0);

figure
scatter3(data(:,2), data(:,3), data(:,4), [], ...
predict_label, 's', 'filled', 'LineWidth', 0.01, ...
'MarkerEdgeColor', 'k');

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('matlab/sparse')">
% matlab/sparse</a>
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
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% <html>
% <a href="startlda.html">
% startLDA</a>
% </html>
% ,
% <html>
% <a href="startrf.html">
% startRF</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/getstddevofconfmatrix')">
% ml_tool/getStdDevOfConfMatrix</a>
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
% # make TODOs in script especially regress == 1
%
%% <<AuthorTag_DG/>>
%% References
% 
% <html>
% <ol>
% <li> 
% Chang, Chih-Chung; Lin, Chih-Jen: <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\mining\\10 LIBSVM - a library for support vector machines.pdf'', 
% ml_tool.getHelpPath())'))">
% LIBSVM: a Library for Support Vector Machines</a>, 2010.
% </li>
% </ol>
% <ol>
% <li> 
% Hsu, Chih-WEi; Chang, Chih-Chung; Lin, Chih-Jen: <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\mining\\10 A Practical Guide to Support Vector Classification.pdf'', 
% ml_tool.getHelpPath())'))">
% A Practical Guide to Support Vector Classification</a>, 2010.
% </li>
% </ol>
% </html>
%
% 


