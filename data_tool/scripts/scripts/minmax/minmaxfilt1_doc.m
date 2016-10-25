%% Syntax
% SHORT CALL: [minval maxval] = MINMAXFILT1(A, window)
% 
% LONG CALL: [minval maxval] = MINMAXFILT1(A, window, outtype, shape)
%
%% Description
% PURPOSE: one-dimensional min/max (running) filtering
%
%%
%  INPUTS
%   A: 1D array, logical and all numeric classes are supported
%   WINDOW: size of the sliding window. The value must be >= 1
%           - scalar -> same window size will be scanned for all dimension
%   OUTTYPE: ['both'], 'minmax', 'min', 'max'. If outtype is 'both' or
%            'minmax', both MIN and MAX arrays will be returned (in that
%            order). Otherwise MINMAXFILT1 returns only the requested array.
%   SHAPE: 'full' 'same' ['valid']
%       'full'  - (default) returns the full size arrays,
%       'same'  - returns the central part of the filtering output
%                 that is the same size as A.
%       'valid' - returns only those parts of the filter that are computed
%                 without the padding edges.
%  OUTPUTS
%   minval, maxval: filtered min/max arrays of same number of 
%   dimension as the input A. The size depends on SHAPE. If SHAPE is
%       - 'full', the size is size(A)+(WINDOW-1)
%       - 'same', the size is size(A)
%       - 'valid', the size is size(A)-WINDOW+1
%
% [MINVAL MAXVAL MINIDX MAXIDX] = MINMAXFILT1(A, ...) returns index arrays
%   such that:
%       A(MINIDX) is equal to MINVAL and
%       A(MAXIDX) is equal to MAXVAL
%   
%  Note: if the data is complex, the imaginary part is ignored.
%
%% Example
%
%


%%%%%%%%%
% 1D filtering
n = 100;
w = 30;
for ntest=1:100
    A=uint8(ceil(rand(1,n)*100));
    [minA maxA] = minmaxfilt1(A, w, 'both', 'full');
    minAc = zeros(size(minA));
    maxAc = zeros(size(minA));
    for k=1:n+(w-1)
        Awin = A(max(k-w+1,1):min(k,end));
        minAc(k) = min(Awin);
        maxAc(k) = max(Awin);
    end
    if ~isequal(minAc,minA) || ~isequal(maxAc,maxA)
        fprintf('Something is wrong in 1D filter\n');
        keyboard;
    end        
end

clear


%%
%  Algorithm: Lemire's "STREAMING MAXIMUM-MINIMUM FILTER USING NO MORE THAN
%  THREE COMPARISONS PER ELEMENT" Nordic Journal of Computing, Volume 13,
%  Number 4, pages 328-339, 2006.
%
%%
% See also: minmaxfilt, ordfilt2, medfilt2 (Image Processing Toolbox)
%
%%
% AUTHOR: Bruno Luong <brunoluong@yahoo.com>
% Contributor: Vaclav Potesil
%
%%
% HISTORY
%   Original: 12-Jul-2009
%   20/Sep/2009, optional output runing min/max indexing
%                 use ND engine (to ease code maintenance)
%   22/Sep/2009, simplify code when handling same shape
%
%% TODO
% # make the documentation
% # make an example
% # understand the script
% 


