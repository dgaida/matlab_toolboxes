%% Syntax
%       index= get_index_of_el_in_vec(vec, el)
%       
%% Description
% |index= get_index_of_el_in_vec(vec, el)| gets the index of given element
% |el| in the given vector |vec|. If elements in vector |vec| are not
% unique, then an error is thrown and if |el| cannot be found in |vec| then
% an error is thrown as well. 
%
%%
% @param |vec| : a 1d array or a cellstr. 
%
%%
% @param |el| : a scalar or a char
%
%%
% @return |index| : 1-based index of |el| in |vec|. 
%
%% Example
% 
% # The number 4 is the 3rd element in the vector

get_index_of_el_in_vec([1 3 4 7 2 0], 4)

%%
% this throws an error because there are two 1s in the vector. Thus
% position of 1 in vector is not unique. 

try
  get_index_of_el_in_vec([1 3 4 7 2 1], 1)
catch ME
  disp(ME.message)
end

%%
% 5 is not an element in the given vector

try
  get_index_of_el_in_vec([1 3 4 7 2 0], 5)
catch ME
  disp(ME.message)
end

%%

get_index_of_el_in_vec({'A', 'B', 'C'}, 'B')

%%
% position of 'A' is not unique in the vector. 1st or 4th?

try
  get_index_of_el_in_vec({'A', 'B', 'C', 'A'}, 'A')
catch ME
  disp(ME.message)
end

%%
% 'D' is not element of the cellstr.

try
  get_index_of_el_in_vec({'A', 'B', 'C'}, 'D')
catch ME
  disp(ME.message)
end

%%
% you can use the function also for double floating point numbers, but be
% careful, because we work with == here.

get_index_of_el_in_vec([1.23 3 4.450 7 2.43 0]', 4.45)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc matlab/unique">
% matlab/unique</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/strfind">
% matlab/strfind</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/max">
% matlab/max</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
%
% <html>
% <a href="matlab:doc script_collection/get_nearest_el_in_vec">
% script_collection/get_nearest_el_in_vec</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/insert_in_vec">
% script_collection/insert_in_vec</a>
% </html>
%
%% TODOs
% # create documentation for script file
% # check documentation
% # improve documentation
%
%% <<AuthorTag_DG/>>

    
    