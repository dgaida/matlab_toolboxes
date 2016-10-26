%% Syntax
%       pn_cmdLoad_Callback(hObject, eventdata, handles)
%
%% Description
% |pn_cmdLoad_Callback(hObject, eventdata, handles)| executes on button
% press in cmdLoad of <gui_plant_network.html gui_plant_network>. A
% <matlab:doc('uigetfile') uigetfile> dialog is shown where the user can
% select a |plant_network_...mat| file. This is then load and the functions
% <matlab:doc('pn_clear_gui') pn_clear_gui> and
% <matlab:doc('pn_createnetworkpanel') pn_createNetworkPanel> are called. 
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

pn_cmdLoad_Callback()

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="pn_clear_gui.html">
% pn_clear_gui</a>
% </html>
% ,
% <html>
% <a href="pn_createnetworkpanel.html">
% pn_createNetworkPanel</a>
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
% <a href="gui_plant_network.html">
% gui_plant_network.fig</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="gui_plant_network.html">
% gui_plant_network</a>
% </html>
% ,
% <html>
% <a href="pn_cmdsave_callback.html">
% pn_cmdSave_Callback</a>
% </html>
% ,
% <html>
% <a href="pn_cmdnew_callback.html">
% pn_cmdNew_Callback</a>
% </html>
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


