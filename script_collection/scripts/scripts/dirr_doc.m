%% Syntax
%       [list]= dirr(path)
%       [list, bytes]= dirr(path)
%       [...]= dirr(path, filter)
%       [list, bytes, fieldout]= dirr(path, fieldin, ...)
%       [list, bytes, fieldout]= dirr(path, fieldin, filter, ...)
%
%% Description
% |[list] = dirr(path)| returns a structure |list| with the same fieldnames
% as returned by |list = dir(path)|, see: <matlab:doc('dir') matlab/dir>. 
%
%%
% @param |path| : can contain wildcards * and ? after the last \ or /
% (filename filter)
%
%%
% The content of each directory in |path| is listed inside its 'isdir'
% field with the same format. The 'bytes' field is NOT zero but the
% sum of all filesizes inside the directory.
% 
%%
% |[list,bytes] = dirr(path)|
% 
%%
% @return |bytes| : is a structure with fields 'total' and 'dir'. 'total'
% is the total size of |path|. 'dir' is a recursive substructure that
% contains the same fields ('total' and 'dir') for the subdirectories.
% 
%%
% |[...] = dirr(path,filter)| lists only files matching the string |filter|
% (non case sensitive regular expression).
% N.B.: |filter| is optional and must not be equal to a fieldname
% ('name' or 'date' ... will never be interpreted as filters)
% 
%%
% |[list,bytes,fieldout] = dirr(path,fieldin, ...)|
%
%%
% @param |fieldin| : is a string specifying a field (of the structure |list|) that
% will be listed in a separate cell array of strings in |fieldout| for
% every file with absolute path at the beginning of the string.
% Multiple fields can be specified.
% 
%%
% |[list,bytes,fieldout] = dirr(path,fieldin,filter, ...)|
% only files for which |fieldin| matches |filter| will be returned.
% Multiple |[fieldin, filter]| couples may be specified.
% Recursion can be avoided here by setting 'isdir' filter to '0'.
% For bytes, numeric comparison will be performed.
% 
%% Example
%
% dirr lists all files (including path) in the current directory and it's
% subdirectories recursively.
% 

dirr()

%%
% DIRR(fullfile(pwd, filesep, '*.m')) lists all M-files in the present
% working directory and it's subdirectories recursively.
% 

dirr(fullfile(pwd, filesep, '*.m'))

%%
% Music = DIRR('G:\Ma musique\&Styles\Reggae\Alpha Blondy')
% Returns a structure Music very similar to what DIR returns 
% but containing the information on the files stored in
% subdirectories of 'G:\Ma musique\&Styles\Reggae\Alpha Blondy'.
% The structure Music is a bit difficult to explore though.
% See next examples.
% 
%%
% [Files,Bytes,Names] = DIRR('c:\matlab6p5\toolbox','\.mex\>','name')
% Lists all MEX-files in the c:\matlab6p5\toolbox directory in the cell
% array of strings Names (including path).
% Note the regexp syntax of the filter string.
% Bytes is a structure with fields "total" and "dir". total is the
% total size of the directory, dir is a recursive substructure with
% the same fields as bytes for the subdirectories. 
% 
%%
% [Files,Bytes,Names] = DIRR('c:\toto'...
%       ,'name','bytes','>50000','isdir','0')
% Lists all files larger than 50000 bytes NOT recursively.
% 
%%
% [Files,Bytes,Dates] = DIRR('c:\matlab6p5\work','date','2005')
% Lists all dates of files from year 2005. (With path in front of
% date in the cell array of strings Dates)
% 
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc regexprep">
% matlab/regexprep</a>
% </html>
% ,
% <html>
% <a href="matlab:doc cd">
% matlab/cd</a>
% </html>
% ,
% <html>
% <a href="matlab:doc exist">
% matlab/exist</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc doc_tool/create_pcode">
% doc_tool/create_pcode</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc setup_tool/fdir">
% setup_tool/fdir</a>
% </html>
% ,
% <html>
% <a href="matlab:doc setup_tool/rdir">
% setup_tool/rdir</a>
% </html>
% ,
% <html>
% <a href="matlab:doc dir">
% matlab/dir</a>
% </html>
%
%% TODOs
% # check documentation
% # try to understand script
%
%% Author
% Maximilien Chaumon
%
% maximilien.chaumon@chups.jussieu.fr
%
%% <<AuthorTag_DG/>>


