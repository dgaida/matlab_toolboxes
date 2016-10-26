%% Syntax
%       createdatasourcetypepopup(id_datasourcetype, init)
%       
%% Description
% |createdatasourcetypepopup()| creates a popupmenu for selecting the type
% of data source (file, workspace, ...) of system blocks. Is only called by
% the blocks, which need a datasource for state or substrate flow, no
% further usage. It evaluates the variable datasourcetypes in the
% modelworkspace of the current block <matlab:doc('gcb') gcb> using
% <matlab:doc('script_collection/evalinmws') script_collection/evalinMWS>.
% It generates the content of the popupmenu out of the content of this file
% and sets it to the MaskStyleString using <matlab:doc('set_param')
% set_param>. Furthermore reads UserData of the block and sets MaskValues
% to the saved value in UserData, but only if |init| is 1. The selected
% value is always saved inside UserData. 
%
%%
% @param |id_datasourcetype| : id of where in the gui the entry for the
% datasourcetype is located, starting with 1
%
%% 
% @param |init| : double. If 1, then the datasource entry of MaskValues is
% set to the saved UserData. No further use. 
%
% * 0 : set to 0, when block is not called for the first time
% * 1 : set to 1, when block is called for the first time
%
%% Example
% 
%

createdatasourcetypepopup(1, 0)


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
% <a href="matlab:doc('biogas_blocks/callback_adm1_gui')">
% Callback_ADM1_gui</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/adm1_loadfcn')">
% adm1_loadfcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/hydraulic_delay_loadfcn')">
% hydraulic_delay_loadfcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/pump_stream_loadfcn')">
% pump_stream_loadfcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/kalman_loadfcn')">
% kalman_loadfcn</a>
% </html>
% ,
% <html>
% ...
% </html>
%
%% See also
%
% <html>
% <a href="createfermenterpopup.html">
% createfermenterpopup</a>
% </html>
% ,
% <html>
% <a href="createvolumeflowtypepopup.html">
% createvolumeflowtypepopup</a>
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
% <a href="matlab:doc('get_param')">
% matlab/get_param</a>
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


