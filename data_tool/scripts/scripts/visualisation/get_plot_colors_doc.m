%% Syntax
%       colors= get_plot_colors(num_colors)
%       colors= get_plot_colors(num_colors, mode)
%       
%% Description
% |colors= get_plot_colors(num_colors)| returns color specifications used
% to plot different graphs in one plot. 
%
%%
% @param |num_colors| : number of colors you need. There are 7 base colors,
% but |num_colors| may be higher, then colors are repeated. 
%
%%
% @return |colors| : colors returned in given |mode|. 
%
%%
% @param |mode| : 0, 1, 2
%
% * 0 : Colors are returned as 3dim real vector with values between 0 and
% 1. 
% * 1 : Default. A cell string of colors 'b', 'r', 'g', 'm', 'c', 'k', 'y'
% is returned. 
% * 2 : A column vector of colors 'b', 'r', 'g', 'm', 'c', 'k', 'y' is
% returned. 
%
%% Example
%
%

get_plot_colors(5, 0)

%%

get_plot_colors(5, 1)

%%

get_plot_colors(9, 2)

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
% <a href="matlab:doc('linspace')">
% matlab/linspace</a>
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
%
%% TODOs
% # improve documentation
% # create documentation for script file
%
%% <<AuthorTag_DG/>>


