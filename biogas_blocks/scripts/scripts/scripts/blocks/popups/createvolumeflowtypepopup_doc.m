%% Syntax
%       createvolumeflowtypepopup(id_volumeflowtype, init)
%       
%% Description
% |createvolumeflowtypepopup()| creates a popupmenu for selecting the type 
% of volumeflow data (const, random, ...) via the current block's mask. It
% evaluates the variable |volumeflowtypes| in the modelworkspace of the
% current block <matlab:doc('gcb') gcb> using
% <matlab:doc('script_collection/evalinmws') script_collection/evalinMWS>.
% On error out of the base workspace using <matlab:doc('evalin') evalin>. 
% It generates the content of the popupmenu out of the content of this file
% and sets it to the MaskStyleString using <matlab:doc('set_param')
% set_param>. Furthermore reads UserData of the block and sets MaskValues
% to the saved value in UserData, but only if |init| is 1. The selected
% value is always saved inside UserData. 
%
%%
% @param |id_volumeflowtype| : id of where in the gui the volumeflowtype
% is located, starting with 1. Double, numeric.
%
%%
% @param |init| : double scalar. 
%
% * 0 : set to 0, when block is not called for the first time
% * 1 : set to 1, when block is called for the first time
%
%% Example
% 
%

createvolumeflowtypepopup(1, 0)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/evalinmws')">
% script_collection/evalinMWS</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('evalin')">
% matlab/evalin</a>
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
% <a href="matlab:doc('script_collection/get_param_error')">
% script_collection/get_param_error</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/set_param_tc')">
% script_collection/set_param_tc</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
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
% <a href="matlab:doc('biogas_blocks/pump_stream_loadfcn')">
% pump_stream_loadfcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/substrate_mixer_digester_loadfcn')">
% substrate_mixer_digester_loadfcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/substrate_source_loadfcn')">
% substrate_source_loadfcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/substrate_source_digester_loadfcn')">
% substrate_source_digester_loadfcn</a>
% </html>
%
%% See Also
%
% <html>
% <a href="createfermenterpopup.html">
% createfermenterpopup</a>
% </html>
% ,
% <html>
% <a href="createdatasourcetypepopup.html">
% createdatasourcetypepopup</a>
% </html>
% ,
% <html>
% <a href="createinitstatetypepopup.html">
% createinitstatetypepopup</a>
% </html>
% ,
% <html>
% <a href="creategas2bhkwsplittypepopup.html">
% creategas2bhkwsplittypepopup</a>
% </html>
% ,
% <html>
% <a href="createtimevaluepopup.html">
% createtimevaluepopup</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('set_param')">
% matlab/set_param</a>
% </html>
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


