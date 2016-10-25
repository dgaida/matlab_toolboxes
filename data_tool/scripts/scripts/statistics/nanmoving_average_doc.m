%%
% NANMOVING_AVERAGE   Moving average ignoring NaN's.
%
%%
%   Syntax:
%     [Y,Nsum] = nanmoving_average(X,F,DIM,INT);
%
%%
%   Input:
%     X   - Vector or matrix of finite elements.
%     F   - Window semi-length. A positive scalar.
%     DIM - If DIM=1: smooths the columns (default); elseif DIM=2 the rows.
%     INT - If INT=0: do not interpolates NaN's (default); elseif INT=1 do
%           interpolates.
%
%%
%   Output:
%     Y    - Smoothed X elements with/without interpolated NaN's.
%     Nsum - Number of not NaN's elements that fixed on the moving window.
%            Provided to get a sum instead of a mean: Y.*Nsum.
%
%%
%   Description:
%     Quickly smooths the vector X by averaging each element along with the
%     2*F elements at its sides ignoring NaN's. The elements at the ends
%     are also averaged but the extrems are left intact. With the windows
%     size defined in this way, the filter has zero phase. If all the 2*F+1
%     elements al NaN's, a NaN is return.
%
%% Example
%

x = 2*pi*linspace(-1,1); 
yn = cos(x) + 0.25 - 0.5*rand(size(x)); 
yn([5 30 40:43]) = NaN;
ys = nanmoving_average(yn,4);
yi = nanmoving_average(yn,4,[],1);
plot(x,yn,x,yi,'.',x,ys),  axis tight
legend('noisy','smooth','without interpolation',4)

%%
%   See also FILTER, RECTWIN, NANMEAN and MOVING_AVERAGE, MOVING_AVERAGE2,
%   NANMOVING_AVERAGE2 by Carlos Vargas
%
%%
% Copyright 2006-2008  Carlos Vargas, nubeobscura@hotmail.com
%	$Revision: 3.1 $  $Date: 2008/03/12 18:20:00 $
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
%%
%   2008 Mar. Use CUMSUM as RUNMEAN by Jos van der Geest, no more
%   subfunctions.
%
%% TODOs
% # make documentation
% # understand script
%

