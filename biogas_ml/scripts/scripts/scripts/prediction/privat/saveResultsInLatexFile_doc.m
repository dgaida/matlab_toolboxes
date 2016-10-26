%% Syntax
%       status= saveResultsInLatexFile(total_performance,
%       total_performance1storder, goal_variables, method, index_file,
%       commentForPrinting) 
%
%% Description
% |status= saveResultsInLatexFile(total_performance,
% total_performance1storder, goal_variables, method, index_file, 
% commentForPrinting)| saves performance results of State Estimator in
% *.tex file. The created file is named 'result_perform_digesters_...tex'
% and contains a table with three columns containing the 
%
%%
% @param |total_performance| : 37x2 dimensional double matrix with the
% performance of the given |method| on some testdata. The first dimension
% is the performance of the 1st fermenter, the 2nd for the 2nd fermenter. 
%
% WARNING!!!
%
% Works only for two digesters!
%
%%
% @param |total_performance1storder| : 37x2 dimensional double matrix
% with the 1storder performance of the given |method| on some testdata. The
% first dimension is the performance of the 1st fermenter, the 2nd for the
% 2nd fermenter. 
%
% This value is only displayed, not written inside the file. 
%
% WARNING!!!
%
% Works only for two digesters!
%
%%
% @param |goal_variables| : 37 dimensional vector (cell string) of the goal
% variables. These are the shortcuts of the state vector components:
% {'Sac', 'Ssu', ...}. 
%
%%
% @param |method| : char with the pattern recognition method. E.g.: 'SVM',
% 'LDA', 'GerDA'
%
%%
% @param |index_file| : 
%
%%
% @param |commentForPrinting| : 37 dimensional cell string of '*'. A '*'
% symbolizes that the number of classes of the classification problem was
% reduced by one (see <mergetoosmallclasses.html mergeTooSmallClasses>).
%
%%
% @return |status| : status value returned by <matlab:doc('fclose')
% fclose>. 
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('addnewrowinlatextable')">
% addNewRowInLatexTable</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/fopen')">
% matlab/fopen</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/fclose')">
% matlab/fclose</a>
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
% <a href="mergetoosmallclasses.html">
% mergeTooSmallClasses</a>
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
% # improve documentation
% # clean up script
% # only works for two digesters
%
%% <<AuthorTag_DG/>>


