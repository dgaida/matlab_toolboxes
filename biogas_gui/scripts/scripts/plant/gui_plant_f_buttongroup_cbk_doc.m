%% Syntax
%       gui_plant_f_buttongroup_cbk(hObject,eventdata)
%
%% Description
% |gui_plant_f_buttongroup_cbk(hObject,eventdata)| is called as
% SelectionChange Callback of buttongroup on panel for 
% fermenter. Change is between general, heating and pumps.
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="gui_plant_createfermenterpanel.html">
% gui_plant_createFermenterPanel</a>
% </html>
% ,
% <html>
% <a href="gui_plant_createfermenterbtngroup.html">
% gui_plant_createFermenterBtnGroup</a>
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
% <a href="gui_plant_delete_fnc.html">
% gui_plant_delete_fnc</a>
% </html>
% ,
% <html>
% <a href="cmdeditfermenters_callback.html">
% cmdEditFermenters_Callback</a>
% </html>
%
%% TODOs
% # versuchen mit "isfield" die erstellung der felder zu unterbinden, damit
% beim wechsel im edit modus nicht immer alles neu erstellt werden, OK
% # pumps...
% # improve dcumentation
% # check code
%
%% <<AuthorTag_CE/>>


