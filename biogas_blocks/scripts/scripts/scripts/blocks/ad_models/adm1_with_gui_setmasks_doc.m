%% Syntax
%       error= adm1_with_gui_setmasks(id_fermenter)
%       error= adm1_with_gui_setmasks(id_fermenter, id_initstatetype,
%       id_datasourcetype, id_savestate) 
%
%% Description
% In der Funktion 'adm1_with_gui_setmasks' werden die Masken der Blöcke 
% (ADM1, ph, biogas, TS, etc, sensor) im combi block gesetzt, also je nachdem 
% welchen fermenter man aussen auswählt wird dieser an die innen liegenden
% blöcke durchgereicht.
%
%%
% |error= adm1_with_gui_setmasks(id_fermenter)|
%
%%
% @param |id_fermenter| : position of the element to specify the fermenter
% on the gui, starting with 1.
%
%%
% |error= adm1_with_gui_setmasks(id_fermenter, id_initstatetype,
%  id_datasourcetype, id_savestate)|
%
%%
% @param |id_initstatetype| : position of the element to specify the
% initstate type on the gui, starting with 1.
%
%%
% @param |id_datasourcetype| : position of the element to specify the
% datasource type on the gui, starting with 1.
%
%%
% @param |id_savestate| : position of the element to specify if the state
% of the block should be saved after the simulation on the gui, starting
% with 1. 
%
%%
% return errflag = 1, if an error occurs, else 0
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc find_system">
% matlab/find_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/getmatlabversion')">
% script_collection/getMATLABVersion</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="callback_adm1_gui.html">
% Callback_ADM1_gui</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="adm1de.html">
% ADM1DE</a>
% </html>
%
%% TODOs
% # check documentation
% # check code
%
%% <<AuthorTag_DG/>>


