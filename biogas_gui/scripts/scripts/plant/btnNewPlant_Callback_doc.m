%% Syntax
%       btnNewPlant_Callback(hObject, eventdata, handles)
%
%% Description
%
% |btnNewPlant_Callback(hObject, eventdata, handles)| executes on button
% press in btnNewPlant of <gui_plant.html gui_plant> and creates a new
% plant. Shows an <matlab:doc('inputdlg') inputdlg> which lets you specify
% ID and name of the plant, then creates a new empty plant and saves it in
% |handles.workspace|. Then the following three functions are called:
%
% * <gui_plant_delete_fnc.html gui_plant_delete_fnc>
% * <gui_plant_init_gui.html gui_plant_init_gui>
% * <gui_plant_enable_elements.html gui_plant_enable_elements>
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
% <a href="matlab:doc('inputdlg')">
% matlab/inputdlg</a>
% </html>
% ,
% <html>
% <a href="gui_plant_delete_fnc.html">
% gui_plant_delete_fnc</a>
% </html>
% ,
% <html>
% <a href="gui_plant_init_gui.html">
% gui_plant_init_gui</a>
% </html>
% ,
% <html>
% <a href="gui_plant_enable_elements.html">
% gui_plant_enable_elements</a>
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
% <a href="cmdsaveas_callback.html">
% cmdSaveAs_Callback</a>
% </html>
%
%% TODOs
% # improve documentation a little
%
%% <<AuthorTag_DG/>>


