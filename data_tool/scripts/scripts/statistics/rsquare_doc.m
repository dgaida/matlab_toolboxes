%% Syntax
%        [r2 rmse] = rsquare(y,f)
%        [r2 rmse] = rsquare(y,f,c)
%
%% Description
% |[r2 rmse] = rsquare(y,f)| computes coefficient of determination of data
% fit model and RMSE. 
%
% RSQUARE computes the coefficient of determination (R-square) value from
% actual data Y and model data F. The code uses a general version of 
% R-square, based on comparing the variability of the estimation errors 
% with the variability of the original values. RSQUARE also outputs the
% root mean squared error (RMSE) for the user's convenience.
%
% Note: RSQUARE ignores comparisons involving NaN values.
% 
%%
% @param |y| : actual data
%
%%
% @param |f| : model fit
%
%%
% @return |r2| : Coefficient of determination
%
%% Example
% 
%

x = 0:0.1:10;
y = 2.*x + 1 + randn(size(x));
p = polyfit(x,y,1);
f = polyval(p,x);
[r2 rmse] = rsquare(y,f);
figure; plot(x,y,'b-');
hold on; plot(x,f,'r-');
title(strcat(['R2 = ' num2str(r2) '; RMSE = ' num2str(rmse)]))

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('isnan')">
% matlab/isnan</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('sum')">
% matlab/sum</a>
% </html>
%
% and is called by:
%
%
%
%% See Also
%
% <html>
% <a href="matlab:doc('std')">
% matlab/std</a>
% </html>
%
%% TODOs
% # improve documentation
% # understand script
%
%% Author & Copyright
% 
% Jered R Wells
% 11/17/11
% jered [dot] wells [at] duke [dot] edu
%
% v1.2 (02/14/2012)
%
% Thanks to John D'Errico for useful comments and insight which has helped
% to improve this code. His code POLYFITN was consulted in the inclusion of
% the C-option (REF. File ID: #34765).
%
%% <<AuthorTag_DG/>>


