%% Syntax
%       save_varname(variable, variablename)
%       save_varname(variable, variablename, filename)
%       save_varname(variable, variablename, filename, silent)
%       
%% Description
% |save_varname(variable, variablename)| saves a variable with the given
% variablename in a mat file. The name of the mat file will be
% |variablename| as well, see parameter |filename|. 
%
% This function is useful when the parameter |variablename| is changing,
% e.g. in a for loop. If the |variable| has the same name as
% |variablename|, then just save it as: 
%
% |save(variablename, variable)|
%
%%
% @param |variable| : any data
%
%%
% @param |variablename| : char with the name of the |variable|
%
%%
% @param |filename| : char with the filename. Default: |[variablename,
% '.mat']| 
%
%%
% @param |silent| : 
%
% * 0 : <matlab:doc('script_collection/dispmessage')
% script_collection/dispMessage> is called when variable was successfully
% written to file, displaying a message
% * 1 : no message is displayed
%
%% Example
%
% # Easy example:
%

save_varname([1, 2, 3, 4, 6], 'mytest');

load('mytest.mat')

who

% clean up

delete('mytest.mat')

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc matlab/save">
% matlab/save</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/dispmessage">
% script_collection/dispMessage</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/is0or1">
% script_collection/is0or1</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_control/nmpc_append2volumeflow_user_sludgefile">
% biogas_control/NMPC_append2volumeflow_user_sludgefile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_control/nmpc_append2volumeflow_user_substratefile">
% biogas_control/NMPC_append2volumeflow_user_substratefile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/assign_initstate_inmws">
% biogas_scripts/assign_initstate_inMWS</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/createnewinitstatefile">
% biogas_scripts/createNewInitstatefile</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc biogas_scripts/save_initstate_to">
% biogas_scripts/save_initstate_to</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/who">
% matlab/who</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/load">
% matlab/load</a>
% </html>
% 
%% TODOs
% # make documentation for script file
%
%% <<AuthorTag_DG/>>


