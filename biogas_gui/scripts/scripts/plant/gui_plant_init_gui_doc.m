%% Syntax
%       handles= gui_plant_init_gui(handles)
%       handles= gui_plant_init_gui(handles, b_load_file)
%       handles= gui_plant_init_gui(handles, b_load_file, plant_id)
%
%% Description
% Is called by |gui_plant_OpeningFcn| and |but_fileselect_Callback|.
%
% Loads plant or not. Creates lists for fermenters and CHPs.
%
%%
% @param |handles| : handle of GUI, double scalar
%
%%
% @param |b_load_file| : if 1, then read plant out of file given in |handles|
% structure. If 0, then do not read plant, then we assume plant is already
% saved inside |handles| structure.
%
%%
% @param |plant_id| : char with the ID of the plant, not used at the
% moment!!!
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="gui_plant_delete_fnc.html">
% gui_plant_delete_fnc</a>
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
% <a href="gui_plant.html">
% gui_plant</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="gui_plant_createfermenterbtngroup.html">
% gui_plant_createFermenterBtnGroup</a>
% </html>
%
%% TODOs
% # improve dcumentation significantly
% # check code
%
%% <<AuthorTag_CE/>>


