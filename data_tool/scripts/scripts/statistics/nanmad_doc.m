%% Syntax
%        R= nanmad(i)
%        R= nanmad(i, DIM)
%
%% Description
% |R= nanmad(i)| calculates the mean deviation of |x| in dimension |DIM|. 
%
% MAD estimates the Mean Absolute deviation
% (note that according to [1,2] this is the mean deviation; 
% not the mean absolute deviation)
%
%%
% features:
% - can deal with NaN's (missing values)
% - dimension argument 
% - compatible to Matlab and Octave
%
%%
% @param |DIM| : dimension
%
% *	1: STATS of columns
%	* 2: STATS of rows
%	
% default or []: first DIMENSION, with more than 1 element
%
%%
% Warning! This function ahs nothing in common with the function <mad.html
% mad> which calculated the Median Absolute Deviation. 
%
%% Example
% # Load data from a substrate feed optimization scenario for a biogas
% plant, select last column (fitness value). 

dataAnalysis= load_file('data_to_plot.mat');

X= double(dataAnalysis);
X= X(:,end);

nanmad(X)

X(5)= NaN;

nanmad(X)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/sumskipnan">
% matlab/sumskipnan</a>
% </html>
%
% and is called by:
%
%
%
%% See Also
%
% <html>
% <a href="matlab:doc matlab/var">
% matlab/var</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/std">
% matlab/std</a>
% </html>
%
%%
% REFERENCE(S):
% [1] http://mathworld.wolfram.com/MeanDeviation.html
% [2] L. Sachs, "Applied Statistics: A Handbook of Techniques", Springer-Verlag, 1984, page 253.
%
% [3] http://mathworld.wolfram.com/MeanAbsoluteDeviation.html
% [4] Kenney, J. F. and Keeping, E. S. "Mean Absolute Deviation." §6.4 in Mathematics of Statistics, Pt. 1, 3rd ed. Princeton, NJ: Van Nostrand, pp. 76-77 1962. 
%
%%
%    This program is free software; you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation; either version 2 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program; if not, write to the Free Software
%    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
%%
%	Version 1.23;	07 Jun 2002
%	Copyright (C) 2000-2002 by Alois Schloegl <a.schloegl@ieee.org>
%
%% TODOs
% # make documentation
% # understand script
%
%% <<AuthorTag_DG/>>


