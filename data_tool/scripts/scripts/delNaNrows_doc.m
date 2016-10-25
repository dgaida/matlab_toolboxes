%% Syntax
%       [data]= delNaNrows(data)
%       [data, data2nd]= delNaNrows(data, data2nd)
%       [...]= delNaNrows(data, data2nd, delWhat)
%
%% Description
% |[data]= delNaNrows(data)| deletes rows out of matrix or column vector
% |data| that are completely NaN (see parameter |delWhat|). 
%
%%
% @param |data| : Data double matrix or column vector. 
%
%%
% @param |data2nd| : Data double matrix or vector. The rows that are
% deleted in |data| are also deleted in |data2nd|. Therefore, the number of
% rows in both variables have to be the same. Throws an error if number of
% rows are not the same. 
%
%%
% @param |delWhat| : Inf, NaN
%
% * NaN : rows that are completely NaN are deleted
% * Inf : rows that are completely Inf are deleted
%
%%
% @return |data| : Data double matrix or vector. Rows that were |delWhat|
% in the input parameter do not exist in this variable anymore. 
%
%%
% @return |data2nd| : Data double matrix or vector. Rows that were |delWhat|
% in the input parameter do not exist in this variable anymore. 
%
%% Example
%
% 

data= [1 2; 3 4; NaN NaN; 7 8];
data2= [1; 2; 3; 4];

[datanew, data2new]= delNaNrows(data, data2, NaN);

disp(datanew)
disp(data2new)

%%

data(3,:)= [Inf, Inf];

[datanew, data2new]= delNaNrows(data, data2, Inf);

disp(datanew)
disp(data2new)

%%

delNaNrows(data)

%%

data(3,:)= [Inf, 5];

[datanew, data2new]= delNaNrows(data, data2, Inf);

disp(datanew)
disp(data2new)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkdimensionofvariable')">
% script_collection/checkDimensionOfVariable</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/isnan')">
% matlab/isnan</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/isinf')">
% matlab/isinf</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('optimization_tool/simplexkriging')">
% optimization_tool/simplexKriging</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('ml_tool/evaluate_kriging')">
% ml_tool/evaluate_kriging</a>
% </html>
%
%% TODOs
% # create documentation for script file
% # check documentation
%
%% <<AuthorTag_DG/>>


