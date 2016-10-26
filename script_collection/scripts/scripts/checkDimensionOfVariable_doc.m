%% Syntax
%       correct= checkDimensionOfVariable(variable, dimension)
%       correct= checkDimensionOfVariable(variable, dimension, varname) 
%       
%% Description
% |correct= checkDimensionOfVariable(variable, dimension)| prooves if the
% size of the variable |variable| is equal to the one given by |dimension|,
% in the meaning of |size(variable) == dimension|. If it is the same, then
% |correct|= 1, else |correct|= 0 and an error is thrown.
%
%%
% @param |variable| : an array of any class which has to be checked
%
%%
% @param |dimension| : a double vector which defines the expected size of
% |variable|. 
%
%%
% @return |correct| : if |size(variable) == dimension|, then |correct|= 1,
% else |correct|= 0.
%
%%
% |correct= checkDimensionOfVariable(variable, dimension, varname)| lets
% you pass the name of the 1st argument |variable|. Needed for display, in
% case an error is thrown. 
%
%%
% @param |varname| : name of the 1st parameter |variable|, char
%
%% Example
% 
% # This is ok:
%

checkDimensionOfVariable(ones(1,2), [1, 2])

%%
%
% # The other examples throw an error
%

try
  checkDimensionOfVariable({'1st', '2nd'}, [1, 3], 'test')
catch ME
  disp(ME.message);
end

%%
%

try
  checkDimensionOfVariable(ones(1,2), [1, 3, 2], 'test')
catch ME
  disp(ME.message);
end

%%
%

try
  checkDimensionOfVariable(ones(1,2,3), [1, 3, 5], 'test')
catch ME
  disp(ME.message);
end

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc size">
% matlab/size</a>
% </html>
% ,
% <html>
% <a href="matlab:doc error">
% matlab/error</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas/load_biogas_mat_files">
% biogas/load_biogas_mat_files</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc script_collection/is0or1">
% script_collection/is0or1</a>
% </html>
%
%% TODOs
% # create documentation for script file
%
%% <<AuthorTag_DG/>>

    
    