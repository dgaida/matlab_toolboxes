%% Syntax
%       [rel_path]= getRelPathToHTMLFile(toolbox, html_file)
%       [rel_path]= getRelPathToHTMLFile(toolbox, html_file, actual_path)
%
%% Description
% |[rel_path]= getRelPathToHTMLFile(toolbox, html_file)| tries to find the html file
% |html_file| and returns the relative path to the file with respect to the
% <matlab:doc('pwd') pwd>. If the file cannot be found, then the function
% tries to find the file with the extension '_doc.html', which is often
% used for help files of the toolbox. If this file cannot be found as well,
% then an empty value is returned.
%
%%
% @param |toolbox| : child class of <matlab:doc('gecoc_tool') gecoc_tool>
%
%%
% @param |html_file| : char with the filename of a html file, may contain
% path information, which is ignored
%
%%
% @return |rel_path| : char with the relative path to the given html file.
%
%%
% |[rel_path]= getRelPathToHTMLFile(toolbox, html_file, actual_path)| returns the
% relative path with respect to the given |actual_path|.
%
%%
% @param |actual_path| : char with the absolute path to a folder, to which
% the relative path should be given to
%
%% Example
%
%

getRelPathToHTMLFile(doc_tool, 'checklinksinxmlfile_doc.html')

%%
% 
%

getRelPathToHTMLFile(doc_tool, 'checklinksinxmlfile.html')


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="..\tool\gethelppath.html">
% doc_tool/getHelpPath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc regexp">
% doc regexp</a>
% </html>
% ,
% <html>
% <a href="matlab:doc exist">
% doc exist</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('setup_tool/rdir')">
% setup_tool/rdir</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/relativepath')">
% script_collection/relativepath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="checklinksinmfile.html">
% checkLinksInMfile</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="checkifinxmlfile.html">
% checkIfInXMLfile</a>
% </html>
%
%% TODOs
% # Add documentation for script file
%
%% <<AuthorTag_DG/>>


