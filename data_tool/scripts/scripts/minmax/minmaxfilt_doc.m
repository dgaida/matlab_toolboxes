%% Syntax
% SHORT CALL: [minimg maximg] = MINMAXFILT(A, window)
% 
% LONG CALL: [minimg maximg] = MINMAXFILT(A, window, outtype, shape)
%
%% Description
% PURPOSE: multi-dimensional min/max (erosion/dilatation) filtering
%
%%
%  INPUTS:
%   A: ND arrays, logical and all numeric classes are supported
%   WINDOW: size of the sliding window. The value must be >= 1
%           - scalar -> same window size will be scanned for all dimension
%           - [n1, ...,nd] -> define separate scan size for each dimension
%   OUTTYPE: ['both'], 'minmax', 'min', 'max'. If outtype is 'both' or
%            'minmax', both MIN and MAX arrays will be returned (in that
%            order). Otherwise MINMAXFILT returns only the requested array.
%   SHAPE: 'full' 'same' ['valid']
%       'full'  - (default) returns the full size arrays,
%       'same'  - returns the central part of the filtering output
%                 that is the same size as A.
%       'valid' - returns only those parts of the filter that are computed
%                 without the padding edges.
%  OUTPUTS:
%   minimg, maximg: filtered min/max arrays of same number of 
%   dimension as the input A. The size depends on SHAPE. If SHAPE is
%       - 'full', the size is size(A)+(WINDOW-1)
%       - 'same', the size is size(A)
%       - 'valid', the size is size(A)-WINDOW+1
%
% [MINIMG MAXIMG MINIDX MAXIDX] = MINMAXFILT(A, ...) returns the linear
% index arrays such that:
%       A(MINIDX) is equal to MINIMG and
%       A(MAXIDX) is equal to MAXIMG
%   
%  Note: if the data is complex, the imaginary part is ignored.
%
%% Example
%
%

%%%%%%%%
% 2D filtering
A=rand(1024);
win=[3 5];
tic
[minA maxA minidx maxidx] = minmaxfilt(A,win,'both','full');
toc

if ~isequal(minA,A(minidx)) || ~isequal(maxA,A(maxidx))
    fprintf('Something is wrong in ND indexing\n');
    keyboard;
end
    

for i=1:size(A,1)+win(1)-1
    idxi = max(1-win(1)+i,1):min(i,size(A,1));
    for j=1:size(A,2)+win(2)-1
        idxj = max(1-win(2)+j,1):min(j,size(A,2));
        Aij = A(idxi,idxj);
        a = min(Aij(:));
        b = max(Aij(:));
        if a~=minA(i,j) || b~=maxA(i,j)
            fprintf('Something is wrong in ND filter\n');
            keyboard
        end
    end
end


%%
%  Algorithm: Lemire's "STREAMING MAXIMUM-MINIMUM FILTER USING NO MORE THAN
%  THREE COMPARISONS PER ELEMENT" Nordic Journal of Computing, Volume 13,
%  Number 4, pages 328-339, 2006.
%
%%
% See also: minmaxfilt1, ordfilt2, medfilt2 (Image Processing Toolbox)
%
%%
% AUTHOR: Bruno Luong <brunoluong@yahoo.com>
% Contributor: Vaclav Potesil
%
%%
% HISTORY
%   Original: 12-Jul-2009
%   Last update:
%   20/Sep/2009, optional output runing min/max indexing
%                separated min/max and improved engines
%                correct a bug of crop indexes (reported by 
%                Vaclav Potesil)
%   22/Sep/2009, simplify code when handling same shape
%   01/Dec/2009, correct bug when win is scalar and A is vector
%
%% TODO
% # make the documentation
% # make an example
% # understand the script
% 


