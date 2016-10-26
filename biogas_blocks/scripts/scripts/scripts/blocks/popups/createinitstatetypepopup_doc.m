%% Syntax
%       createinitstatetypepopup(id_initstatetype, init)
%
%% Description
% |createinitstatetypepopup(id_initstatetype, init)|
% creates the dropdown menu for selecting the type of initial state of
% system blocks. Examples for the initial stateare 'user' or 'default'. It
% reads the variable 'initstatetypes' out of the modelworkspace using
% <matlab:doc('script_collection/evalinmws') evalinMWS>, on errpr
% out of the base workspace using <matlab:doc('evalin') evalin>, generates
% the content of the popupmenu and sets the content in setting the
% parameter 'MaskStyleString' using <matlab:doc('set_param') set_param>. If
% |init| == 1, then sets the parameter |MaskValues| to the saved
% |UserData|. At the end of the function |UserData| is set to the current
% |MaskValues|. 
%
%%
% @param |id_initstatetype| : index of the element on the mask which belongs to
% the initial state type of the block, starting with 1. Double, numeric. 
%
%%
% @param |init| : double scalar. 
%
% * 0 : set to 0, when block is not called for the first time
% * 1 : set to 1, when block is called for the first time
%
%% Example
%

createinitstatetypepopup(1, 0)

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
%
%% See Also
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
% <a href="createdatasourcetypepopup.html">
% createdatasourcetypepopup</a>
% </html>
% ,
% <html>
% <a href="creategas2bhkwsplittypepopup.html">
% creategas2bhkwsplittypepopup</a>
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


