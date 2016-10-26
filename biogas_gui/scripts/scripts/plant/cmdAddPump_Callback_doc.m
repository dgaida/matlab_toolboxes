%% Syntax
%       cmdAddPump_Callback(hObject, eventdata, handles)
%
%% Description
% |cmdAddPump_Callback(hObject, eventdata, handles)| executes on
% button press in cmdAddPump of <gui_plant.html gui_plant>. Adds the given
% pump, the user defines using an <matlab:doc('inputdlg') inputdlg> and
% updates the list of pumps calling <newpump.html newpump>. Before that
% checks the given Pump id, if it is valid and if it already exists. 
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
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="newpump.html">
% newpump</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('inputdlg')">
% matlab/inputdlg</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="gui_plant.html">
% gui_plant.fig</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="cmdaddfermenter_callback.html">
% cmdAddFermenter_Callback</a>
% </html>
% ,
% <html>
% <a href="cmdaddbhkw_callback.html">
% cmdAddBHKW_Callback</a>
% </html>
% ,
% <html>
% <a href="cmdsaveas_callback.html">
% cmdSaveAs_Callback</a>
% </html>
% ,
% <html>
% <a href="gui_plant.html">
% gui_plant</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


