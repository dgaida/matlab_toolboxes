%% Syntax
%       substrate_mixer_digester_loadfcn()
%       substrate_mixer_digester_loadfcn(DEBUG_DISP)
%
%% Description
% |substrate_mixer_digester_loadfcn| loads the block Substrate Mixer
% (Digester), therefore the function is called in the LoadFcn Callback of
% the block. Thereby it creates the content of the
% drop down menus shown on the mask of the block calling
% <matlab:doc('biogas_blocks/createdatasourcetypepopup')
% createdatasourcetypepopup> and
% <matlab:doc('biogas_blocks/createvolumeflowtypepopup')
% createvolumeflowtypepopup>. If the block is already loaded, then does
% nothing. If it is not loaded yet, then, before calling the three functions
% listed above the MaskValues entries isbeingloaded is set to on and
% isbeingclosed to off. After the three functions have been called the
% MaskValue entries for isbeingloaded is set to off and isload to on. 
%
% Furthermore substrate_mixer_digester_init_commands are called. TODO, what
% do they do? 
%
% ATTENTION! This function may only be called once! This is why the
% checkboxes isload and isbeingloaded are used. 
%
% The function is also called in the MaskCallback 'Initialization Commands'
% of the Substrate Source Block, but only if the block is not loaded yet
% and not being load and not being closed at the moment. 
%
%%
% |substrate_mixer_digester_loadfcn(DEBUG_DISP)| additionally displays 
% messages, if DEBUG_DISP == 1; DEBUG_DISP == 0, is the default
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
% <a href="substrate_mixer_digester_init_commands.html">
% substrate_mixer_digester_init_commands</a>
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
% (LoadFcn Callback of substrate mixer (digester) block)
%
%% See Also
%
% <html>
% <a href="substrate_mixer_digester_closefcn.html">
% substrate_mixer_digester_closefcn</a>
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
% # improve documentation
% # why calling substrate_mixer_digester_init_commands in the end?
% # go through code
%
%% <<AuthorTag_DG/>>


