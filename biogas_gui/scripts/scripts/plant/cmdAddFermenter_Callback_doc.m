%% Syntax
%       cmdAddFermenter_Callback(hObject, eventdata, handles)
%
%% Description
%
% |cmdAddFermenter_Callback(hObject, eventdata, handles)| executes on
% button press in cmdAddFermenter of <gui_plant.html gui_plant>. Adds the
% given fermenter and updates the list of fermenters calling 
% <newfermenter.html newfermenter>. Before that
% checks the given fermenter id, if it is valid and if it already exists. 
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
% <a href="newfermenter.html">
% newfermenter</a>
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
%% <<AuthorTag_CE/>>


