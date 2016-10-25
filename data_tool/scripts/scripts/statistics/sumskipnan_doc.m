%%
% http://www-2.nersc.no/~even/matlab/toolbox/biosig4octmat-2/NaN/
%
%
% SUMSKIPNAN adds all non-NaN values. 
%
% All NaN's are skipped; NaN's are considered as missing values. 
% SUMSKIPNAN of NaN's only  gives O; and the number of valid elements is return. 
% SUMSKIPNAN is also the elementary function for calculating 
% various statistics (e.g. MEAN, STD, VAR, RMS, MEANSQ, SKEWNESS, 
% KURTOSIS, MOMENT, STATISTIC etc.) from data with missing values.  
% SUMSKIPNAN implements the DIMENSION-argument for data with missing values.
% Also the second output argument return the number of valid elements (not NaNs) 
% 
%%
% Y = sumskipnan(x [,DIM])
% [Y,N,SSQ] = sumskipnan(x [,DIM])
% 
% DIM	dimension
%	1 sum of columns
%	2 sum of rows
%	default or []: first DIMENSION with more than 1 element
%
% Y	resulting sum
% N	number of valid (not missing) elements
% SSQ	sum of squares
%
% The mean & standard error of the mean and 
%	Y./N & sqrt((SSQ-Y.*Y./N)./(N.*max(N-1,0))); 
% the mean square & the standard error of the mean square and
% 	SSQ./N & sqrt((S4M-SSQ.^2./N)./(N.*max(N-1,0)))
%
% features:
% - can deal with NaN's (missing values)
% - implements dimension argument. 
% - compatible with Matlab and Octave
%
% see also: SUM, NANSUM, MEAN, STD, VAR, RMS, MEANSQ, 
%      SSQ, MOMENT, SKEWNESS, KURTOSIS, SEM
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
%
%%
%	$Id: sumskipnan.m 4532 2008-01-20 19:03:30Z schloegl $
%    	Copyright (C) 2000-2005 by Alois Schloegl <a.schloegl@ieee.org>	
%       This function is part of the NaN-toolbox
%       http://www.dpmi.tu-graz.ac.at/~schloegl/matlab/NaN/
%
%% TODOs
% # make documentation
% # understand code
% # make an example
%


