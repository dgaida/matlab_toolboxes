%% Syntax
%       [filename, filename_2nd, filename_3rd, anyexist]= get_filenames(mfile)
%
%% Description
% |[filename, filename_2nd, filename_3rd, anyexist]= get_filenames(mfile)|
% returns the filename of a given file |mfile|. Usually only the path is
% chopped of; returned as |filename|. If the |mfile| is a class method, then
% it is a bit tricky to find the file using <matlab:doc('exist') exist>,
% because the class and package to which the method belongs must be known.
% What is happening is, that the folder in which the '_doc' 
% or script file is in, is assumed to be named after the class the
% method belongs to (always true for the script itself, often true for the
% '_doc' file). Returned as |filename_2nd|, if folder contains a '_doc',
% then its deleted from the returned folders name. 
% Furthermore as another suggestion the folder in which  
% this folder is in is named as the package the class is in. Returned as
% |filename_3rd|. 
% Using this strategy quite a lot of class methods are found but not all,
% but this is the best we can do at the moment. 
% 
%%
% @param |mfile| : char with the *.m filename to be checked. May be with
% full path or not. May also be the '_doc.m' file. 
%
%%
% @return |filename| : just the filename of the given file |mfile|.
% |filename| is always a script file, never a |_doc.m| file. 
%
%%
% @return |filename_2nd| : the filename including a suggestion for the class to
% which the script could belong. 
%
%%
% @return |filename_3rd| : the filename including a suggestion for the class
% and package to which the script could belong. 
%
%%
% @return |anyexist| : 0 or 1. If any of |mfile|, |filename|,
% |filename_2nd|, |filename_3rd| do <matlab:doc('exist') exist> a 1 is
% returned, else 0. 
%
%% Example
%
% 

[filename, filename_2nd, filename_3rd, anyexist]= get_filenames('make_helptoc.m');

disp(filename)
disp(filename_2nd)
disp(filename_3rd)
disp(anyexist)

%%

[filename, filename_2nd, filename_3rd, anyexist]= get_filenames(...
  'D:\wissMitarbeiter\mTools\doc_tool_1.1\scripts\tool\doc_tool_doc\getHelpPath_doc.m');

disp(filename)
disp(filename_2nd)
disp(filename_3rd)
disp(anyexist)

%%

[filename, filename_2nd, filename_3rd, anyexist]= get_filenames(...
  'D:\wissMitarbeiter\mTools\doc_tool_1.1\scripts\tool\@doc_tool\getHelpPath.m');

disp(filename)
disp(filename_2nd)
disp(filename_3rd)
disp(anyexist)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/checkArgument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('doc_tool/getscriptfileoffunction')">
% doc_tool/getScriptFileOfFunction</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('regexp')">
% matlab/regexp</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('exist')">
% matlab/exist</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('doc_tool/getheaderlinesofmfile')">
% doc_tool/getHeaderLinesOfMFile</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="publish_toolbox.html">
% publish_toolbox</a>
% </html>
%
%% TODOs
% # check documentation
%
%% <<AuthorTag_DG/>>


