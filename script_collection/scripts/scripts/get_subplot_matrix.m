%% get_subplot_matrix
% Get number of needed columns and rows for a subplot with nPlots
%
function [ncols, nrows]= get_subplot_matrix(nPlots)
%% Release: 1.6

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%
% check argument

isN(nPlots, 'nPlots', 1);

%%

nrows= fix(sqrt(nPlots));       % number of rows
ncols= ceil(nPlots / nrows);    % number of columns

%%

if nrows == 1     % switch from n cols and 1 row to n rows and 1 col, useful for timeseries
  temp= ncols;    % such as substrate feed with same time domain
  ncols= nrows;
  nrows= temp;
end

%%


