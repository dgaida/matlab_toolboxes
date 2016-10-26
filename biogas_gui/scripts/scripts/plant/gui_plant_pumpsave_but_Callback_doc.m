%% Syntax
%       gui_plant_pumpsave_but_Callback(hObject, eventdata, handles)
%
%% Description
% Executes on button press on pumpsave, pumpcancel and pumpreset buttons on
% the right side in the pump edit mode. These are the buttons 'OK',
% 'Cancel' and 'Reset'. If Pressed 'OK', then data is saved in plant
% structure and the panel and all buttons and text fields are destroyed. If
% called 'Cancel' then also all buttons and text fields are destroyed. If
% clicked 'Reset' then original data out of plant structure is written into
% text fields, nothing is destroyed.
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
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
% <a href="cmdeditpump_callback.html">
% cmdEditPump_Callback</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="gui_plant.html">
% gui_plant</a>
% </html>
% ,
% <html>
% <a href="gui_plant_fermsave_but_callback.html">
% gui_plant_fermsave_but_Callback</a>
% </html>
% ,
% <html>
% <a href="gui_plant_delete_fnc.html">
% gui_plant_delete_fnc</a>
% </html>
% ,
% <html>
% <a href="gui_plant_createfermenterpanel.html">
% gui_plant_createFermenterPanel</a>
% </html>
%
%% TODOs
% # check code and documentation a little bit
%
%% <<AuthorTag_DG/>>


