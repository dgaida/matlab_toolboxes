%% Syntax
%       date= getDateLastChangeOfScript(filename)
%       date= getDateLastChangeOfScript(filename, dateformat)
%
%% Description
% |date= getDateLastChangeOfScript(filename)| gets the date when the given
% script was changed last time and returns it. The format of the date is
% 'dd.mm.yyyy'. 
% 
%%
% @param |filename| : char with the filename to be checked. May be with
% full path or not. Anyway the file found by <matlab:doc('dir') dir> is
% used. 
%
%%
% @return |date| : char with the date of the time the given script was
% changed last time. 
%
%%
% |date= getDateLastChangeOfScript(filename, dateformat)| lets you specify
% the format of the date to be returned.
%
%%
% @param |dateformat| : char with the format of the date. Default:
% 'dd.mm.yyyy'. For more information on the format, see
% <matlab:doc('matlab/datestr') matlab/datestr>. 
%
%% Example
%
% 

getDateLastChangeOfScript('publish_toolbox.m')

%%
%

getDateLastChangeOfScript('make_helptoc.m', 'dd-mmm-yyyy')


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
% <a href="matlab:doc('dir')">
% matlab/dir</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('datestr')">
% matlab/datestr</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('doc_tool/replacetoolboxtagbytext')">
% doc_tool/replaceToolboxTagByText</a>
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


