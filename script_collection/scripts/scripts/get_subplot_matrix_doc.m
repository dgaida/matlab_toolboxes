%% Syntax
%       [ncols, nrows]= get_subplot_matrix(nPlots)
%
%% Description
% |[ncols, nrows]= get_subplot_matrix(nPlots)| gets number of needed
% columns |ncols| and rows |nrows| for a <matlab:doc('subplot') subplot>
% with |nPlots|. Usually the returned number of columns is higher than the
% number of rows |nrows|. Only if |nrows| would be one, then |ncols| is set
% to one and the number of rows is set to the previous value of |ncols|. 
%
%%
% @param |nPlots| : number of plots the subplot should have. double scalar.
%
%%
% @return |ncols| : number of columns the subplot will have. double scalar.
%
%%
% @return |nrows| : number of rows the subplot will have. double scalar.
%
%% Example
% 
% 

[ncols, nrows]= get_subplot_matrix(1);

fprintf('ncols= %i, nrows= %i \n', ncols, nrows);

if (ncols * nrows < 1)
  error('The script has a serious error!');
end

%%

[ncols, nrows]= get_subplot_matrix(13);

fprintf('ncols= %i, nrows= %i \n', ncols, nrows);

if (ncols * nrows < 13)
  error('The script has a serious error!');
end

%%

nPlots= 8;

[ncols, nrows]= get_subplot_matrix(nPlots);

fprintf('ncols= %i, nrows= %i \n', ncols, nrows);

if (ncols * nrows < nPlots)
  error('The script has a serious error!');
end

%%

for i= 1:nPlots
  subplot(nrows, ncols, i);
  plot((0:0.1:2*pi), sin(0:0.1:2*pi));
end


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/isn">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/sqrt">
% matlab/sqrt</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/fix">
% matlab/fix</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/ceil">
% matlab/ceil</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_scripts/plot_volumeflow_files">
% biogas_scripts/plot_volumeflow_files</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc matlab/subplot">
% matlab/subplot</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/plot">
% matlab/plot</a>
% </html>
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


