%% Syntax
%       hasMWS= hasModelWorkspace(simulink_window)
%
%% Description
% |hasMWS= hasModelWorkspace(simulink_window)| returns 1, if the Simulink
% window |simulink_window| has a <matlab:doc('Simulink.ModelWorkspace')
% model workspace>, else 0. 
%
%%
% @param |simulink_window| : char defining the name of the Simulink window
%
%%
% @return |hasMWS| : double scalar
%
% * 1, if |simulink_window| has a model workspace
% * 0, else
%
%% Example
% 
% If no model is loaded, then return 0.

hasModelWorkspace(bdroot)

%%
%

% create a new Simulink system
new_system('test');

hasModelWorkspace(bdroot)

% close the model again without saving
close_system('test', 0);

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('get_param')">
% matlab/get_param</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% 
% and is called by:
%
% -
%
%% See Also
% 
% <html>
% <a href="evalinmws.html">
% script_collection/evalinMWS</a>
% </html>
% ,
% <html>
% <a href="assigninmws.html">
% script_collection/assigninMWS</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('bdroot')">
% matlab/bdroot</a>
% </html>
%
%% TODOs
% # create documentation for script file
%
%% <<AuthorTag_DG/>>


