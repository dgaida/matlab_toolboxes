%% Syntax
%       marker= get_plot_marker(num_marker)
%       marker= get_plot_marker(num_marker, mode)
%       
%% Description
% |marker= get_plot_marker(num_marker)| returns marker specifications used
% to plot different graphs in one plot. 
%
%%
% @param |num_marker| : number of marker you need. There are 9 different marker,
% but |num_marker| may be higher, then marker are repeated. 
%
%%
% @return |marker| : marker returned in given |mode|. 
%
%%
% @param |mode| : 1, 2
%
% * 1 : Default. A cell string of marker 'o', 's', 'd', '.', '*', '+', 'x', '^', 'v'
% is returned. 
% * 2 : A column vector of marker 'o', 's', 'd', '.', '*', '+', 'x', '^',
% 'v' is returned. 
%
%% Example
%
%

get_plot_marker(5, 1)

%%

get_plot_marker(9, 2)

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
%
%% TODOs
% # improve documentation
% # create documentation for script file
%
%% <<AuthorTag_DG/>>


