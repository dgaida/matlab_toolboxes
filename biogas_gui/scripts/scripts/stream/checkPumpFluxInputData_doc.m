%% Syntax
%       [handles]= checkPumpFluxInputData(handles)
%       [handles, err_flag]= checkPumpFluxInputData(handles)
%
%% Description
% |[handles, err_flag]= checkPumpFluxInputData(handles)| checks all flux text
% fields on validity of GUI <set_input_stream.html set_input_stream>. If
% some value is not numeric or negative, then an error dialog appears and
% |err_flag| is returned with value 1. 
%
%%
% @param |handles| : handle of gui
%
%%
% @return |handles| : handle of gui
%
%%
% @return |err_flag| : on error returns 1, else 0
%
%% Example
%
% 
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="btnsave_callback.html">
% btnSave_Callback</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="set_input_stream.html">
% set_input_stream</a>
% </html>
%
%% TODOs
% # sprache des error dialogs ist noch in deutsch
%
%% <<AuthorTag_DG/>>


