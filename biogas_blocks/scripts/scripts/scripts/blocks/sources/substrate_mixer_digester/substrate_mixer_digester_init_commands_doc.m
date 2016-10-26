%% Syntax
%       substrate_mixer_digester_init_commands()
%       substrate_mixer_digester_init_commands(DEBUG_DISP)
%
%% Description
% |substrate_mixer_digester_init_commands()| configures the blocks which
% this block contains. The function is called in the Mask Initialization
% Callback of the Substrate Mixer (Digester) block. It first loads the
% variables |substrate| and |plant| out of the modelworkspace and then
% calls <config_substrate_mixer_digester.html
% config_substrate_mixer_digester>. 
%
%%
% |substrate_mixer_digester_init_commands(DEBUG_DISP)| additionally 
% displays messages, if DEBUG_DISP == 1; DEBUG_DISP == 0, is the default
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
% <a href="config_substrate_mixer_digester.html">
% config_substrate_mixer_digester</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('get_param')">
% matlab/get_param</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('evalin')">
% matlab/evalin</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="substrate_mixer_digester_loadfcn.html">
% substrate_mixer_digester_loadfcn</a>
% </html>
% ,
% <html>
% Substrate Block
% </html>
%
%% See Also
%
% <html>
% <a href="substrate_mixer_digester_closefcn.html">
% substrate_mixer_digester_closefcn</a>
% </html>
%
%% TODOs
% # improve documentation a little
%
%% <<AuthorTag_DG/>>


