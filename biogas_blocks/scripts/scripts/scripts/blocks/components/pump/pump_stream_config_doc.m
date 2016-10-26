%% Syntax
%       pump_stream_config()
%
%% Description
% |pump_stream_config| configures the block Pump Stream (Energy). Is called
% by pump_stream. It adds and deletes blocks in the pump stream block. E.g.
% it adds/deletes and connects the hydraulic delay block if needed.
% Frthermore, if data source is extern, then an input is added. 
%
%% Example
% 
%

pump_stream_config()


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('matlab/delete_line')">
% matlab/delete_line</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/delete_block')">
% matlab/delete_block</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/add_line')">
% matlab/add_line</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/add_block')">
% matlab/add_block</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/find_system')">
% matlab/find_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/get_param')">
% matlab/get_param</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="pump_stream_init_commands.html">
% pump_stream_init_commands</a>
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
% <a href="matlab:doc('biogas_blocks/pump_stream_eval_loop_check')">
% biogas_blocks/pump_stream_eval_loop_check</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/pump_stream_setmasks')">
% biogas_blocks/pump_stream_setmasks</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/pump_stream_loadfcn')">
% biogas_blocks/pump_stream_loadfcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/pump_stream_closefcn')">
% biogas_blocks/pump_stream_closefcn</a>
% </html>
%
%% TODOs
% # improve documentation a bit
% # check code
%
%% <<AuthorTag_DG/>>


