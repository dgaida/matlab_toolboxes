%% Syntax
%       tocfile= replace_entry(tocfile, tocrep, pos)
%
%% Description
% |tocfile= replace_entry(tocfile, tocrep, pos)| replaces given entry
% |tocrep| in the array |tocfile| at the given position |pos|. 
%
%%
% @param |tocfile| : some sort of array
%
%%
% @param |tocrep| : is inserted in the array at given position |pos|.
%
%%
% @param |pos| : position, integer >= 1
%
%%
% @return |tocfile| : |tocfile| with replacement
%
%% Example
%
% |replace_entry(tocfile, tocrep, pos)|
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc validateattributes">
% matlab/validateattributes</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="make_helptoc.html">
% make_helptoc</a>
% </html>
% ,
% <html>
% <a href="make_release_notes.html">
% make_release_notes</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="gettoolboxdevelopmentstatus.html">
% getToolboxDevelopmentStatus</a>
% </html>
% ,
% <html>
% <a href="make_helpfuncbycat.html">
% make_helpfuncbycat</a>
% </html>
%
%% TODOs
% # improve documentation
% # solve the TODOs in the script
% # 
%
%% <<AuthorTag_DG/>>


    