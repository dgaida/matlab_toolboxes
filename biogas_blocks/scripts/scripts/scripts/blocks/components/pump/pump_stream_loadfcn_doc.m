%% Syntax
%       pump_stream_loadfcn()
%       pump_stream_loadfcn(DEBUG_DISP)
%
%% Description
% |pump_stream_loadfcn()| loads the pump stream model by creating
% the dropdown menus of the block's mask. The function is called by the
% 'pump stream (Energy)' block in the LoadFcn Callback.
%
%%
% |pump_stream_loadfcn(DEBUG_DISP)| additionally displays messages, if
% DEBUG_DISP == 1; DEBUG_DISP == 0, is the default
%
%%
% @param |DEBUG_DISP| : 0 or 1
%
% * 0 : does not display messages. default. 
% * 1 : displays messages
%
%% Example
% 
%

pump_stream_loadfcn()


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_blocks/createfermenterpopup')">
% createfermenterpopup</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/createinitstatetypepopup')">
% createinitstatetypepopup</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/createdatasourcetypepopup')">
% createdatasourcetypepopup</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/createvolumeflowtypepopup')">
% createvolumeflowtypepopup</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/get_param_error')">
% script_collection/get_param_error</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/get_param')">
% matlab/get_param</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/set_param_tc')">
% script_collection/set_param_tc</a>
% </html>
%
% and is called by:
%
% <html>
% (pump stream block)
% </html>
% ,
% <html>
% <a href="pump_stream_init_comm.html">
% pump_stream_init_comm</a>
% </html>
%
%% See Also
%
% <html>
% <a href="pump_stream.html">
% pump_stream</a>
% </html>
% ,
% <html>
% <a href="pump_stream_closefcn.html">
% pump_stream_closefcn</a>
% </html>
% ,
% <html>
% <a href="pump_stream_init_commands.html">
% pump_stream_init_commands</a>
% </html>
%
%% TODOs
% # check documentation
% # check code
%
%% <<AuthorTag_DG/>>


