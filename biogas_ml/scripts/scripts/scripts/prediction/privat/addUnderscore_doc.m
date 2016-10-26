%% Syntax
%       data= addUnderscore(data)
%
%% Description
% |data= addUnderscore(data)| adds a \\ before a _ in char data. Only one _
% is replaced. 
%
%%
% @param |data| : char
%
%%
% @return |data| : char
%
%% Example
% 
%

addUnderscore('X_ch')

%%

addUnderscore('test_test_test')

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('strfind')">
% matlab/strfind</a>
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
% ,
% <html>
% <a href="saveresultsinlatexfile.html">
% saveResultsInLatexFile</a>
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
%
%% TODOs
% # improve documentation
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


