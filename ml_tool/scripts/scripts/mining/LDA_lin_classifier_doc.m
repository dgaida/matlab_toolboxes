%% Syntax
%       class= LDA_lin_classifier(featurevector, no_classes, TransMatnorm,
%       ClassMeanM, alpha) 
%       [class, ytestvector]= LDA_lin_classifier(...) 
%
%% Description
% |class= LDA_lin_classifier(featurevector, no_classes, TransMatnorm,
% ClassMeanM, alpha)| evaluates trained Linear Discriminant Analysis on a
% |featurevector|. 
%
%%
% @param |featurevector| : a feature vector, double
%
%%
% @param |no_classes| : number of classes
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
% @return |class| : corresponding class to the given |featurevector|
%
%%
% @return |ytestvector| : 
%
%% Example
% 
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
% <a href="matlab:doc('ldastateestimator')">
% LDAStateEstimator</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="lda_evaluation.html">
% LDA_evaluation</a>
% </html>
% ,
% <html>
% <a href="katz_lda.html">
% katz_lda</a>
% </html>
%
%% TODOs
% # is almost the same as LDA_evaluation.m, but see no chance to erase one
% of them.
% # make example
% # improve documentation
%
%% <<AuthorTag_DG/>>
%% References
%
% # Duda, R.O., Hart, E., Stork, D.G.: Pattern Classification, John Wiley
% & Sons, Inc., (2000) 
%


