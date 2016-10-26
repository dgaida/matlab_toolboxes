%% Syntax
%       gui_plant_fermsave_but_Callback(hObject, eventdata, handles)
%
%% Description
% Executes on button press on fermsave, fermcancel and fermreset buttons on
% the right side in the fermenter edit mode. These are the buttons 'OK',
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
%
% and is called by:
%
% <html>
% <a href="gui_plant_createfermenterbtngroup.html">
% gui_plant_createFermenterBtnGroup</a>
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
% <a href="gui_plant_bhkwsave_but_callback.html">
% gui_plant_bhkwsave_but_Callback</a>
% </html>
% ,
% <html>
% <a href="gui_plant_delete_fnc.html">
% gui_plant_delete_fnc</a>
% </html>
% ,
% <html>
% <a href="cmdeditfermenters_callback.html">
% cmdEditFermenters_Callback</a>
% </html>
% ,
% <html>
% <a href="gui_plant_createfermenterpanel.html">
% gui_plant_createFermenterPanel</a>
% </html>
% ,
% <html>
% <a href="gui_plant_f_buttongroup_cbk.html">
% gui_plant_f_buttongroup_cbk</a>
% </html>
%
%% TODOs
% # pumpen
% # einige frames sind noch nicht klar, ob diese existieren, scheint
% geklärt zu sein
% # improve dcumentation
% # check code
%
%% <<AuthorTag_CE/>>


