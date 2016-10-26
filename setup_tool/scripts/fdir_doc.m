%% Syntax
%       S= fdir(varargin)
%
%% Description
% |S= fdir(varargin)| returns a struct |S| containing all folders and
% subfolders within the specified directory, given by |varargin|, and total
% bytes within each folder. 
%
%%
% Note: Required function 'rdir' is available on Matlab File Exchange
% (rdir: File ID: #19550) Author: G. Brown
%
%%
% @param |varargin| : Syntax for varargin is the same for function
% <rdir.html rdir>. 
%
%%
% @return |S| : The struct |S| is sorted in descending order by total size
% in bytes. 
%
%% Examples
% 
% Return ordered struct of all folders and subfolders within the current
% directory with only keeping track of .m files
%

S= fdir('**\*.m');
disp(S)

%%
% Return ordered struct of all folders and subfolders containing .pdf
% files between a certain size, all within subdirectories M drive
% 

S= fdir('M:\**\*.pdf','bytes>1024 & bytes<1048576');
disp(S)

%%
% Return an ordered struct of all subdirectories within M and their sizes
% 

S= fdir('M:\**\*');
disp(S)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('setup_tool/rdir')">
% setup_tool/rdir</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/cellfun')">
% matlab/cellfun</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/accumarray')">
% matlab/accumarray</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/sort')">
% matlab/sort</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('setup_tool/getallsubfolders')">
% setup_tool/getAllSubfolders</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('setup_tool')">
% setup_tool</a>
% </html>
%
%% Author
%
%   Mike Sheppard
%   MIT Lincoln Laboratory
%   michael.sheppard@ll.mit.edu
%   Original: 19-Jan-2011
%
%% TODOs
% # improve documentation
% # understand script
%
%% <<AuthorTag_DG/>>


