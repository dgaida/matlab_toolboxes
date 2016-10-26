%% Syntax
%       [el, index]= get_nearest_el_in_vec(vec, el, before_after)
%       
%% Description
% |[el, index]= get_nearest_el_in_vec(vec, el, before_after)| gets element
% out of vector |vec| nearest to value of |el|. 
%
%%
% @param |vec| : a 1d array
%
%%
% @param |el| : a scalar
%
%%
% @param |before_after| : char
%
% * 'before' : returns the element of vector |vec| which is smaller or
% equal to |el|, but nearest to |el|. 
% * 'after' : returns the element of vector |vec| which is larger or
% equal to |el|, but nearest to |el|. 
% * 'abs' : returns element of vector |vec| which is nearest to given
% value |el|, measured by distance. 
%
%%
% @return |el| : an element of vector |vec| nearest to parameter |el|.
%
%%
% @return |index| : index of returned |el| in parameter |vec|. 
%
%% Example
% 
% Returns the value which is nearest to 1 but smaller than 1, thus the 3rd
% element 0.34 

vec= [-1 0.1 0.34 2 5 34.1];

el= 1;

[el, index]= get_nearest_el_in_vec(vec, el, 'before');

disp(el)
disp(index)

%%
% Returns the value which is nearest to 1 but larger than 1, thus the 4th
% element 2

el= 1;

[el, index]= get_nearest_el_in_vec(vec, el, 'after');

disp(el)
disp(index)

%%

el= 0.34;

[el, index]= get_nearest_el_in_vec(vec, el, 'before');

disp(el)
disp(index)

%%

el= 0.341;

[el, index]= get_nearest_el_in_vec(vec, el, 'after');

disp(el)
disp(index)

%%
% Here the element is returned which is nearest to 0.341, which is the 3rd
% element 0.34 (does not matter whether it is larger or smaller)

el= 0.341;

[el, index]= get_nearest_el_in_vec(vec, el, 'abs');

disp(el)
disp(index)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc matlab/validatestring">
% matlab/validatestring</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/sort">
% matlab/sort</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc script_collection/integrate_data">
% script_collection/integrate_data</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc script_collection/get_index_of_el_in_vec">
% script_collection/get_index_of_el_in_vec</a>
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

    
    