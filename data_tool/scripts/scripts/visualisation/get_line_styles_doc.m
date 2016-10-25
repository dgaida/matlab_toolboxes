%% Syntax
%       linestyles= get_line_styles(num_lines)
%       linestyles= get_line_styles(num_lines, mode)
%       
%% Description
% |linestyles= get_line_styles(num_lines)| returns line style specifications used
% to plot different graphs in one plot. 
%
%%
% @param |num_lines| : number of line styles you need. There are 4 different line styles,
% but |num_lines| may be higher, then line styles are repeated. 
%
%%
% @return |linestyles| : line styles returned in given |mode|. 
%
%%
% @param |mode| : 1, 2
%
% * 1 : Default. A cell string of line styles '-', '--', ':', '-.'
% is returned. 
% * 2 : A column vector of line styles '-', '--', ':', '-.' is returned. 
%
%% Example
%
%

get_line_styles(5, 1)

%%

get_line_styles(9, 2)

%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('repmat')">
% matlab/repmat</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ceil')">
% matlab/ceil</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isz')">
% script_collection/isZ</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_scripts/plot_volumeflow_files')">
% biogas_scripts/plot_volumeflow_files</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc('matlab/colorspec')">
% matlab/ColorSpec</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/get_plot_colors')">
% data_tool/get_plot_colors</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/get_plot_marker')">
% data_tool/get_plot_marker</a>
% </html>
%
%% TODOs
% # improve documentation
% # create documentation for script file
%
%% <<AuthorTag_DG/>>


