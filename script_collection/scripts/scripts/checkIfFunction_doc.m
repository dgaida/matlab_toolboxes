%% Syntax
%       isfunction= checkIfFunction(filename)
%       
%% Description
% |isfunction= checkIfFunction(filename)| lets you check whether given
% |filename| is a MATLAB Function or a MATLAB Script. To do this the
% function searches for the keyword |function| in the file, which only may
% be preceded by whitespaces, but nothing else. If the char |filename| does
% not <matlab:doc('exist') exist>, then it is neither a function nor a
% script.  
%
%%
% @param |filename| : char containing the filename of a m-file, containing
% file extension '.m'. You may give the full path to the file, or if not,
% then the file must be in the current folder or on the MATLAB search path.
% 
%
%%
% @return |isfunction| : double scalar
%
% * 1 : if given |filename| is a MATLAB Function
% * 0 : if given |filename| is a MATLAB Script
% * -1 : if given |filename| is none of both
%
%% Preliminaries
% This function uses the <matlab:doc('io_tool') io_tool>. 
%
%% Example
% 
% this is a function

checkIfFunction('assigninMWS.m')

%%
% this is a script

checkIfFunction('assigninMWS_doc.m')

%%
% this is nothing

checkIfFunction('test')


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc io_tool/file2cell">
% io_tool/file2cell</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/strcmp">
% matlab/strcmp</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/strtrim">
% matlab/strtrim</a>
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
% <html>
% <a href="matlab:doc doc_tool/publish_toolbox">
% doc_tool/publish_toolbox</a>
% </html>
%
%% See Also
%
% -
%
%% TODOs
% # create documentation for script file
%
%% <<AuthorTag_DG/>>

    
    