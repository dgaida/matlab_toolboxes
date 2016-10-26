%% Syntax
%       pump_stream_closefcn()
%       pump_stream_closefcn(DEBUG_DISP)
%
%% Description
% |pump_stream_closefcn()| closes the pump stream model by resetting
% the dropdown menus of the block's mask. The function is called by the
% pump stream block in the ModelCloseFcn Callback. First selected values
% are saved in user data. 
%
%%
% |pump_stream_closefcn(DEBUG_DISP)| additionally displays messages, if
% DEBUG_DISP == 1; DEBUG_DISP == 0, is the default. 
%
%%
% @param |DEBUG_DISP| : not yet used
%
% * 0 : 
% * 1 : 
%
%% Example
% 
%

pump_stream_closefcn()


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
% (pump stream block)
%
%% See Also
%
% <html>
% <a href="pump_stream.html">
% pump_stream</a>
% </html>
% ,
% <html>
% <a href="pump_stream_loadfcn.html">
% pump_stream_loadfcn</a>
% </html>
% ,
% <html>
% <a href="pump_stream_config.html">
% pump_stream_config</a>
% </html>
% ,
% <html>
% <a href="pump_stream_setmasks.html">
% pump_stream_setmasks</a>
% </html>
% ,
% <html>
% <a href="pump_stream_init_comm.html">
% pump_stream_init_comm</a>
% </html>
%
%% TODOs
% # improve documentation a bit
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


