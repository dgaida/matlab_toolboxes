%% Syntax
%       [median_value, index]= median_index(A)
%       [median_value, index]= median_index(A, dim)
%
%% Description
% |[median_value, index]= median_index(A)| 
%
%%
% @param |A| : 
%
%%
% @param |dim| : 
%
%%
% @return |median_value| : double. 
%
%% Example
%
% 

A= [3 4 6 8; 1 2 4 4; 5 6 8 6; 5 6 8 8];

disp(A)

%%

[median_value, index]= median_index(A)

median(A)


%%

[median_value, index]= median_index(A, 2)

median(A, 2)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('median')">
% matlab/median</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('sortrows')">
% matlab/sortrows</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/find')">
% matlab/find</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
%
%% TODOs
% # improve documentation
% # create documentation for script file
%
%% <<AuthorTag_DG/>>


