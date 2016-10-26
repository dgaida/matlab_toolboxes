%% Syntax
%       addNewRowInLatexTable(fid, row_data, row_type, table_flag)
%       addNewRowInLatexTable(fid, row_data, row_type, table_flag,
%       table_header)
%       addNewRowInLatexTable(fid, row_data, row_type, table_flag,
%       table_header, row_end)
%
%% Description
% |addNewRowInLatexTable(fid, row_data, row_type, table_flag)| adds a row
% to a LaTeX table. 
%
%%
% @param |fid| : file identifier, which e.g. is returned by <matlab:doc('fopen')
% fopen>. integer. 
%
%%
% @param |row_data| : 1-dim. cell array with chars that will be the cell elements.
% The table will have as many columns as |row_data| has elements. 
%
%%
% @param |row_type| : 1 dim. cell array with the data type of each column.
% In the style of e.g. '%.2f'.
%
%%
% @param |table_flag| : if 1, then the table is created. If 2, then the
% table is finished. Else 0. 
%
%%
% @param |table_header| : 1 dim. cell array with the headline of the
% columns of the table. Must have as many elements as the table haas
% columns. Is only used, when |table_flag| == 1, else may be empty. 
%
%%
% @param |row_end| : default: '\\\\'. Defines how a row in the table ends. 
%
%% Example
% 
%

fid= fopen('testfile.tex', 'wt');

addNewRowInLatexTable(fid, {5, 6.43, 3}, {'%.2f', '%.1d', '%.3f'}, 1, {'x1', 'x2', 'x3'});
addNewRowInLatexTable(fid, {7.2, 9.2, -3.2}, {'%.2f', '%.1d', '%.3f'}, 0);
addNewRowInLatexTable(fid, {9.45, 3.1, 9.454667}, {'%.2f', '%.1d', '%i'}, 2);

fclose(fid);

% clean up

delete('testfile.tex');

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/load_file')">
% biogas_scripts/load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkdimensionofvariable')">
% script_collection/checkDimensionOfVariable</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn0')">
% script_collection/isN0</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_ml/startstateestimation')">
% biogas_ml/startStateEstimation</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_ml/startmethodforstateestimation')">
% biogas_ml/startMethodforStateEstimation</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_ml/simbiogasplantforprediction')">
% biogas_ml/simBiogasPlantForPrediction</a>
% </html>
%
%% TODOs
% # improve documentation
% # check script
%
%% <<AuthorTag_DG/>>


