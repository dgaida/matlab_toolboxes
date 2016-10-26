%% Syntax
%       exist_in_startup(toolbox_name)
%       [start_idx]= exist_in_startup(toolbox_name)
%       [start_idx, end_idx]= exist_in_startup(toolbox_name)
%       [start_idx, end_idx, doexist]= exist_in_startup(toolbox_name)
%
%% Description
% |[start_idx, end_idx, doexist]= exist_in_startup(toolbox_name)| checks
% whether an entry for the given toolbox, with name |toolbox_name|, does
% exist inside the <matlab:doc('matlab/startup') startup.m> file. If an
% entry exists, then |doexist| equals 
% 1 and |start_idx| and |end_idx| return the start and end linenumber of
% the entry, respectively. If no entry exists or the startup.m does not
% exist at all, then |doexist| is 0 and the other two returned values are
% empty. 
%
% If an entry inside startup.m does exist for the given toolbox, then we
% conclude that the given toolbox is already installed. The calling
% function <matlab:doc('setup_tool/install_tool') setup_tool/install_tool>
% then checks if the to be installed toolbox is newer than the already
% installed one. Only then the new toolbox is installed. 
%
%%
% @param |toolbox_name| : name of the toolbox for which is checked. the
% name of a toolbox is defined by the method |getToolboxName|, see the
% example. 
%
%%
% @return |start_idx| : line number where the entry begins. An entry always
% begins with the line |%%*** The following code was created by the toolbox
% ''%s'' ***|.  
%
%%
% @return |end_idx| : line number where the entry ends. An entry always
% ends with the line |%%*** ''%s'' ***|.  
%
%%
% @return |doexist| : 0 or 1
%
% * 0 : no entry of the given toolbox exists inside the startup.m file or
% the startup.m does not exist at all.
% * 1 : an entry for the given toolbox exists inside the startup.m file. 
%
%% Example
%
% Check whether an entry for the toolbox <matlab:doc('setup_tool')
% setup_tool> exists in the startup.m file. 

toolbox_name= setup_tool.getToolboxName();

[start_idx, end_idx, doexist]= exist_in_startup(toolbox_name);

fprintf('start_idx: %i\n', start_idx);
fprintf('end_idx: %i\n', end_idx);
fprintf('doexist: %i\n', doexist);

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
% <a href="matlab:doc('matlab/startup')">
% matlab/startup</a>
% </html>
%
%% TODOs
% # create documentation for script
% 
%% <<AuthorTag_DG/>>


