%% Syntax
%       col_index= getColIndexOfDataset(myDataset, colname)
%
%% Description
% |col_index= getColIndexOfDataset(myDataset, colname)| returns column
% index of specified column name |colname| of the given dataset
% |myDataset|. 
%
%%
% @param |myDataset| : a <matlab:doc('matlab/dataset') dataset>
%
%%
% @param |colname| : char with the name of a column inside the given
% dataset |myDataset|. 
%
%%
% @return |col_index| : 1-based index of the column. 
%
%% Example
%
% 

load('data_to_plot.mat');

col_index= getColIndexOfDataset(dataAnalysis, 'simtime');

disp(col_index)

simtime= dataAnalysis(:, col_index);

plot(simtime)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('matlab/cellfun')">
% matlab/cellfun</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% <html>
% <a href="matlab:doc('matlab/dataset')">
% matlab/dataset</a>
% </html>
%
%% TODOs
% # check documentation and create it for script
% 
%% <<AuthorTag_DG/>>


