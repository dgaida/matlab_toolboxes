%% Syntax
%       datetime= getToolboxBuild(toolbox)
%       datetime= getToolboxBuild(toolbox_id)
%       datetime= getToolboxBuild(toolbox_id, base_path)
%
%% Description
% |datetime= getToolboxBuild(toolbox)| returns the build date and time as
% double of the given |toolbox|. If the given toolbox is not installed yet,
% then an empty value is returned. The function searches for the file
% 'build_toolbox_id.txt' inside the base folder of the given toolbox. 
%
%%
% @param |toolbox| : object of the <matlab:doc('gecoc_tool') gecoc_tool> class. 
%
%%
% @return |datetime| : [] if toolbox does not exist. Else a numerical
% number defining the build date of the given toolbox. See the example. 
%
%%
% |datetime= getToolboxBuild(toolbox_id)| does the same. The only
% difference is, that the file 'build_toolbox_id.txt' is searched for in the complete
% MATLAB path. Can be used to check if the given tool is installed
% somewhere. 
%
%%
% @param |toolbox_id| : ID of the toolbox as char. Defined by the method
% <matlab:doc('gecoc_tool_def/gettoolboxid') gecoc_tool_def/getToolboxID>. 
%
%%
% |datetime= getToolboxBuild(toolbox_id, base_path)| searches only in the
% given path |base_path| for the file 'build_toolbox_id.txt'. Can be used to check
% whether the tool in the given path |base_path| has a newer or older
% version number as maybe an already installed version of the toolbox. 
%
%%
% @param |toolbox_id| : ID of the toolbox as char. 
%
%%
% @param |base_path| : path of the toolbox as char. 
%
%% Example
%
% 

build= getToolboxBuild(setup_tool);

age= now - build;

disp(datestr(age, 'dd HH:MM:SS'))

%%

build= getToolboxBuild('setup_tool');

age= now - build;

disp(datestr(age, 'dd HH:MM:SS'))

%%

build= getToolboxBuild('setup_tool', pwd);

age= now - build;

disp(datestr(age, 'dd HH:MM:SS'))


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('io_tool/file2cell')">
% io_tool/file2cell</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('gecoc_tool_def/gettoolboxpath')">
% gecoc_tool_def/getToolboxPath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('gecoc_tool_def/gettoolboxid')">
% gecoc_tool_def/getToolboxID</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('setup_tool/install_tool')">
% setup_tool/install_tool</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('setup_tool')">
% setup_tool</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('gecoc_tool_def')">
% gecoc_tool_def</a>
% </html>
%
%% TODOs
% # create documentation for script
% 
%% <<AuthorTag_DG/>>


