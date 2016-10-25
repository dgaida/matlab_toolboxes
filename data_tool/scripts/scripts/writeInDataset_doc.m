%% Syntax
%       dataAnalysis= writeInDataset(database_name, data, table_headline)
%       dataAnalysis= writeInDataset(database_name, data, table_headline,
%       appendData) 
%
%% Description
% |dataAnalysis= writeInDataset(database_name, data, table_headline)| writes given double
% vector |data| inside the given <matlab:doc('dataset') dataset> with the
% name |database_name|. If the dataset already exist, then it is load from
% file and the data is appended to the dataset, then the file is saved again.
% The data only can be appended, when the dimension of the given dataset
% is the same as the given |data|, else the existing dataset is
% overwritten. 
%
% This function is an alternative to saving data in a database when the
% commercial MATLAB Database Toolbox is not available (same hold for the
% functions <writeinxls.html writeInXLS> and <writeincsv.html
% writeInCSV>). 
%
%%
% @param |database_name| : char with the name of the <matlab:doc('dataset')
% dataset> object. 
%
%%
% @param |data| : double data vector
%
%%
% @param |table_headline| : <matlab:doc('cellstr') cellstring> with the
% header of the data. Must have the same number of elements as |data|.
%
%%
% @return |dataAnalysis| : the new <matlab:doc('dataset') dataset> object
%
%%
% |dataAnalysis= writeInDataset(database_name, data, table_headline,
% appendData)| lets you specify whether the new data should be appended to
% the old one or not. 
%
%%
% @param |appendData| : double scalar
%
% * 0 : do not append given data
% * 1 : append given data to already existing dataset, if possible
% (default) 
%
%% Examples
% 
% 

data= [1,2,3];
table_headline= [{'hase'}, {'igel'}, {'summe'}];

% write data
writeInDataset('dataset_test', data, table_headline)
% append more data
writeInDataset('dataset_test', [4,5,6], table_headline)

% clean up
if exist('dataset_test.mat', 'file')
  delete('dataset_test.mat');
end

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc dataset">
% matlab/dataset</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('load_file')">
% load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc save">
% matlab/save</a>
% </html>
% ,
% <html>
% <a href="matlab:doc horzcat">
% matlab/horzcat</a>
% </html>
% ,
% <html>
% <a href="matlab:doc vertcat">
% matlab/vertcat</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/is0or1">
% script_collection/is0or1</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="writetodatabase.html">
% writetodatabase</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="writeinxls.html">
% writeInXLS</a>
% </html>
% ,
% <html>
% <a href="writeincsv.html">
% writeInCSV</a>
% </html>
% ,
% <html>
% <a href="getfiltereddatafromdb.html">
% getFilteredDataFromDB</a>
% </html>
%
%% TODOs
% # calling load_file is not nice
% # create documentation for script file
%
%% <<AuthorTag_DG/>>


