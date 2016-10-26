%% Syntax
%       substrate_mixer_digester_closefcn()
%       substrate_mixer_digester_closefcn(DEBUG_DISP)
%
%% Description
% |substrate_mixer_digester_closefcn()| closes the block 'Substrate Mixer
% (Digester)' and is called in its ModelCloseFcn Callback. During the
% (closing) finalization the block sets the checkbox isbeingclosed on the
% gui to 'on' to signalize that the model is being closed. Furthermore
% isload and isbeingloaded is set to 'off'. 
%
%%
% |substrate_mixer_digester_closefcn(DEBUG_DISP)| additionally displays 
% messages, if DEBUG_DISP == 1; DEBUG_DISP == 0, is the default
%
%%
% @param |DEBUG_DISP| : 0 or 1
%
% * 0 : default
% * 1 : displays debug messages
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc bdroot">
% matlab/bdroot</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('gcb')">
% matlab/gcb</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/get_param_error')">
% script_collection/get_param_error</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('get_param')">
% matlab/get_param</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/set_param_tc')">
% script_collection/set_param_tc</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
%
% and is called by:
%
% (CloseFcn Callback of substrate source (digester) block)
%
%% See Also
%
% <html>
% <a href="substrate_mixer_digester_loadfcn.html">
% substrate_mixer_digester_loadfcn</a>
% </html>
% ,
% <html>
% <a href="substrate_mixer_digester_init_commands.html">
% substrate_mixer_digester_init_commands</a>
% </html>
% ,
% <html>
% <a href="config_substrate_mixer_digester.html">
% config_substrate_mixer_digester</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('set_param')">
% matlab/set_param</a>
% </html>
%
%% TODOs
% # check if save_system is needed at the end of the function
% # go through code
% # check documentation
%
%% <<AuthorTag_DG/>>


