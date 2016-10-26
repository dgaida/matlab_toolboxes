%% Syntax
%       adm1_closefcn(adm1_model)
%       adm1_closefcn(adm1_model, DEBUG_DISP)
%
%% Description
% |adm1_closefcn()| closes the ADM1DE model by resetting the dropdown menus
% of the block's mask to the library values. The function is called by the
% ADM1DE, ADM1xp and ADM1xp variable fXC blocks in 
% the ModelCloseFcn Callback. During the (Closing)
% finalization the block sets the selected value in the drop down menus
% back to the default entry of the library, which is 'Bitte ... wählen'.
% Otherwise the library would return an error since it does not know the
% other values selectable in the drop down menus, since they depend on the
% plant. The real selected value in the drop down menu is saved in the
% UserData of the block (this is also done in this function) and is read in
% the LoadFcn Callback (see <adm1_loadfcn.html
% |adm1_loadfcn|>).  
%
%%
% @param |adm1_model| : type of model
%
% * 'ADM1xp' for ADM1xp and ADM1xp variable fXC blocks
% * 'ADM1DE' for ADM1DE block
%
%%
% |adm1_closefcn(adm1_model, DEBUG_DISP)| additionally displays messages, 
% if DEBUG_DISP == 1; DEBUG_DISP == 0, is the default
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
% <a href="matlab:doc('biogas_blocks/createfermenterpopup')">
% createfermenterpopup</a>
% </html>
%
% and is called by:
%
% (CloseFcn Callback of adm blocks)
%
%% See Also
% 
% <html>
% <a href="ADM1DE.html">
% ADM1DE</a>
% </html>
% ,
% <html>
% <a href="adm1_loadfcn.html">
% adm1_loadfcn</a>
% </html>
%
%% TODOs
% # check documentation
% # check code
%
%% <<AuthorTag_DG/>>


