%% Syntax
%       config_substrate_mixer_digester(substrate, plant)
%       config_substrate_mixer_digester(substrate, plant, DEBUG_DISP)
%
%% Description
% |config_substrate_mixer_digester(substrate, plant)| creates/deletes GoTo
% blocks inside Substrate Mixer (Digester) block. 
%
%%
% # Deletes Goto blocks for substrate mixes for fermenter if there are
% too many.
% # Sets the number of outputs for the Demux that splits feed upon
% digesters. 
% # Adds Goto blocks for each fermenter if there are too few.
% # Connects Demux outputs with Goto blocks.
%
%% <<substrate/>>
%% <<plant/>>
%%
% |config_substrate_mixer_digester(substrate, plant, DEBUG_DISP)|
% additionally displays messages, if |DEBUG_DISP| == 1; |DEBUG_DISP| == 0,
% is the default 
%
%%
% @param |DEBUG_DISP| : 0 or 1
%
% * 0 : does not display messages
% * 1 : displays messages
%
%% Example
%
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc find_system">
% matlab/find_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc delete_line">
% matlab/delete_line</a>
% </html>
% ,
% <html>
% <a href="matlab:doc add_block">
% matlab/add_block</a>
% </html>
% ,
% <html>
% <a href="matlab:doc add_line">
% matlab/add_line</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('gcb')">
% matlab/gcb</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('get_param')">
% matlab/get_param</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('set_param')">
% matlab/set_param</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="substrate_mixer_digester_init_commands.html">
% substrate_mixer_digester_init_commands</a>
% </html>
%
%% See Also
%
% <html>
% <a href="substrate_mixer_digester_loadfcn.html">
% substrate_mixer_digester_loadfcn</a>
% </html>
% ,
% <html>
% <a href="substrate_mixer_digester_closefcn.html">
% substrate_mixer_digester_closefcn</a>
% </html>
%
%% TODOs
% # improve documentation
% # go through code
%
%% <<AuthorTag_DG/>>


