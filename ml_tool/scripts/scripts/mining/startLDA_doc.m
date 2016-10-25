%% Syntax
%       [gefundenmatrix, confusionmatrix, TransMatnorm, ClassMeanM, alpha,
%       X_trans, failure]= startLDA(ziptrain, ziptest) 
%       [...]= startLDA(ziptrain, ziptest, no_eigV) 
%
%% Description
% |[gefundenmatrix, confusionmatrix, TransMatnorm, failure]=
% startLDA(ziptrain, ziptest)| 
%
% If the dimension of the original dataset is 3 and |no_eigV == 2|, then
% the hyperplanes are plotted as well, see the 2nd example. 
%
%%
% @param |ziptrain| : training data of the form: [labels, features]
%
% labels is a column vector ranging from 0 to M - 1, labeling the M classes
% and features is the feature matrix of the raw data
%
%%
% @param |ziptest| : test data of the form: [labels, features]
%
% labels is a column vector ranging from 0 to M - 1, labeling the M classes
% and features is the feature matrix of the raw data
%
%%
% @return |gefundenmatrix| : confusion matrix in absolute numbers
%
%%
% @return |confusionmatrix| : confusion matrix in \%
%
%%
% @return |TransMatnorm| : normalized LDA Transformation matrix
%
%%
% @return |ClassMeanM| : matrix of class mean vectors
%
%%
% @return |alpha| : see LDA
%
%%
% @return |X_trans| : see LDA
%
%%
% @return |failure| : failure vector, is 1, when LDa has failed, else 0 for
% each entry in the testmatrix
%
%%
% |[...]= startLDA(ziptrain, ziptest, no_eigV)| 
%
%%
% @param |no_eigV| : number of eigen vectors of the feature space in
% which is discriminated.
%
%% Example
% 
% Example I:

ziptrain= load_file('ziptrain');
ziptest= load_file('ziptest');

[gefundenmatrix, confusionmatrix]= startLDA(ziptrain, ziptest);

disp(gefundenmatrix)
disp(confusionmatrix)

%%
% Example II:

data= load('iris.dat');

data= [data(:, end) - 1, data(:, 2:end - 1)];

[gefundenmatrix, confusionmatrix]= startLDA(data, data, 2);

disp(gefundenmatrix)
disp(confusionmatrix)


%%
% Example III:

data((data(:,1) == 2), 2)= data((data(:,1) == 2), 2) + 5;
data((data(:,1) == 2), 4)= data((data(:,1) == 2), 4) - 15;

figure;

scatter3(data(:,2), data(:,3), data(:,4), [], ...
         data(:,1), 's', 'filled', 'LineWidth', 0.01, ...
         'MarkerEdgeColor', 'k');

%%

[gefundenmatrix, confusionmatrix]= startLDA(data, data, 2);

disp(gefundenmatrix)
disp(confusionmatrix)
       
%%



%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="katz_lda.html">
% katz_lda</a>
% </html>
% ,
% <html>
% <a href="lda_evaluation.html">
% LDA_evaluation</a>
% </html>
% ,
% <html>
% <a href="lda_lin_classifier.html">
% LDA_lin_classifier</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/griddata_vectors')">
% script_collection/griddata_vectors</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% <html>
% <a href="matlab:doc('ml_tool/startrf')">
% ml_tool/startRF</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/startsvm')">
% ml_tool/startSVM</a>
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
% ,
% <html>
% <a href="matlab:doc('parallelcoords')">
% matlab/parallelcoords</a>
% </html>
%
%% TODOs
% # improve documentation
% # hyperplanes sollten öfters geplottet werden, dazu skript
% verallgemeinern
%
%% <<AuthorTag_DG/>>
% M. Katz, Düsseldorf
%
%% References
%
% # Duda, R.O., Hart, E., Stork, D.G.: Pattern Classification, John Wiley
% & Sons, Inc., (2000) 
%


