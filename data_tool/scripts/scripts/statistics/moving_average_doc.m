%% Syntax
%     [Y, Nsum]= moving_average(X)
%     [Y, Nsum]= moving_average(X, F)
%     [Y, Nsum]= moving_average(X, F, DIM)
%
%% Description
% |[Y, Nsum]= moving_average(X, F, DIM)| smooths the vector |X| through the
% moving average method. 
%
% Quickly smooths the vector |X| by averaging each element along with the
% 2*|F| elements at its sides. The elements at the ends are also averaged 
% but the extrems are left intact. With the windows size defined in this
% way, the filter has zero phase. 
%
%%
% @param |X| : Vector or matrix of finite elements.
%
%%
% @param |F| : Window semi-length. A positive scalar (default 0).
%
%%
% @param |DIM| : If DIM=1: smooths the columns (default); elseif DIM=2 the
% rows. 
%
%%
% @return |Y| : Smoothed X elements.
%
%%
% @return |Nsum| : Number of not NaN's elements that fixed on the moving
% window. Provided to get a sum instead of a mean: Y.*Nsum.
%
%% Example
%

x = 2*pi*linspace(-1,1)'; 
yn = cos(x) + 0.25 - 0.5*rand(size(x)); 
ys = moving_average(yn,4);
plot(x,[yn ys]), legend('noisy','smooth',4), axis tight

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('flipud')">
% matlab/flipud</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('cumsum')">
% matlab/cumsum</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
%
%
%% See Also
%
% <html>
% <a href="moving_average2.html">
% data_tool/moving_average2</a>
% </html>
% ,
% <html>
% <a href="nanmoving_average.html">
% data_tool/nanmoving_average</a>
% </html>
% ,
% <html>
% <a href="nanmoving_average2.html">
% data_tool/nanmoving_average2</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/filter')">
% matlab/filter</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/rectwin')">
% matlab/rectwin</a>
% </html>
%
%%
% RUNMEAN by Jos van der Geest.
%
%% TODOs
% # improve documentation
% # understand script
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
%% <<AuthorTag_DG/>>
%% References
% <http://www.mathworks.com/matlabcentral/fileexchange/12276-moving-average-v3-1--mar-2008->
% 
%%
%   2008 Mar. Use CUMSUM as RUNMEAN by Jos van der Geest, no more
%   subfunctions.
%


