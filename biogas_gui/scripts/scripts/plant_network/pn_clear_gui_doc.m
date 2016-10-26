%% Syntax
%       handles= pn_clear_gui(handles)
%
%% Description
%
% |handles= pn_clear_gui(handles)| removes button |togConnect|,
% |lblFermenterIn| and |lblFermenterOut| from gui. Then sets
% |frmPlantNetwork| to invisible and |cmdSave| to disabled. 
%
%%
% @param |handles| : handle of the gui
%
%%
% @return |handles| : changed handle of the gui
%
%% Example
% 
% 

pn_clear_gui();

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/rmfield">
% matlab/rmfield</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="pn_cmdload_callback.html">
% pn_cmdLoad_Callback</a>
% </html>
% ,
% <html>
% <a href="pn_cmdloadplant_callback.html">
% pn_cmdLoadPlant_Callback</a>
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


