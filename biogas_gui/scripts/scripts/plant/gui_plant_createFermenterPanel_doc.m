%% Syntax
%       handles= gui_plant_createFermenterPanel(handles)
%
%% Description
% |handles= gui_plant_createFermenterPanel(handles)| creates panel to edit
% fermenter params. Then calls <gui_plant_createfermenterbtngroup.html
% gui_plant_createFermenterBtnGroup> to create button groups. 
%
%%
% @param |handles| : handles structure
%
%%
% @return |handles| : updated handles structure
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="gui_plant_createfermenterbtngroup.html">
% gui_plant_createFermenterBtnGroup</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/uipanel')">
% matlab/uipanel</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/uicontrol')">
% matlab/uicontrol</a>
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
% <a href="cmdeditfermenters_callback.html">
% cmdEditFermenters_Callback</a>
% </html>
% ,
% <html>
% <a href="gui_plant_f_buttongroup_cbk.html">
% gui_plant_f_buttongroup_cbk</a>
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
% <a href="gui_plant_createfermenterbtngroup.html">
% gui_plant_createFermenterBtnGroup</a>
% </html>
%
%% TODOs
% # versuchen mit "isfield" die erstellung der felder zu unterbinden, damit
% beim wechsel im edit modus nicht immer alles neu erstellt werden, Gelöst
% # improve documentation
% # check code
%
%% <<AuthorTag_CE/>>


