%% Syntax
%       toolName= getNameOfToolbox(tool_id)
%
%% Description
% |toolName= getNameOfToolbox(tool_id)| returns the name of the toolbox.
% Therefore calls |getToolboxName| method of |gecoc_tool| class derivative of
% the given toolbox |tool_id|. May only be called inside the entry path of
% the given toolbox. Starting from that path it <matlab:doc('cd') changes>
% to the subfolder |scripts/tool| where a child class of the |gecoc_tool|
% class should exist. In case the <matlab:doc('gecoc_tool_def')
% gecoc_tool_def> is not installed yet (the setup_tool toolbox is installed
% before the gecoc_tool_def toolbox) you have to specify the path to the
% |gecoc_tool_def| release folder using the opened <matlab:doc('uigetdir')
% uigetdir>. The subfolder |scripts| of this selected folder would then be
% added to the MATLAB path temporarily. 
%
%%
% @param |tool_id| : ID of toolbox, char
%
%%
% @return |toolName| : char with the name of the toolbox.
%
%% Example
%
% If the current directory (<matlab:doc('pwd') pwd>) is the path to the
% entry folder of the setup_tool toolbox, then you can call the function
% like this
%

try
  getNameOfToolbox('setup_tool')
catch ME
  disp(ME.message);
end

%%
%
% change to a different folder

cd('..')

try
  getNameOfToolbox('setup_tool')
catch ME
  disp(ME.message);
end

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('pwd')">
% matlab/pwd</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('cd')">
% matlab/cd</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('addpath')">
% matlab/addpath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('uigetdir')">
% matlab/uigetdir</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('msgbox')">
% matlab/msgbox</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="install_setup_tool.html">
% setup_tool/install_setup_tool</a>
% </html>
%
%% See Also
%
% <html>
% <a href="install_tool.html">
% setup_tool/install_tool</a>
% </html>
% ,
% <html>
% <a href="setpath_tool.html">
% setup_tool/setpath_tool</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


