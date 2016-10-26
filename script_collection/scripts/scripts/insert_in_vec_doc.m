%% Syntax
%       vec= insert_in_vec(vec, el)
%       
%% Description
% |vec= insert_in_vec(vec, el)| inserts element |el| in vector |vec| at
% first available position in vector. A free space in |vec| is symbolized
% by a |NaN|. If no space in |vec| is available an error is thrown. 
%
%%
% @param |vec| : a 1d array
%
%%
% @param |el| : a scalar
%
%%
% @return |vec| : The vector with the inserted element
%
%% Example
% 
%

insert_in_vec([1 2 NaN NaN 4.5 NaN], 4)

%%

try
  insert_in_vec([1 3 4 7 2 1], 4)
catch ME
  disp(ME.message)
end

%%

myarr= NaN(2,2,3);

myarr(1,:,1)= insert_in_vec(myarr(1,:,1), 5);

myarr(:,2,2)= insert_in_vec(myarr(:,2,2), 6);
myarr(:,2,2)= insert_in_vec(myarr(:,2,2), 7);

try
  myarr(:,2,2)= insert_in_vec(myarr(:,2,2), 8);
catch ME
  disp(ME.message)
end

disp(myarr)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc matlab/isnan">
% matlab/isnan</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/numel">
% matlab/numel</a>
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
% <a href="matlab:doc script_collection/get_index_of_el_in_vec">
% script_collection/get_index_of_el_in_vec</a>
% </html>
%
%% TODOs
% # create documentation for script file
% # check documentation
% # improve documentation
%
%% <<AuthorTag_DG/>>

    
    