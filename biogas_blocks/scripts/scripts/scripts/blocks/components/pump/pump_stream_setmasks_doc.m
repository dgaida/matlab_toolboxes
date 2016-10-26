%% Syntax
%       error= pump_stream_setmasks(id_fermenter_start, id_fermenter_destiny,
%       id_initstatetype, id_datasourcetype, id_savestate,
%       id_time_constant, id_V_min, id_initstatetype_delay,
%       id_datasourcetype_delay, id_savestate_delay,
%       id_time_constant_delay, id_V_min_delay) 
%
%% Description
% |error= pump_stream_setmasks(id_fermenter_start, id_fermenter_destiny,
% id_initstatetype, id_datasourcetype, id_savestate, id_time_constant,
% id_V_min, id_initstatetype_delay, id_datasourcetype_delay,
% id_savestate_delay, id_time_constant_delay, id_V_min_delay)| copies
% selected elements on mask of pump stream block to mask of inner hydraulic
% delay block. 
%
%%
% @param |id_fermenter_start| : position of element on mask of pump stream
% block where you can specify the digester where to pump from. Starting
% with 1. 
%
%%
% @param |id_fermenter_destiny| : position of element on mask of pump stream
% block where you can specify the digester where to pump to. Starting
% with 1. 
%
%%
% @param |id_initstatetype| : position of element on mask of pump stream
% block where you can specify the initial state type. Starting
% with 1. 
%
%%
% @param |id_datasourcetype| : position of element on mask of pump stream
% block where you can specify the datasource type. Starting
% with 1. 
%
%%
% @param |id_savestate| : position of element on mask of pump stream
% block where you can specify whether to save the final state of the
% hydraulic delay or not. Starting with 1. 
%
%%
% @param |id_time_constant| : position of element on mask of pump stream
% block where you can specify the time constant of the hydraulic delay.
% Starting with 1. 
%
%%
% @param |id_V_min| : position of element on mask of pump stream
% block where you can specify the minimal volume of the hydraulic delay.
% Starting with 1. 
%
%%
% @param |id_initstatetype_delay| : position of element on mask of
% hydraulic delay block where you can specify the initial state type of the
% hydraulic delay. Starting with 1. 
%
%%
% @param |id_datasourcetype_delay| : position of element on mask of
% hydraulic delay block where you can specify the datasource type.
% Starting with 1. 
%
%%
% @param |id_savestate_delay| : position of element on mask of hydraulic
% delay block where you can specify whether to save the final state of the
% hydraulic delay or not. Starting with 1. 
%
%%
% @param |id_time_constant_delay| : position of element on mask of
% hydraulic delay block where you can specify the time constant of the
% hydraulic delay. Starting with 1. 
%
%%
% @param |id_V_min_delay| : position of element on mask of pump stream
% block where you can specify the minimal volume of the hydraulic delay.
% Starting with 1. 
%
%%
% @return |error| : error = 1, if an error occurs, else 0
%
%% Example
%
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('matlab/find_system')">
% matlab/find_system</a>
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
% <a href="matlab:doc('biogas_blocks/pump_stream_init_commands')">
% biogas_blocks/pump_stream_init_commands</a>
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
% <a href="pump_stream_loadfcn.html">
% pump_stream_loadfcn</a>
% </html>
% ,
% <html>
% <a href="pump_stream_closefcn.html">
% pump_stream_closefcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/pump_stream_init_comm')">
% biogas_blocks/pump_stream_init_comm</a>
% </html>
%
%% TODOs
% # check and improve documentation
% # check code
% # solve TODO
%
%% <<AuthorTag_DG/>>


