%% Syntax
%       [X, y]= deleteDuplicates(X, y)
%
%% Description
% |[X, y]= deleteDuplicates(X, y)| throws duplicate rows out of the double
% matrix |X|. The vector or matrix |y| is assumed to belong to the data in
% |X| in the form of a mapping F: |y|= F(|X|). So rows deleted in |X| are
% deleted in |y| as well. The rows in |X| and |y| are returned in the same
% order as they are given in the original data.
%
%%
% @param |X| : Data double matrix or column vector. An element of
% the dataset must be arranged as a row. So the number of rows of |X|
% defines the size of the dataset. 
%
%%
% @param |y| : Data double matrix or vector. An element of
% the dataset must be arranged as a row. It must have the same number of
% rows as |X| has. 
%
%%
% @return |X| : Data double matrix or vector, where there are no duplicate
% rows anymore. The size of the dataset (number of rows) is smaller or
% equal to the size of the original dataset. 
%
%%
% @return |y| : Data double matrix or vector, where these row numbers are
% deleted, which were deleted in |X|. So the mapping |y|= F(|X|) still
% holds. 
%
%% Example
%
% Load a mat-file containing simulation data from a biogas plant model. x,
% y and z represent substrate feeds and |fitness| represents some sort
% of cost vs. benefit ratio of the used substrate feed. As two simulations
% with the same substrate feed not necessarily result in exactly the same
% fitness value, these duplicates must be deleted, when you want to find a
% functional connection between the substrate feeds and the fitness value,
% e.g. using <matlab:doc('ml_tool/evaluate_kriging') Kriging approximation>. 
%

dataAnalysis= load_file('data_to_plot.mat');

x= double(dataAnalysis(:,2));
y= double(dataAnalysis(:,3));
z= double(dataAnalysis(:,8));

fitness= double(dataAnalysis(:,end));

[X, fitness]= deleteDuplicates([x, y, z], fitness);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('sortrows')">
% matlab/sortrows</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('diff')">
% matlab/diff</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('data_tool/predict_data')">
% data_tool/predict_data</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/griddata_vectors')">
% script_collection/griddata_vectors</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_scripts/load_file')">
% biogas_scripts/load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/evaluate_kriging')">
% ml_tool/evaluate_kriging</a>
% </html>
%
%% TODOs
% # create documentation for script file
% # why do I not use <matlab:doc('unique') unique> inside the function?
%
%% <<AuthorTag_DG/>>


