%% Syntax
%       Callback_ADM1_gui(callback_id, adm1_model, plant, DEBUG)
%       Callback_ADM1_gui(callback_id, adm1_model, plant, DEBUG, DEBUG_DISP)
%
%% Description
% |Callback_ADM1_gui()| is called by the Callback entries of the ADM1DE and
% ADM1xp with GUI block. The behaviour of the function depends on the
% Callback type (callback_id).
%
%%
% @param |callback_id| : type of Callback
%
% * 'LoadFcn' : creates GUI of the block
% * 'InitFcn' : initialize the block by setting the mask and if |DEBUG ==
% 1|, then the digester gui is opened. 
% * 'StopFcn' : if |DEBUG == 1| then the digester GUI is closed
% * 'ModelCloseFcn' : saves the selected settings in the user data
%
%%
% @param |adm1_model| : type of model
%
% * 'ADM1xp' : former Simba block (does not exist anymore)
% * 'ADM1DE' : own C# implementation
%
%% <<plant/>>
%%
% @param |DEBUG| : 0 or 1
%
% * 0 : no digester GUI is shown
% * 1 : opens the digester GUI at the start of the simulation and closes it
% at the end
%
%%
% |Callback_ADM1_gui(callback_id, adm1_model, plant, DEBUG, DEBUG_DISP)|
% additionally displays messages, if 
% DEBUG_DISP == 1; DEBUG_DISP == 0, is the default
%
%%
% @param |DEBUG_DISP| : 0 or 1
%
% * 0 : default
% * 1 : displays additional messages for debugging
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc bdroot">
% matlab/bdroot</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/createinitstatetypepopup')">
% biogas_blocks/createinitstatetypepopup</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/adm1_with_gui_setmasks')">
% biogas_blocks/adm1_with_gui_setmasks</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/createdatasourcetypepopup')">
% biogas_blocks/createdatasourcetypepopup</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/createfermenterpopup')">
% biogas_blocks/createfermenterpopup</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/gui_digester_combi')">
% gui_digester_combi</a>
% </html>
%
% and is called by:
%
% (different Callbacks of 'adm' blocks with gui)
%
%% See Also
% 
% <html>
% <a href="adm1de.html">
% ADM1DE</a>
% </html>
% ,
% <html>
% <a href="adm1_loadfcn.html">
% adm1_loadfcn</a>
% </html>
% ,
% <html>
% <a href="adm1_closefcn.html">
% adm1_closefcn</a>
% </html>
%
%% TODOs
% # check documentation
% # check code
% # improve documentation
%
%% <<AuthorTag_DG/>>


