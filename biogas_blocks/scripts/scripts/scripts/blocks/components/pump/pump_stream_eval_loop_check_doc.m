%% Syntax
%       pump_stream_eval_loop_check(id_checkbox)
%
%% Description
% |pump_stream_eval_loop_check(id_checkbox)| evaluates the checkbox on the
% pump stream gui that adds/deletes a hydraulic delay. If a hydraulic
% delay is added, additional parameters of the hydraulic delay on the gui
% are shown, if not they are not shown. 
%
%%
% @param |id_checkbox| : position number of the checkbox element for the
% hydraulic delay on the block's mask, starting with 1. 
%
%% Example
%
%

pump_stream_eval_loop_check(3)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/set_param_tc')">
% script_collection/set_param_tc</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/get_param')">
% matlab/get_param</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
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
% <a href="matlab:doc('biogas_blocks/pump_stream_loadfcn')">
% biogas_blocks/pump_stream_loadfcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/pump_stream_init_commands')">
% biogas_blocks/pump_stream_init_commands</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/pump_stream_config')">
% biogas_blocks/pump_stream_config</a>
% </html>
% ,
% <html>
% <a href="pump_stream_closefcn.html">
% pump_stream_closefcn</a>
% </html>
%
%% TODOs
% # check documentation
%
%% <<AuthorTag_DG/>>


