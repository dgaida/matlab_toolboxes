%% Syntax
% SMOOTH_MAVERAGE   Smooths elements by moving average, ignoring NaN's.
%
%%
%   Syntax:
%     [Y,Nsum,IND] = smooth_maverage(X,Fr,Fc,IND);
%
%%
%   Input:
%     X   - Matrix with finite elements with/without Nan's.
%     Fr  - Window semi-length in the rows. A positive scalar (default 0).
%     Fc  - Window semi-length in the columns. A positive scalar (default
%           0). 
%     IND - Indicates de linear index of the elements to be smoothed.
%           By default it smooths the NaN's elements.  
%
%   Output:
%     Y    - X with the IND elements smoothed.
%     Nsum - Number of not NaN's elements that fixed on the moving window.
%            Provided to get a sum instead of a mean: Y(IND).*Nsum. Is a
%            vector of length equal as IND.
%     IND - Indicates de linear index of the elements that were smoothed.
%
%%
%   Description: 
%      This program interpolates the elements defined by IND or the NaN's
%      ones, by averaging it along with the surrounding elements that fit
%      on the little matrix of size (2Fr+1)x(2Fc+1) centered on it and
%      ignoring NaN's. It smooths also in the edges. If Fc is 0 or empty,
%      the smoothing will be done columnwise; rowwise with Fr is 0 or
%      empty. If Fc is not specified and X is a row vector, it will be
%      smoothed by Fr.
%
%% Example
%

x = round(rand(5)*10)
IND = [1 13 23 24]; 
x([1 13 17 23]) = NaN
smooth_maverage(x,1)
smooth_maverage(x,1,0,IND)
smooth_maverage(x,2,2,IND)
smooth_maverage(x,1,1)
smooth_maverage(x,[],1)

%%
%   See also NANMEAN on the Statistical Toolbox and NANMOVING_AVERAGE,
%   NANMOVING_AVERAGE2 by Carlos Vargas.
%
%%
% Copyright 2008  Carlos Vargas, nubeobscura@hotmail.com
%	$Revision: 1.0 $  $Date: 2008/03/04 11:00:00 $
%
%%
%   Written by
%   M. in S. Carlos Adrián Vargas Aguilera
%   Physical Oceanography PhD candidate
%   CICESE 
%   Mexico,  march 2008
%
%   nubeobscura@hotmail.com
%
%   Download from:
%   http://www.mathworks.com/matlabcentral/fileexchange/loadAuthor.do?objec
%   tType=author&objectId=1093874
%
%% TODOs
% # make documentation
% # understand code
%


