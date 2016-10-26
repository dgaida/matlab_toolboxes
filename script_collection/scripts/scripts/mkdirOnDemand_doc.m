%% Syntax
%       mkdirOnDemand(folder)
%       
%% Description
% |mkdirOnDemand(folder)| creates the given |folder| if it does not exist
% already calling <matlab:doc('mkdir') mkdir>. 
%
%%
% @param |folder| : char with path to a folder which will be created
%
%% Example
%
% make a new folder in the current path

mkdirOnDemand('new folder');

% clean up afterwards
if exist('new folder', 'dir')
  rmdir('new folder')
end

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc matlab/mkdir">
% matlab/mkdir</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/exist">
% matlab/exist</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
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
% # write documentation for script
%
%% <<AuthorTag_DG/>>


