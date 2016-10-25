%% nanmad
% Calculates the mean deviation of x in dimension DIM
%
function R = nanmad(i,DIM)
%% Release: 1.1

%
%
% http://www-2.nersc.no/~even/matlab/toolbox/biosig4octmat-2/NaN/
%
%
% MAD estimates the Mean Absolute deviation
% (note that according to [1,2] this is the mean deviation; 
% not the mean absolute deviation)
%
% y = mad(x,DIM)
%   calculates the mean deviation of x in dimension DIM
%
% DIM	dimension
%	1: STATS of columns
%	2: STATS of rows
%	default or []: first DIMENSION, with more than 1 element
%
% features:
% - can deal with NaN's (missing values)
% - dimension argument 
% - compatible to Matlab and Octave
%
% see also: SUMSKIPNAN, VAR, STD, 
%
% REFERENCE(S):
% [1] http://mathworld.wolfram.com/MeanDeviation.html
% [2] L. Sachs, "Applied Statistics: A Handbook of Techniques", Springer-Verlag, 1984, page 253.
%
% [3] http://mathworld.wolfram.com/MeanAbsoluteDeviation.html
% [4] Kenney, J. F. and Keeping, E. S. "Mean Absolute Deviation." §6.4 in Mathematics of Statistics, Pt. 1, 3rd ed. Princeton, NJ: Van Nostrand, pp. 76-77 1962. 

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

%	Version 1.23;	07 Jun 2002
%	Copyright (C) 2000-2002 by Alois Schloegl <a.schloegl@ieee.org>

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin==1,
  DIM= min(find(size(i)>1, 'first'));
  if isempty(DIM), 
    DIM=1; 
  end;
end;

%% 
% check arguments

checkArgument(i, 'i', 'double', '1st');
isN(DIM, 'DIM', 2);

%%

[S,N] = sumskipnan(i,DIM);		% sum
i     = i - repmat(S./N,size(i)./size(S));		% remove mean
[S,N] = sumskipnan(abs(i),DIM);		% 

%if flag_implicit_unbiased_estim;    %% ------- unbiased estimates ----------- 
    n1 	= max(N-1,0);			% in case of n=0 and n=1, the (biased) variance, STD and STE are INF
%else
%    n1	= N;
%end;

R     = S./n1;

%%


