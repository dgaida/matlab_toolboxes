%% Syntax
%       [yclass, my_bins, commentForPrinting]= mergeTooSmallClasses(dowhile,
%       yclass, my_bins) 
%       [...]= mergeTooSmallClasses(dowhile, yclass, my_bins, min_class_ub) 
%
%% Description
% |[yclass, my_bins, commentForPrinting]= mergeTooSmallClasses(dowhile, 
% yclass, my_bins)| merges neighbouring classes in the vector |yclass| if
% one of the two have too few elements. The original classification problem
% has |my_bins| classes, but if one or more classes are too small, less
% then 5 elements (see parameter: |min_class_ub|), then the returned
% classification problem has less classes (returned value in |my_bins|). 
%
%%
% @param |dowhile| : The function checks for too small classes in a
% <matlab:doc('while') do while> loop. If you do not want that the function
% does something at all, then set |dowhile| to 0, else 1.
%
% * 0 : the function does nothing
% * 1 : the function does as explained above
%
%%
% @param |yclass| : double vector containing the class numbers of a
% classification problem of real data. The number of elements inside the
% vector is equal to the number of elements in the dataset. The class
% numbers go from 0 to |my_bins| - 1. 
%
%%
% @param |my_bins| : number of classes of the classification problem.
% double scalar integer. 
%
%%
% @return |yclass| : the double vector |yclass| after too small classes
% were merged. 
%
%%
% @return |my_bins| : number of classes of the classification problem after
% too small classes were merged. double scalar integer. 
%
%%
% @return |commentForPrinting| : 1-dim cell-string which contains as many
% '*' as many classes were merged. 
%
%%
% |[...]= mergeTooSmallClasses(dowhile, yclass, my_bins, min_class_ub)|
%
%%
% @param |min_class_ub| : Lets you define the minimal number of elements
% that have to be in a class, such that it is not defined 'small'. Default:
% 5. 
%
%% Example
% 
%

my_bins= 10;

% random numbers from 0 to 9
yclass= randi(my_bins, 45, 1) - 1;

n_elements= histc(yclass, 0:my_bins - 1);
subplot(1,2,1)
bar(0:my_bins - 1, n_elements, 'BarWidth', 1);

[yclass, my_bins, commentForPrinting]= mergeTooSmallClasses(1, yclass, my_bins);

disp('my_bins: ')
disp(my_bins)
disp('commentForPrinting: ')
disp(commentForPrinting)

n_elements= histc(yclass, 0:my_bins - 1);
subplot(1,2,2)
bar(0:my_bins - 1, n_elements, 'BarWidth', 1);

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('histc')">
% matlab/histc</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="startmethodforstateestimation.html">
% startMethodforStateEstimation</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="startstateestimation.html">
% startStateEstimation</a>
% </html>
% ,
% <html>
% <a href="createstateestimator.html">
% createStateEstimator</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/startsvm')">
% ml_tool/startSVM</a>
% </html>
% ,
% <html>
% <a href="callrfforstateestimation.html">
% callRFforStateEstimation</a>
% </html>
% ,
% <html>
% <a href="callgerdaforstateestimation.html">
% callGerDAforStateEstimation</a>
% </html>
% ,
% <html>
% <a href="createtraintestdata.html">
% createTrainTestData</a>
% </html>
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


