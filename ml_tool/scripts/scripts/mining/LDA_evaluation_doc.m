%% Syntax
%       [gefundenmatrix]= LDA_evaluation(ziptest, no_classes,
%       TransMatnorm, ClassMeanM, alpha) 
%       [gefundenmatrix, failure]= LDA_evaluation(ziptest, no_classes,
%       TransMatnorm, ClassMeanM, alpha) 
%
%% Description
% |[gefundenmatrix]= LDA_evaluation(ziptest, no_classes, TransMatnorm,
% ClassMeanM, alpha)| evaluates trained Linear Discriminant Analysis on a
% testset. 
%
%%
% @param |ziptest| : test data of the form: [labels, features]
%
% labels is a column vector ranging from 0 to M - 1, labeling the M classes
% and features is the feature matrix of the raw data
%
%%
% @param |no_classes| : number of classes, double integer scalar
%
%%
% @param |TransMatnorm| : normalized LDA Transformation matrix
%
%%
% @param |ClassMeanM| : matrix of class mean vectors
%
%%
% @param |alpha| : see LDA
%
%%
% @return |gefundenmatrix| : confusion matrix
%
%%
% |[gefundenmatrix, failure]= LDA_evaluation(ziptest, no_classes,
% TransMatnorm, ClassMeanM, alpha)| 
%
%%
% @return |failure| : failure vector, is 1, when LDA has failed, else 0 for
% each entry in the testmatrix
%
%% Example
% |[gefundenmatrix]= LDA_evaluation(ziptest, no_classes, TransMatnorm,
% ClassMeanM, alpha);| 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isrn')">
% script_collection/isRn</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="startlda.html">
% startLDA</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="katz_lda.html">
% katz_lda</a>
% </html>
% ,
% <html>
% <a href="lda_lin_classifier.html">
% LDA_lin_classifier</a>
% </html>
%
%% TODOs
% # solve TODO inside file
% # make example
% # add some formulas
%
%% <<AuthorTag_DG/>>
% M. Katz, Düsseldorf
%
%% References
%
% # Duda, R.O., Hart, E., Stork, D.G.: Pattern Classification, John Wiley
% & Sons, Inc., (2000) 
%


