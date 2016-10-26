%% Syntax
%       sn_cmdLoad_Callback(hObject, eventdata, handles)
%
%% Description
%
% |sn_cmdLoad_Callback(hObject, eventdata, handles)| executes on button
% press in cmdLoad of <gui_substrate_network.html gui_substrate_network>. A
% <matlab:doc('uigetfile') uigetfile> dialog is shown where the user can
% select a |substrate_network_...mat| file. This is then load and the functions
% <matlab:doc('sn_clear_gui') sn_clear_gui> and
% <matlab:doc('sn_createnetworkpanel') sn_createNetworkPanel> are called. 
%
%%
% @param |hObject| : 
%
%%
% @param |eventdata| : 
%
%%
% @param |handles| : handle of the gui
%
%% Example
% 
% 

sn_cmdLoad_Callback()

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="sn_clear_gui.html">
% sn_clear_gui</a>
% </html>
% ,
% <html>
% <a href="sn_createnetworkpanel.html">
% sn_createNetworkPanel</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('getconfigpath')">
% getConfigPath</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="gui_substrate_network.html">
% gui_substrate_network.fig</a>
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


