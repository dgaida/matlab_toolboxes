%% Syntax
%       handles= sn_clear_gui(handles)
%
%% Description
%
% |handles= sn_clear_gui(handles)| removes textfield |txtDistribution|,
% |lblSubstrate| and |lblFermenter| from gui. Then sets
% |frmSubstrateNetwork| to invisible and |cmdSave| to disabled. 
%
%%
% @param |handles| : handle of the gui
%
%%
% @return |handles| : changed handle of the gui
%
%% Example
% 
% 

sn_clear_gui()

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/rmfield">
% matlab/rmfield</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="sn_cmdload_callback.html">
% sn_cmdLoad_Callback</a>
% </html>
% ,
% <html>
% <a href="sn_cmdloadplant_callback.html">
% sn_cmdLoadPlant_Callback</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="gui_substrate_network.html">
% gui_substrate_network</a>
% </html>
% ,
% <html>
% <a href="sn_cmdsave_callback.html">
% sn_cmdSave_Callback</a>
% </html>
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


